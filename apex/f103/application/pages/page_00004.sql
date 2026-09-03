prompt --application/pages/page_00004
begin
--   Manifest
--     PAGE: 00004
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>12056206813540257
,p_default_application_id=>103
,p_default_id_offset=>0
,p_default_owner=>'LEAVE_APP'
);
wwv_flow_imp_page.create_page(
 p_id=>4
,p_name=>'SECURITY_INFO'
,p_alias=>'SECURITY-INFO'
,p_step_title=>'SECURITY_INFO'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12089651138976740)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(12062626743546993)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(12090367701976748)
,p_name=>'SECURITY_INFO'
,p_template=>4072358936313175081
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlight:t-Report--inline:t-Report--hideNoPagination'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    :APP_USER AS apex_user,',
'',
'    e.employee_id,',
'    e.employee_number,',
'    e.first_name,',
'    e.last_name,',
'    e.email,',
'    e.manager_id,',
'    e.employee_status,',
'',
'    CASE',
'        WHEN e.employee_status = ''ACTIVE''',
'        THEN ''YES''',
'        ELSE ''NO''',
'    END AS is_employee,',
'',
'    CASE',
'        WHEN EXISTS (',
'            SELECT 1',
'            FROM employees sub',
'            WHERE sub.manager_id = e.employee_id',
'              AND sub.employee_status = ''ACTIVE''',
'        )',
'        THEN ''YES''',
'        ELSE ''NO''',
'    END AS is_manager,',
'',
'    CASE',
'        WHEN UPPER(:APP_USER) = ''ADMIN''',
'        THEN ''YES''',
'        ELSE ''NO''',
'    END AS is_admin',
'',
'FROM employees e',
'WHERE UPPER(e.email) = UPPER(:APP_USER)',
'',
'UNION ALL',
'',
'SELECT',
'    :APP_USER,',
'    NULL,',
'    NULL,',
'    NULL,',
'    NULL,',
'    NULL,',
'    NULL,',
'    NULL,',
'',
'    ''NO'',',
'    ''NO'',',
'',
'    CASE',
'        WHEN UPPER(:APP_USER) = ''ADMIN''',
'        THEN ''YES''',
'        ELSE ''NO''',
'    END',
'',
'FROM dual',
'',
'WHERE UPPER(:APP_USER) = ''ADMIN'';'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2538654340625403440
,p_query_num_rows=>50
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_query_row_count_max=>500
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_prn_output=>'N'
,p_prn_format=>'PDF'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(12090749788976751)
,p_query_column_id=>1
,p_column_alias=>'APEX_USER'
,p_column_display_sequence=>1
,p_column_heading=>'Apex User'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_disable_sort_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(12091195011976753)
,p_query_column_id=>2
,p_column_alias=>'EMPLOYEE_ID'
,p_column_display_sequence=>2
,p_column_heading=>'Employee Id'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(12091509323976753)
,p_query_column_id=>3
,p_column_alias=>'EMPLOYEE_NUMBER'
,p_column_display_sequence=>3
,p_column_heading=>'Employee Number'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_disable_sort_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(12091902000976753)
,p_query_column_id=>4
,p_column_alias=>'FIRST_NAME'
,p_column_display_sequence=>4
,p_column_heading=>'First Name'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_disable_sort_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(12092300181976753)
,p_query_column_id=>5
,p_column_alias=>'LAST_NAME'
,p_column_display_sequence=>5
,p_column_heading=>'Last Name'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_disable_sort_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(12092730795976753)
,p_query_column_id=>6
,p_column_alias=>'EMAIL'
,p_column_display_sequence=>6
,p_column_heading=>'Email'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_disable_sort_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(12093100990976754)
,p_query_column_id=>7
,p_column_alias=>'MANAGER_ID'
,p_column_display_sequence=>7
,p_column_heading=>'Manager Id'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(12093516379976754)
,p_query_column_id=>8
,p_column_alias=>'EMPLOYEE_STATUS'
,p_column_display_sequence=>8
,p_column_heading=>'Employee Status'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_disable_sort_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(12095046061013301)
,p_query_column_id=>9
,p_column_alias=>'IS_EMPLOYEE'
,p_column_display_sequence=>20
,p_column_heading=>'Is Employee'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(12093910979976754)
,p_query_column_id=>10
,p_column_alias=>'IS_MANAGER'
,p_column_display_sequence=>9
,p_column_heading=>'Is Manager'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(12094310317976754)
,p_query_column_id=>11
,p_column_alias=>'IS_ADMIN'
,p_column_display_sequence=>10
,p_column_heading=>'Is Admin'
,p_heading_alignment=>'LEFT'
,p_default_sort_column_sequence=>1
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12095173569013302)
,p_plug_name=>'IS_EMPLOYEE'
,p_title=>'ESPACE EMPLOYE'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>30
,p_location=>null
,p_plug_source=>unistr('Vous \00EAtes connect\00E9 comme employ\00E9.')
,p_plug_required_role=>wwv_flow_imp.id(12088432148935884)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12095306888013304)
,p_plug_name=>'IS_MANAGER'
,p_title=>'ESPACE GESTIONNAIRE'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>40
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Vous \00EAtes gestionnaire.'),
unistr('Vous pouvez traiter les demandes de vos employ\00E9s.')))
,p_plug_required_role=>wwv_flow_imp.id(12088613857939290)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12095545543013306)
,p_plug_name=>'IS_ADMIN'
,p_title=>'ADMINISTRATION'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>20
,p_location=>null
,p_plug_source=>unistr('Acc\00E8s aux fonctions d''administration de l''application.')
,p_plug_required_role=>wwv_flow_imp.id(12088851825943285)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp.component_end;
end;
/
