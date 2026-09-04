CREATE OR REPLACE PACKAGE test_pkg_leave_small AS
  --%suite(PKG_LEAVE - SMALL unit tests)

  --%test(calculate_days returns 1 for same day)
  PROCEDURE calculate_one_day;

  --%test(calculate_days returns 5 for five calendar days)
  PROCEDURE calculate_five_days;

  --%test(calculate_days rejects NULL start date)
  --%throws(-20001)
  PROCEDURE calculate_null_start;

  --%test(calculate_days rejects end date before start date)
  --%throws(-20002)
  PROCEDURE calculate_invalid_range;
END test_pkg_leave_small;
/

CREATE OR REPLACE PACKAGE BODY test_pkg_leave_small AS
  PROCEDURE calculate_one_day IS
    l_result NUMBER;
  BEGIN
    l_result := pkg_leave.calculate_days(DATE '2026-09-01', DATE '2026-09-01');
    ut.expect(l_result).to_equal(1);
  END;

  PROCEDURE calculate_five_days IS
    l_result NUMBER;
  BEGIN
    l_result := pkg_leave.calculate_days(DATE '2026-09-01', DATE '2026-09-05');
    ut.expect(l_result).to_equal(5);
  END;

  PROCEDURE calculate_null_start IS
    l_result NUMBER;
  BEGIN
    l_result := pkg_leave.calculate_days(NULL, DATE '2026-09-05');
  END;

  PROCEDURE calculate_invalid_range IS
    l_result NUMBER;
  BEGIN
    l_result := pkg_leave.calculate_days(DATE '2026-09-10', DATE '2026-09-05');
  END;
END test_pkg_leave_small;
/

-- Run:
-- SET SERVEROUTPUT ON
-- EXEC ut.run('TEST_PKG_LEAVE_SMALL');
