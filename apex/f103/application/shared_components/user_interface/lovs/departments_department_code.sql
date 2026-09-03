prompt --application/shared_components/user_interface/lovs/departments_department_code
begin
--   Manifest
--     DEPARTMENTS.DEPARTMENT_CODE
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
 p_id=>wwv_flow_imp.id(12513472299271182)
,p_lov_name=>'DEPARTMENTS.DEPARTMENT_CODE'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'DEPARTMENTS'
,p_return_column_name=>'DEPARTMENT_ID'
,p_display_column_name=>'DEPARTMENT_CODE'
,p_default_sort_column_name=>'DEPARTMENT_CODE'
,p_default_sort_direction=>'ASC'
,p_version_scn=>43010081
);
wwv_flow_imp.component_end;
end;
/
