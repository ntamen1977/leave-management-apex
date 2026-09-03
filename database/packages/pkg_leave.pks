
  CREATE OR REPLACE EDITIONABLE PACKAGE "LEAVE_APP"."PKG_LEAVE" AS

    FUNCTION calculate_days (
        p_start_date IN DATE,
        p_end_date   IN DATE
    ) RETURN NUMBER;

    FUNCTION get_available_balance (
        p_employee_id    IN NUMBER,
        p_leave_type_id  IN NUMBER,
        p_reference_year IN NUMBER
    ) RETURN NUMBER;

    PROCEDURE create_request (
        p_employee_id    IN NUMBER,
        p_leave_type_id  IN NUMBER,
        p_start_date     IN DATE,
        p_end_date       IN DATE,
        p_reason         IN VARCHAR2,
        p_created_by     IN VARCHAR2,
        p_request_id     OUT NUMBER
    );

    PROCEDURE submit_request (
        p_request_id IN NUMBER,
        p_employee_id IN NUMBER
    );


    PROCEDURE approve_request (
        p_request_id  IN NUMBER,
        p_approver_id IN NUMBER,
        p_comments    IN VARCHAR2
    );

    PROCEDURE reject_request (
    p_request_id  IN NUMBER,
    p_approver_id IN NUMBER,
    p_comments    IN VARCHAR2
);

END pkg_leave;
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "LEAVE_APP"."PKG_LEAVE" AS

    ----------------------------------------------------------------
    -- PROCEDURE PRIVEE : ECRITURE DANS L'AUDIT
    ----------------------------------------------------------------
    PROCEDURE write_audit (
        p_request_id  IN NUMBER,
        p_employee_id IN NUMBER,
        p_action      IN VARCHAR2,
        p_old_status  IN VARCHAR2,
        p_new_status  IN VARCHAR2,
        p_action_by   IN VARCHAR2,
        p_comments    IN VARCHAR2
    )
    IS
    BEGIN

        INSERT INTO leave_audit (
            request_id,
            employee_id,
            action,
            old_status,
            new_status,
            action_by,
            comments
        )
        VALUES (
            p_request_id,
            p_employee_id,
            p_action,
            p_old_status,
            p_new_status,
            p_action_by,
            p_comments
        );

    END write_audit;


	FUNCTION get_current_employee_id (
    p_username IN VARCHAR2
) RETURN NUMBER
IS
    l_employee_id employees.employee_id%TYPE;
BEGIN

    SELECT employee_id
    INTO l_employee_id
    FROM employees
    WHERE UPPER(email) = UPPER(p_username)
      AND employee_status = 'ACTIVE';

    RETURN l_employee_id;

EXCEPTION

    WHEN NO_DATA_FOUND THEN

        RAISE_APPLICATION_ERROR(
            -20021,
            'Aucun employé actif ne correspond à l''utilisateur APEX : '
            || p_username
        );

    WHEN TOO_MANY_ROWS THEN

        RAISE_APPLICATION_ERROR(
            -20022,
            'Plusieurs employés correspondent à l''utilisateur APEX : '
            || p_username
        );

