SET SERVEROUTPUT ON
SET FEEDBACK ON
SET VERIFY OFF

WHENEVER SQLERROR EXIT SQL.SQLCODE
WHENEVER OSERROR EXIT FAILURE

PROMPT =============================================
PROMPT LEAVE MANAGEMENT - CI TESTS
PROMPT =============================================

PROMPT
PROMPT === CONNECTION ===

SELECT
    USER AS connected_user,
    SYS_CONTEXT('USERENV', 'DB_NAME') AS database_name
FROM dual;

PROMPT
PROMPT === TEST PACKAGE STATUS ===

SELECT
    object_name,
    object_type,
    status
FROM user_objects
WHERE object_name IN (
    'PKG_LEAVE',
    'TEST_PKG_LEAVE_MEDIUM'
)
ORDER BY object_name, object_type;

PROMPT
PROMPT === RUN TEST_PKG_LEAVE_MEDIUM ===

BEGIN
    ut.run('TEST_PKG_LEAVE_MEDIUM');
END;
/

PROMPT
PROMPT =============================================
PROMPT TEST EXECUTION COMPLETED
PROMPT =============================================

EXIT SUCCESS