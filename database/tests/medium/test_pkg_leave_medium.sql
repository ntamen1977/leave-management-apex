CREATE OR REPLACE PACKAGE test_pkg_leave_medium AS
  --%suite(PKG_LEAVE - MEDIUM integration tests)
  --
  -- IMPORTANT:
  -- These tests use existing LEAVE_APP data discovered dynamically.
  -- PKG_LEAVE contains COMMIT/ROLLBACK, so utPLSQL automatic rollback
  -- cannot safely isolate successful create/approve/reject operations.

  --%test(get_available_balance matches LEAVE_BALANCES)
  PROCEDURE available_balance_matches_db;

  --%test(get_available_balance rejects missing balance)
  --%throws(-20003)
  PROCEDURE missing_balance;

  --%test(create_request rejects inactive or nonexistent employee)
  --%throws(-20004)
  PROCEDURE create_invalid_employee;

  --%test(create_request rejects inactive or nonexistent leave type)
  --%throws(-20005)
  PROCEDURE create_invalid_leave_type;

  --%test(approve_request rejects a non-SUBMITTED request)
  --%throws(-20010)
  PROCEDURE approve_wrong_status;

  --%test(reject_request rejects a non-SUBMITTED request)
  --%throws(-20013)
  PROCEDURE reject_wrong_status;
END test_pkg_leave_medium;
/

CREATE OR REPLACE PACKAGE BODY test_pkg_leave_medium AS

  PROCEDURE available_balance_matches_db IS
    l_employee_id    leave_balances.employee_id%TYPE;
    l_leave_type_id  leave_balances.leave_type_id%TYPE;
    l_year           leave_balances.reference_year%TYPE;
    l_expected       NUMBER;
    l_actual         NUMBER;
  BEGIN
    SELECT employee_id, leave_type_id, reference_year,
           allocated_days - used_days - pending_days
      INTO l_employee_id, l_leave_type_id, l_year, l_expected
      FROM leave_balances
     WHERE ROWNUM = 1;

    l_actual := pkg_leave.get_available_balance(
      l_employee_id, l_leave_type_id, l_year
    );

    ut.expect(l_actual).to_equal(l_expected);
  END;

  PROCEDURE missing_balance IS
    l_result NUMBER;
  BEGIN
    l_result := pkg_leave.get_available_balance(-999999, -999999, 1900);
  END;

  PROCEDURE create_invalid_employee IS
    l_leave_type_id leave_types.leave_type_id%TYPE;
    l_request_id    NUMBER;
  BEGIN
    SELECT leave_type_id
      INTO l_leave_type_id
      FROM leave_types
     WHERE active_flag = 'Y'
       AND ROWNUM = 1;

    pkg_leave.create_request(
      p_employee_id   => -999999,
      p_leave_type_id => l_leave_type_id,
      p_start_date    => DATE '2099-01-10',
      p_end_date      => DATE '2099-01-10',
      p_reason        => 'utPLSQL negative test',
      p_created_by    => 'UTPLSQL',
      p_request_id    => l_request_id
    );
  END;

  PROCEDURE create_invalid_leave_type IS
    l_employee_id employees.employee_id%TYPE;
    l_request_id  NUMBER;
  BEGIN
    SELECT employee_id
      INTO l_employee_id
      FROM employees
     WHERE employee_status = 'ACTIVE'
       AND ROWNUM = 1;

    pkg_leave.create_request(
      p_employee_id   => l_employee_id,
      p_leave_type_id => -999999,
      p_start_date    => DATE '2099-01-10',
      p_end_date      => DATE '2099-01-10',
      p_reason        => 'utPLSQL negative test',
      p_created_by    => 'UTPLSQL',
      p_request_id    => l_request_id
    );
  END;

  PROCEDURE approve_wrong_status IS
    l_request_id leave_requests.request_id%TYPE;
  BEGIN
    SELECT request_id
      INTO l_request_id
      FROM leave_requests
     WHERE status <> 'SUBMITTED'
       AND ROWNUM = 1;

    pkg_leave.approve_request(
      p_request_id  => l_request_id,
      p_approver_id => -999999,
      p_comments    => 'utPLSQL negative test'
    );
  END;

  PROCEDURE reject_wrong_status IS
    l_request_id leave_requests.request_id%TYPE;
  BEGIN
    SELECT request_id
      INTO l_request_id
      FROM leave_requests
     WHERE status <> 'SUBMITTED'
       AND ROWNUM = 1;

    pkg_leave.reject_request(
      p_request_id  => l_request_id,
      p_approver_id => -999999,
      p_comments    => 'utPLSQL negative test'
    );
  END;

END test_pkg_leave_medium;
/

-- Run:
-- SET SERVEROUTPUT ON
-- EXEC ut.run('TEST_PKG_LEAVE_MEDIUM');