END get_current_employee_id;


    ----------------------------------------------------------------
    -- CALCUL DU NOMBRE DE JOURS
    ----------------------------------------------------------------
    FUNCTION calculate_days (
        p_start_date IN DATE,
        p_end_date   IN DATE
    ) RETURN NUMBER
    IS
    BEGIN

        IF p_start_date IS NULL
           OR p_end_date IS NULL
        THEN
            RAISE_APPLICATION_ERROR(
                -20001,
                'Les dates de début et de fin sont obligatoires.'
            );
        END IF;

        IF p_end_date < p_start_date THEN
            RAISE_APPLICATION_ERROR(
                -20002,
                'La date de fin doit être supérieure ou égale à la date de début.'
            );
        END IF;

        RETURN p_end_date - p_start_date + 1;

    END calculate_days;


    ----------------------------------------------------------------
    -- CALCUL DU SOLDE DISPONIBLE
    ----------------------------------------------------------------
    FUNCTION get_available_balance (
        p_employee_id    IN NUMBER,
        p_leave_type_id  IN NUMBER,
        p_reference_year IN NUMBER
    ) RETURN NUMBER
    IS
        l_available_days NUMBER;
    BEGIN

        SELECT
            allocated_days
            - used_days
            - pending_days
        INTO l_available_days
        FROM leave_balances
        WHERE employee_id = p_employee_id
          AND leave_type_id = p_leave_type_id
          AND reference_year = p_reference_year;

        RETURN l_available_days;

    EXCEPTION

        WHEN NO_DATA_FOUND THEN

            RAISE_APPLICATION_ERROR(
                -20003,
                'Aucun solde trouvé pour cet employé et ce type de congé.'
            );

    END get_available_balance;


    ----------------------------------------------------------------
    -- CREATION D'UNE DEMANDE
    -- La demande est créée directement avec le statut SUBMITTED.
    ----------------------------------------------------------------
    PROCEDURE create_request (
        p_employee_id    IN NUMBER,
        p_leave_type_id  IN NUMBER,
        p_start_date     IN DATE,
        p_end_date       IN DATE,
        p_reason         IN VARCHAR2,
        p_created_by     IN VARCHAR2,
        p_request_id     OUT NUMBER
    )
    IS
        l_number_of_days NUMBER;
        l_available_days NUMBER;
        l_reference_year NUMBER;
        l_request_id     NUMBER;

    BEGIN

        ------------------------------------------------------------
        -- 1. Vérifier les dates
        ------------------------------------------------------------
        l_number_of_days := calculate_days(
            p_start_date,
            p_end_date
        );


        ------------------------------------------------------------
        -- 2. Déterminer l'année de référence
        ------------------------------------------------------------
        l_reference_year := EXTRACT(
            YEAR FROM p_start_date
        );


        ------------------------------------------------------------
        -- 3. Vérifier l'employé
        ------------------------------------------------------------
        DECLARE
            l_employee_count NUMBER;
        BEGIN

            SELECT COUNT(*)
            INTO l_employee_count
            FROM employees
            WHERE employee_id = p_employee_id
              AND employee_status = 'ACTIVE';

            IF l_employee_count = 0 THEN

                RAISE_APPLICATION_ERROR(
                    -20004,
                    'Employé inexistant ou inactif.'
                );

            END IF;

        END;


        ------------------------------------------------------------
        -- 4. Vérifier le type de congé
        ------------------------------------------------------------
        DECLARE
            l_leave_type_count NUMBER;
        BEGIN

            SELECT COUNT(*)
            INTO l_leave_type_count
            FROM leave_types
            WHERE leave_type_id = p_leave_type_id
              AND active_flag = 'Y';

            IF l_leave_type_count = 0 THEN

                RAISE_APPLICATION_ERROR(
                    -20005,
                    'Type de congé inexistant ou inactif.'
                );

            END IF;

        END;


        ------------------------------------------------------------
        -- 5. Vérifier le solde disponible
        ------------------------------------------------------------
        l_available_days := get_available_balance(
            p_employee_id,
            p_leave_type_id,
            l_reference_year
        );


        IF l_number_of_days > l_available_days THEN

            RAISE_APPLICATION_ERROR(
                -20006,
                'Solde insuffisant. Disponible : '
                || l_available_days
                || ' jour(s), demandé : '
                || l_number_of_days
                || ' jour(s).'
            );

        END IF;


        ------------------------------------------------------------
        -- 6. Verrouiller le solde
        ------------------------------------------------------------
        DECLARE
            l_dummy NUMBER;
        BEGIN

            SELECT 1
            INTO l_dummy
            FROM leave_balances
            WHERE employee_id = p_employee_id
              AND leave_type_id = p_leave_type_id
              AND reference_year = l_reference_year
            FOR UPDATE;

        EXCEPTION

            WHEN NO_DATA_FOUND THEN

                RAISE_APPLICATION_ERROR(
                    -20003,
                    'Aucun solde trouvé pour cet employé et ce type de congé.'
                );

        END;


        ------------------------------------------------------------
        -- 7. Recalculer le solde après verrouillage
        --    afin de tenir compte d'une éventuelle transaction
        --    concurrente.
        ------------------------------------------------------------
        SELECT
            allocated_days
            - used_days
            - pending_days
        INTO l_available_days
        FROM leave_balances
        WHERE employee_id = p_employee_id
          AND leave_type_id = p_leave_type_id
          AND reference_year = l_reference_year;


        IF l_number_of_days > l_available_days THEN

            RAISE_APPLICATION_ERROR(
                -20006,
                'Solde insuffisant. Disponible : '
                || l_available_days
                || ' jour(s), demandé : '
                || l_number_of_days
                || ' jour(s).'
            );

        END IF;


        ------------------------------------------------------------
        -- 8. Créer la demande
        ------------------------------------------------------------
        INSERT INTO leave_requests (
            employee_id,
            leave_type_id,
            start_date,
            end_date,
            number_of_days,
            reason,
            status,
            created_by,
            updated_by,
            submitted_date,
            updated_date
        )
        VALUES (
            p_employee_id,
            p_leave_type_id,
            p_start_date,
            p_end_date,
            l_number_of_days,
            p_reason,
            'SUBMITTED',
            p_created_by,
            p_created_by,
            SYSTIMESTAMP,
            SYSTIMESTAMP
        )
        RETURNING request_id
        INTO l_request_id;


        ------------------------------------------------------------
        -- 9. Réserver les jours
        ------------------------------------------------------------
        UPDATE leave_balances
        SET pending_days = pending_days + l_number_of_days,
            updated_date = SYSTIMESTAMP
        WHERE employee_id = p_employee_id
          AND leave_type_id = p_leave_type_id
          AND reference_year = l_reference_year;


        IF SQL%ROWCOUNT <> 1 THEN

            RAISE_APPLICATION_ERROR(
                -20016,
                'Impossible de mettre à jour le solde de congé.'
            );

        END IF;


        ------------------------------------------------------------
        -- 10. Ecriture de l'audit
        ------------------------------------------------------------
        write_audit(
            p_request_id  => l_request_id,
            p_employee_id => p_employee_id,
            p_action      => 'CREATE',
            p_old_status  => NULL,
            p_new_status  => 'SUBMITTED',
            p_action_by   => p_created_by,
            p_comments    => 'Création et soumission de la demande de congé.'
        );


        ------------------------------------------------------------
        -- 11. Retourner l'identifiant
        ------------------------------------------------------------
        p_request_id := l_request_id;


        COMMIT;

    EXCEPTION

        WHEN OTHERS THEN

            ROLLBACK;
            RAISE;

    END create_request;


    ----------------------------------------------------------------
    -- SOUMETTRE UNE DEMANDE EXISTANTE EN BROUILLON
    ----------------------------------------------------------------
    PROCEDURE submit_request (
        p_request_id  IN NUMBER,
        p_employee_id IN NUMBER
    )
    IS
        l_status          leave_requests.status%TYPE;
        l_employee_id     leave_requests.employee_id%TYPE;
        l_leave_type_id   leave_requests.leave_type_id%TYPE;
        l_number_of_days  leave_requests.number_of_days%TYPE;
        l_start_date      leave_requests.start_date%TYPE;
        l_reference_year  NUMBER;
        l_available_days  NUMBER;

    BEGIN

        ------------------------------------------------------------
        -- 1. Verrouiller la demande
        ------------------------------------------------------------
        SELECT
            status,
            employee_id,
            leave_type_id,
            number_of_days,
            start_date
        INTO
            l_status,
            l_employee_id,
            l_leave_type_id,
            l_number_of_days,
            l_start_date
        FROM leave_requests
        WHERE request_id = p_request_id
        FOR UPDATE;


        ------------------------------------------------------------
        -- 2. Vérifier le propriétaire
        ------------------------------------------------------------
        IF l_employee_id <> p_employee_id THEN

            RAISE_APPLICATION_ERROR(
                -20007,
                'Cette demande n''appartient pas à cet employé.'
            );

        END IF;


        ------------------------------------------------------------
        -- 3. Vérifier le statut
        ------------------------------------------------------------
        IF l_status <> 'DRAFT' THEN

            RAISE_APPLICATION_ERROR(
                -20008,
                'Seule une demande en brouillon peut être soumise.'
            );

        END IF;


        ------------------------------------------------------------
        -- 4. Année de référence
        ------------------------------------------------------------
        l_reference_year := EXTRACT(
            YEAR FROM l_start_date
        );


        ------------------------------------------------------------
        -- 5. Verrouiller le solde
        ------------------------------------------------------------
        SELECT
            allocated_days
            - used_days
            - pending_days
        INTO l_available_days
        FROM leave_balances
        WHERE employee_id = l_employee_id
          AND leave_type_id = l_leave_type_id
          AND reference_year = l_reference_year
        FOR UPDATE;


        ------------------------------------------------------------
        -- 6. Vérifier le solde
        ------------------------------------------------------------
        IF l_number_of_days > l_available_days THEN

            RAISE_APPLICATION_ERROR(
                -20006,
                'Solde insuffisant. Disponible : '
                || l_available_days
                || ' jour(s), demandé : '
                || l_number_of_days
                || ' jour(s).'
            );

        END IF;


        ------------------------------------------------------------
        -- 7. Modifier la demande
        ------------------------------------------------------------
        UPDATE leave_requests
        SET status = 'SUBMITTED',
            submitted_date = SYSTIMESTAMP,
            updated_date = SYSTIMESTAMP,
            updated_by = TO_CHAR(p_employee_id)
        WHERE request_id = p_request_id;


        ------------------------------------------------------------
        -- 8. Réserver les jours
        ------------------------------------------------------------
        UPDATE leave_balances
        SET pending_days = pending_days + l_number_of_days,
            updated_date = SYSTIMESTAMP
        WHERE employee_id = l_employee_id
          AND leave_type_id = l_leave_type_id
          AND reference_year = l_reference_year;


        IF SQL%ROWCOUNT <> 1 THEN

            RAISE_APPLICATION_ERROR(
                -20016,
                'Impossible de mettre à jour le solde de congé.'
            );

        END IF;


        ------------------------------------------------------------
        -- 9. Audit
        ------------------------------------------------------------
        write_audit(
            p_request_id  => p_request_id,
            p_employee_id => l_employee_id,
            p_action      => 'SUBMIT',
            p_old_status  => 'DRAFT',
            p_new_status  => 'SUBMITTED',
            p_action_by   => TO_CHAR(p_employee_id),
            p_comments    => 'Soumission de la demande de congé.'
        );


        COMMIT;

    EXCEPTION

        WHEN NO_DATA_FOUND THEN

            ROLLBACK;

            RAISE_APPLICATION_ERROR(
                -20009,
                'Demande de congé ou solde associé introuvable.'
            );

        WHEN OTHERS THEN

            ROLLBACK;
            RAISE;

    END submit_request;


    ----------------------------------------------------------------
    -- APPROUVER UNE DEMANDE
    ----------------------------------------------------------------
    PROCEDURE approve_request (
        p_request_id  IN NUMBER,
        p_approver_id IN NUMBER,
        p_comments    IN VARCHAR2
    )
    IS
        l_employee_id     leave_requests.employee_id%TYPE;
        l_leave_type_id   leave_requests.leave_type_id%TYPE;
        l_number_of_days  leave_requests.number_of_days%TYPE;
        l_status          leave_requests.status%TYPE;
        l_manager_id      employees.manager_id%TYPE;
        l_start_date      leave_requests.start_date%TYPE;
        l_reference_year  NUMBER;
        l_pending_days    NUMBER;

    BEGIN

        ------------------------------------------------------------
        -- 1. Récupérer et verrouiller la demande
        ------------------------------------------------------------
        SELECT
            employee_id,
            leave_type_id,
            number_of_days,
            status,
            start_date
        INTO
            l_employee_id,
            l_leave_type_id,
            l_number_of_days,
            l_status,
            l_start_date
        FROM leave_requests
        WHERE request_id = p_request_id
        FOR UPDATE;


        ------------------------------------------------------------
        -- 2. Vérifier le statut
        ------------------------------------------------------------
        IF l_status <> 'SUBMITTED' THEN

            RAISE_APPLICATION_ERROR(
                -20010,
                'Seule une demande soumise peut être approuvée.'
            );

        END IF;


        ------------------------------------------------------------
        -- 3. Récupérer le gestionnaire
        ------------------------------------------------------------
        SELECT manager_id
        INTO l_manager_id
        FROM employees
        WHERE employee_id = l_employee_id;


        ------------------------------------------------------------
        -- 4. Vérifier l'autorisation
        ------------------------------------------------------------
        IF l_manager_id IS NULL
           OR l_manager_id <> p_approver_id
        THEN

            RAISE_APPLICATION_ERROR(
                -20011,
                'L''approbateur n''est pas le gestionnaire de cet employé.'
            );

        END IF;


        ------------------------------------------------------------
        -- 5. Année de référence
        ------------------------------------------------------------
        l_reference_year := EXTRACT(
            YEAR FROM l_start_date
        );


        ------------------------------------------------------------
        -- 6. Verrouiller le solde
        ------------------------------------------------------------
        SELECT pending_days
        INTO l_pending_days
        FROM leave_balances
        WHERE employee_id = l_employee_id
          AND leave_type_id = l_leave_type_id
          AND reference_year = l_reference_year
        FOR UPDATE;


        ------------------------------------------------------------
        -- 7. Vérifier le nombre de jours en attente
        ------------------------------------------------------------
        IF l_pending_days < l_number_of_days THEN

            RAISE_APPLICATION_ERROR(
                -20017,
                'Le nombre de jours en attente est insuffisant pour approuver cette demande.'
            );

        END IF;


        ------------------------------------------------------------
        -- 8. Enregistrer l'approbation
        ------------------------------------------------------------
        INSERT INTO leave_approvals (
            request_id,
            approver_id,
            action,
            comments
        )
        VALUES (
            p_request_id,
            p_approver_id,
            'APPROVED',
            p_comments
        );


        ------------------------------------------------------------
        -- 9. Modifier le solde
        ------------------------------------------------------------
        UPDATE leave_balances
        SET pending_days = pending_days - l_number_of_days,
            used_days = used_days + l_number_of_days,
            updated_date = SYSTIMESTAMP
        WHERE employee_id = l_employee_id
          AND leave_type_id = l_leave_type_id
          AND reference_year = l_reference_year;


        IF SQL%ROWCOUNT <> 1 THEN

            RAISE_APPLICATION_ERROR(
                -20018,
                'Impossible de mettre à jour le solde après approbation.'
            );

        END IF;


        ------------------------------------------------------------
        -- 10. Modifier le statut
        ------------------------------------------------------------
        UPDATE leave_requests
        SET status = 'APPROVED',
            updated_date = SYSTIMESTAMP,
            updated_by = TO_CHAR(p_approver_id)
        WHERE request_id = p_request_id;


        ------------------------------------------------------------
        -- 11. Audit
        ------------------------------------------------------------
        write_audit(
            p_request_id  => p_request_id,
            p_employee_id => l_employee_id,
            p_action      => 'APPROVE',
            p_old_status  => 'SUBMITTED',
            p_new_status  => 'APPROVED',
            p_action_by   => TO_CHAR(p_approver_id),
            p_comments    => p_comments
        );


        COMMIT;

    EXCEPTION

        WHEN NO_DATA_FOUND THEN

            ROLLBACK;

            RAISE_APPLICATION_ERROR(
                -20012,
                'Demande, employé ou solde associé introuvable.'
            );

        WHEN OTHERS THEN

            ROLLBACK;
            RAISE;

    END approve_request;


    ----------------------------------------------------------------
    -- REFUSER UNE DEMANDE
    ----------------------------------------------------------------
    PROCEDURE reject_request (
        p_request_id  IN NUMBER,
        p_approver_id IN NUMBER,
        p_comments    IN VARCHAR2
    )
    IS
        l_employee_id     leave_requests.employee_id%TYPE;
        l_leave_type_id   leave_requests.leave_type_id%TYPE;
        l_number_of_days  leave_requests.number_of_days%TYPE;
        l_status          leave_requests.status%TYPE;
        l_manager_id      employees.manager_id%TYPE;
        l_start_date      leave_requests.start_date%TYPE;
        l_reference_year  NUMBER;
        l_pending_days    NUMBER;

    BEGIN

        ------------------------------------------------------------
        -- 1. Verrouiller la demande
        ------------------------------------------------------------
        SELECT
            employee_id,
            leave_type_id,
            number_of_days,
            status,
            start_date
        INTO
            l_employee_id,
            l_leave_type_id,
            l_number_of_days,
            l_status,
            l_start_date
        FROM leave_requests
        WHERE request_id = p_request_id
        FOR UPDATE;


        ------------------------------------------------------------
        -- 2. Vérifier le statut
        ------------------------------------------------------------
        IF l_status <> 'SUBMITTED' THEN

            RAISE_APPLICATION_ERROR(
                -20013,
                'Seule une demande soumise peut être refusée.'
            );

        END IF;


        ------------------------------------------------------------
        -- 3. Récupérer le gestionnaire
        ------------------------------------------------------------
        SELECT manager_id
        INTO l_manager_id
        FROM employees
        WHERE employee_id = l_employee_id;


        ------------------------------------------------------------
        -- 4. Vérifier l'approbateur
        ------------------------------------------------------------
        IF l_manager_id IS NULL
           OR l_manager_id <> p_approver_id
        THEN

            RAISE_APPLICATION_ERROR(
                -20014,
                'L''approbateur n''est pas le gestionnaire de cet employé.'
            );

        END IF;


        ------------------------------------------------------------
        -- 5. Année de référence
        ------------------------------------------------------------
        l_reference_year := EXTRACT(
            YEAR FROM l_start_date
        );


        ------------------------------------------------------------
        -- 6. Verrouiller le solde
        ------------------------------------------------------------
        SELECT pending_days
        INTO l_pending_days
        FROM leave_balances
        WHERE employee_id = l_employee_id
          AND leave_type_id = l_leave_type_id
          AND reference_year = l_reference_year
        FOR UPDATE;


        ------------------------------------------------------------
        -- 7. Vérifier les jours en attente
        ------------------------------------------------------------
        IF l_pending_days < l_number_of_days THEN

            RAISE_APPLICATION_ERROR(
                -20019,
                'Le nombre de jours en attente est insuffisant pour refuser cette demande.'
            );

        END IF;


        ------------------------------------------------------------
        -- 8. Enregistrer le refus
        ------------------------------------------------------------
        INSERT INTO leave_approvals (
            request_id,
            approver_id,
            action,
            comments
        )
        VALUES (
            p_request_id,
            p_approver_id,
            'REJECTED',
            p_comments
        );


        ------------------------------------------------------------
        -- 9. Libérer les jours réservés
        ------------------------------------------------------------
        UPDATE leave_balances
        SET pending_days = pending_days - l_number_of_days,
            updated_date = SYSTIMESTAMP
        WHERE employee_id = l_employee_id
          AND leave_type_id = l_leave_type_id
          AND reference_year = l_reference_year;


        IF SQL%ROWCOUNT <> 1 THEN

            RAISE_APPLICATION_ERROR(
                -20020,
                'Impossible de libérer le solde après refus.'
            );

        END IF;


        ------------------------------------------------------------
        -- 10. Modifier le statut
        ------------------------------------------------------------
        UPDATE leave_requests
        SET status = 'REJECTED',
            updated_date = SYSTIMESTAMP,
            updated_by = TO_CHAR(p_approver_id)
        WHERE request_id = p_request_id;


        ------------------------------------------------------------
        -- 11. Audit
        ------------------------------------------------------------
        write_audit(
            p_request_id  => p_request_id,
            p_employee_id => l_employee_id,
            p_action      => 'REJECT',
            p_old_status  => 'SUBMITTED',
            p_new_status  => 'REJECTED',
            p_action_by   => TO_CHAR(p_approver_id),
            p_comments    => p_comments
        );


        COMMIT;

    EXCEPTION

        WHEN NO_DATA_FOUND THEN

            ROLLBACK;

            RAISE_APPLICATION_ERROR(
                -20015,
                'Demande, employé ou solde associé introuvable.'
            );

        WHEN OTHERS THEN

            ROLLBACK;
            RAISE;

    END reject_request;


END pkg_leave;
/
