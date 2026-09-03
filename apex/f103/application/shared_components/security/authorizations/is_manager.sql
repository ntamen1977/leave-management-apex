prompt --application/shared_components/security/authorizations/is_manager
begin
--   Manifest
--     SECURITY SCHEME: IS_MANAGER
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>12056206813540257
,p_default_application_id=>103
,p_default_id_offset=>0
,p_default_owner=>'LEAVE_APP'
);
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(12088613857939290)
,p_name=>'IS_MANAGER'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_count NUMBER;',
'BEGIN',
'',
'    -- ADMIN peut tout faire',
'    IF UPPER(:APP_USER) = ''ADMIN'' THEN',
'        RETURN TRUE;',
'    END IF;',
'',
unistr('    -- Sinon, v\00E9rifier que l''utilisateur est un employ\00E9 actif'),
unistr('    -- ayant au moins un subordonn\00E9 actif'),
'    SELECT COUNT(*)',
'    INTO l_count',
'    FROM employees e',
'    WHERE UPPER(e.email) = UPPER(:APP_USER)',
'      AND e.employee_status = ''ACTIVE''',
'      AND EXISTS (',
'          SELECT 1',
'          FROM employees sub',
'          WHERE sub.manager_id = e.employee_id',
'            AND sub.employee_status = ''ACTIVE''',
'      );',
'',
'    RETURN l_count > 0;',
'',
'END;'))
,p_version_scn=>42958606
,p_caching=>'BY_USER_BY_SESSION'
);
wwv_flow_imp.component_end;
end;
/
