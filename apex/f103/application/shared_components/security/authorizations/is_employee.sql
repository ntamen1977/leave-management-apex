prompt --application/shared_components/security/authorizations/is_employee
begin
--   Manifest
--     SECURITY SCHEME: IS_EMPLOYEE
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
 p_id=>wwv_flow_imp.id(12088432148935884)
,p_name=>'IS_EMPLOYEE'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_count NUMBER;',
'BEGIN',
'',
'    IF UPPER(:APP_USER) = ''ADMIN'' THEN',
'        RETURN TRUE;',
'    END IF;',
'',
'    SELECT COUNT(*)',
'    INTO l_count',
'    FROM employees',
'    WHERE UPPER(email) = UPPER(:APP_USER)',
'      AND employee_status = ''ACTIVE'';',
'',
'    RETURN l_count > 0;',
'',
'END;'))
,p_version_scn=>42958905
,p_caching=>'BY_USER_BY_SESSION'
);
wwv_flow_imp.component_end;
end;
/
