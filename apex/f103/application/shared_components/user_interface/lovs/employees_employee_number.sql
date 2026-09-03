prompt --application/shared_components/user_interface/lovs/employees_employee_number
begin
--   Manifest
--     EMPLOYEES.EMPLOYEE_NUMBER
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>12056206813540257
,p_default_application_id=>103
,p_default_id_offset=>0
,p_default_owner=>'LEAVE_APP'
);
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(12514102638271187)
,p_lov_name=>'EMPLOYEES.EMPLOYEE_NUMBER'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'EMPLOYEES'
,p_return_column_name=>'EMPLOYEE_ID'
,p_display_column_name=>'EMPLOYEE_NUMBER'
,p_default_sort_column_name=>'EMPLOYEE_NUMBER'
,p_default_sort_direction=>'ASC'
,p_version_scn=>43010083
);
wwv_flow_imp.component_end;
end;
/
