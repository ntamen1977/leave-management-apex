prompt --application/pages/page_00012
begin
--   Manifest
--     PAGE: 00012
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
 p_id=>12
,p_name=>unistr('Liste des employ\00E9s')
,p_alias=>unistr('LISTE-DES-EMPLOY\00C9S')
,p_step_title=>unistr('Liste des employ\00E9s')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(12088851825943285)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12484982387765743)
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
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12485626821765745)
,p_plug_name=>unistr('Liste des employ\00E9s')
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    e.employee_id,',
'    e.first_name,',
'    e.last_name,',
'    e.email,',
'    e.employee_status,',
'    e.manager_id,',
'    m.first_name || '' '' || m.last_name AS manager_name',
'FROM employees e',
'LEFT JOIN employees m',
'    ON m.employee_id = e.manager_id',
'ORDER BY e.last_name, e.first_name;'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>unistr('Liste des employ\00E9s')
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(12485738777765745)
,p_name=>unistr('Liste des employ\00E9s')
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'ADMIN'
,p_internal_uid=>12485738777765745
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12486418367765748)
,p_db_column_name=>'EMPLOYEE_ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Employee Id'
,p_column_link=>'f?p=&APP_ID.:15:&SESSION.::&DEBUG.:15:P15_EMPLOYEE_ID:#EMPLOYEE_ID#'
,p_column_linktext=>'#EMPLOYEE_ID#'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12486834662765748)
,p_db_column_name=>'FIRST_NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'First Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12487267988765750)
,p_db_column_name=>'LAST_NAME'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Last Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12487668352765750)
,p_db_column_name=>'EMAIL'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Email'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12488082083765750)
,p_db_column_name=>'EMPLOYEE_STATUS'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Employee Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12488433581765750)
,p_db_column_name=>'MANAGER_ID'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Manager Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12488878718765750)
,p_db_column_name=>'MANAGER_NAME'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Manager Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(12500488159974378)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'125005'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPLOYEE_ID:FIRST_NAME:LAST_NAME:EMAIL:EMPLOYEE_STATUS:MANAGER_ID:MANAGER_NAME'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12492253232816811)
,p_plug_name=>'Body Slot'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>30
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(12492143808816810)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(12492253232816811)
,p_button_name=>'NEW_EMPLOYEE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>unistr('Nouveau Employ\00E9')
,p_button_redirect_url=>'f?p=&APP_ID.:14:&SESSION.::&DEBUG.:14::'
,p_grid_new_row=>'Y'
);
wwv_flow_imp.component_end;
end;
/
