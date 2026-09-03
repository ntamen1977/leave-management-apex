prompt --application/pages/page_00009
begin
--   Manifest
--     PAGE: 00009
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
 p_id=>9
,p_name=>unistr('D\00E9tail de la demande')
,p_alias=>unistr('D\00C9TAIL-DE-LA-DEMANDE')
,p_step_title=>unistr('D\00E9tail de la demande')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#APP_FILES#gescon.css'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(12088432148935884)
,p_protection_level=>'C'
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12097725332013328)
,p_plug_name=>unistr('D\00E9tails de la demande')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>20
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12452781338631482)
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
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(12098865789013339)
,p_button_sequence=>110
,p_button_plug_id=>wwv_flow_imp.id(12097725332013328)
,p_button_name=>'APPROVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft:t-Button--hoverIconPush'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Approuver'
,p_button_execute_validations=>'N'
,p_button_condition=>'P13_STATUS'
,p_button_condition2=>'SUBMITTED'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(12098981024013340)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_imp.id(12097725332013328)
,p_button_name=>'REJECT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Refuser'
,p_button_condition=>'P13_STATUS'
,p_button_condition2=>'SUBMITTED'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_button_css_classes=>'btn-reject'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(12099728824013348)
,p_branch_name=>'BACK_TO_LEAVE_REQUEST'
,p_branch_action=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:9::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12097622358013327)
,p_name=>'P13_REQUEST_ID'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12097816973013329)
,p_name=>'P13_EMPLOYEE_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(12097725332013328)
,p_prompt=>'Employee Name'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12097992122013330)
,p_name=>'P13_SUBMITTED_DATE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(12097725332013328)
,p_prompt=>'Date de soumission'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12098016480013331)
,p_name=>'P13_STATUS'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(12097725332013328)
,p_prompt=>unistr('Statut employ\00E9')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12098186714013332)
,p_name=>'P13_REASON'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(12097725332013328)
,p_prompt=>unistr('Raison du cong\00E9')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12098236520013333)
,p_name=>'P13_NUMBER_OF_DAYS'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(12097725332013328)
,p_prompt=>'Nombre de jours'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12098392490013334)
,p_name=>'P13_END_DATE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(12097725332013328)
,p_prompt=>'Date de fin'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12098443292013335)
,p_name=>'P13_START_DATE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(12097725332013328)
,p_prompt=>'Date de Debut'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12098532970013336)
,p_name=>'P13_LEAVE_TYPE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(12097725332013328)
,p_prompt=>'Leave Type'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12098688369013337)
,p_name=>'P13_COMMENTS'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(12097725332013328)
,p_prompt=>'Commentaire du manager'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12099499797013345)
,p_name=>'P13_TEST'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(12097725332013328)
,p_item_default=>'P13_REQUEST_ID'
,p_item_default_type=>'ITEM'
,p_prompt=>'Employee Name'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(12098767223013338)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'LOAD_REQUEST'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'    SELECT',
'        e.first_name || '' '' || e.last_name,',
'        lt.leave_name,',
'        lr.start_date,',
'        lr.end_date,',
'        lr.number_of_days,',
'        lr.reason,',
'        lr.submitted_date,',
'        lr.status',
'    INTO',
'        :P13_EMPLOYEE_NAME,',
'        :P13_LEAVE_TYPE,',
'        :P13_START_DATE,',
'        :P13_END_DATE,',
'        :P13_NUMBER_OF_DAYS,',
'        :P13_REASON,',
'        :P13_SUBMITTED_DATE,',
'        :P13_STATUS',
'    FROM leave_requests lr',
'    JOIN employees e',
'        ON e.employee_id = lr.employee_id',
'    JOIN leave_types lt',
'        ON lt.leave_type_id = lr.leave_type_id',
'    WHERE lr.request_id = :P13_REQUEST_ID;',
'',
'EXCEPTION',
'',
'    WHEN NO_DATA_FOUND THEN',
'',
'        raise_application_error(',
'            -20030,',
unistr('            ''La demande de cong\00E9 est introuvable.'''),
'        );',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>12098767223013338
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(12099286513013343)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'LOAD_LEAVE_REQUEST'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'    SELECT',
'        e.first_name || '' '' || e.last_name,',
'        lt.leave_name,',
'        lr.start_date,',
'        lr.end_date,',
'        lr.number_of_days,',
'        lr.reason,',
'        lr.submitted_date,',
'        lr.status',
'    INTO',
'        :P13_EMPLOYEE_NAME,',
'        :P13_LEAVE_TYPE,',
'        :P13_START_DATE,',
'        :P13_END_DATE,',
'        :P13_NUMBER_OF_DAYS,',
'        :P13_REASON,',
'        :P13_SUBMITTED_DATE,',
'        :P13_STATUS',
'    FROM leave_requests lr',
'    JOIN employees e',
'        ON e.employee_id = lr.employee_id',
'    JOIN leave_types lt',
'        ON lt.leave_type_id = lr.leave_type_id',
'    WHERE lr.request_id = :P13_REQUEST_ID;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'P13_REQUEST_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_internal_uid=>12099286513013343
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(12099041142013341)
,p_process_sequence=>10
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'APPROVE_REQUEST'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_approver_id NUMBER;',
'BEGIN',
'',
'    SELECT employee_id',
'    INTO l_approver_id',
'    FROM employees',
'    WHERE UPPER(email) = UPPER(:APP_USER)',
'      AND employee_status = ''ACTIVE'';',
'',
'    pkg_leave.approve_request(',
'        p_request_id  => :P13_REQUEST_ID,',
'        p_approver_id => l_approver_id,',
'        p_comments    => :P13_COMMENTS',
'    );',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(12098865789013339)
,p_required_patch=>wwv_flow_imp.id(12062045065546992)
,p_internal_uid=>12099041142013341
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(12099123562013342)
,p_process_sequence=>20
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'REJECT_REQUEST'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_approver_id NUMBER;',
'BEGIN',
'',
'    SELECT employee_id',
'    INTO l_approver_id',
'    FROM employees',
'    WHERE UPPER(email) = UPPER(:APP_USER)',
'      AND employee_status = ''ACTIVE'';',
'',
'    pkg_leave.reject_request(',
'        p_request_id  => :P13_REQUEST_ID,',
'        p_approver_id => l_approver_id,',
'        p_comments    => :P13_COMMENTS',
'    );',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(12098981024013340)
,p_required_patch=>wwv_flow_imp.id(12062045065546992)
,p_internal_uid=>12099123562013342
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(12099503052013346)
,p_process_sequence=>20
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'APPROVE_LEAVE_REQUEST'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_approver_id NUMBER;',
'BEGIN',
'',
'    SELECT employee_id',
'    INTO l_approver_id',
'    FROM employees',
'    WHERE UPPER(email) = UPPER(:APP_USER)',
'      AND employee_status = ''ACTIVE'';',
'',
'    pkg_leave.approve_request(',
'        p_request_id  => :P13_REQUEST_ID,',
'        p_approver_id => l_approver_id,',
'        p_comments    => :P13_COMMENTS',
'    );',
'',
'    apex_application.g_print_success_message :=',
unistr('        ''La demande de cong\00E9 a \00E9t\00E9 approuv\00E9e avec succ\00E8s.'';'),
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(12098865789013339)
,p_internal_uid=>12099503052013346
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(12099696290013347)
,p_process_sequence=>30
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'REJECT_LEAVE_REQUEST'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_approver_id NUMBER;',
'BEGIN',
'',
'    SELECT employee_id',
'    INTO l_approver_id',
'    FROM employees',
'    WHERE UPPER(email) = UPPER(:APP_USER)',
'      AND employee_status = ''ACTIVE'';',
'',
'    pkg_leave.reject_request(',
'        p_request_id  => :P13_REQUEST_ID,',
'        p_approver_id => l_approver_id,',
'        p_comments    => :P13_COMMENTS',
'    );',
'',
'    apex_application.g_print_success_message :=',
unistr('        ''La demande de cong\00E9 a \00E9t\00E9 refus\00E9e.'';'),
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(12098981024013340)
,p_internal_uid=>12099696290013347
);
wwv_flow_imp.component_end;
end;
/
