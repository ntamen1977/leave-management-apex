prompt --application/pages/page_00003
begin
--   Manifest
--     PAGE: 00003
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
 p_id=>3
,p_name=>unistr('Demandes \00E0 approuver')
,p_alias=>unistr('DEMANDES-\00C0-APPROUVER')
,p_step_title=>unistr('Demandes \00E0 approuver')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(12088613857939290)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12445795000481001)
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
 p_id=>wwv_flow_imp.id(12446481097481007)
,p_plug_name=>unistr('Demandes \00E0 approuver')
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    lr.request_id,',
'    e.first_name || '' '' || e.last_name AS employee_name,',
'    lt.leave_name,',
'    lr.start_date,',
'    lr.end_date,',
'    lr.number_of_days,',
'    lr.reason,',
'    lr.submitted_date,',
'    lr.status',
'FROM leave_requests lr',
'JOIN employees e',
'    ON e.employee_id = lr.employee_id',
'JOIN leave_types lt',
'    ON lt.leave_type_id = lr.leave_type_id',
'WHERE lr.status = ''SUBMITTED''',
'  AND e.manager_id = (',
'      SELECT employee_id',
'      FROM employees',
'      WHERE UPPER(email) = UPPER(:APP_USER)',
'        AND employee_status = ''ACTIVE''',
'  )',
'ORDER BY lr.submitted_date;'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>unistr('Demandes \00E0 approuver')
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(12446527084481007)
,p_name=>unistr('Demandes \00E0 approuver')
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
,p_internal_uid=>12446527084481007
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12447275202481012)
,p_db_column_name=>'REQUEST_ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Request Id'
,p_column_link=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.:P13_COMMENTS,9:P13_REQUEST_ID:#REQUEST_ID#'
,p_column_linktext=>'#REQUEST_ID#'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12447665053481014)
,p_db_column_name=>'EMPLOYEE_NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Employee Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12448066968481014)
,p_db_column_name=>'LEAVE_NAME'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Leave Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12448438438481015)
,p_db_column_name=>'START_DATE'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Start Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12448834415481015)
,p_db_column_name=>'END_DATE'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'End Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12449298077481017)
,p_db_column_name=>'NUMBER_OF_DAYS'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Number Of Days'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12449676046481017)
,p_db_column_name=>'REASON'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Reason'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12450028361481017)
,p_db_column_name=>'SUBMITTED_DATE'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Submitted Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(12450407581481017)
,p_db_column_name=>'STATUS'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(12450853695504310)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'124509'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'REQUEST_ID:EMPLOYEE_NAME:LEAVE_NAME:START_DATE:END_DATE:NUMBER_OF_DAYS:REASON:SUBMITTED_DATE:STATUS'
);
wwv_flow_imp.component_end;
end;
/
