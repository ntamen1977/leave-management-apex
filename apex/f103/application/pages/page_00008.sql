prompt --application/pages/page_00008
begin
--   Manifest
--     PAGE: 00008
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
 p_id=>8
,p_name=>'Nouvelle demande'
,p_alias=>'NOUVELLE-DEMANDE'
,p_step_title=>'Nouvelle demande'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(12088432148935884)
,p_protection_level=>'C'
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12113430783244298)
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
 p_id=>wwv_flow_imp.id(12096328199013314)
,p_button_sequence=>70
,p_button_name=>'BTN_SUBMIT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Soumettre la demande'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(12097040682013321)
,p_branch_name=>'GO_TO_MY_REQUESTS'
,p_branch_action=>'f?p=&APP_ID.:6:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(12096328199013314)
,p_branch_sequence=>10
,p_branch_comment=>unistr('Votre demande de cong\00E9 a \00E9t\00E9 soumise avec succ\00E8s.')
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12095834905013309)
,p_name=>'P8_LEAVE_TYPE_ID'
,p_item_sequence=>10
,p_prompt=>unistr('Type de cong\00E9')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    leave_name AS display_value,',
'    leave_type_id AS return_value',
'FROM leave_types',
'WHERE active_flag = ''Y''',
'ORDER BY leave_name;'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12095943549013310)
,p_name=>'P8_START_DATE'
,p_item_sequence=>30
,p_prompt=>'Date de debut'
,p_format_mask=>'YYYY-MM-DD'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12096095865013311)
,p_name=>'P8_END_DATE'
,p_item_sequence=>40
,p_prompt=>'Date de fin'
,p_format_mask=>'YYYY-MM-DD'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12096252684013313)
,p_name=>'P8_REASON'
,p_item_sequence=>50
,p_prompt=>'Motif'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12096583999013316)
,p_name=>'P8_REQUEST_ID'
,p_item_sequence=>60
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(12096638245013317)
,p_validation_name=>'VALIDATE_DATES'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'    IF :P8_START_DATE IS NULL',
'       OR :P8_END_DATE IS NULL',
'    THEN',
'        RETURN NULL;',
'    END IF;',
'',
'    IF :P8_END_DATE < :P8_START_DATE THEN',
unistr('        RETURN ''La date de fin doit \00EAtre sup\00E9rieure ou \00E9gale \00E0 la date de d\00E9but.'';'),
'    END IF;',
'',
'    RETURN NULL;',
'',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(12096782155013318)
,p_validation_name=>'VALIDATE_LEAVE_TYPE'
,p_validation_sequence=>20
,p_validation=>'P8_LEAVE_TYPE_ID'
,p_validation_type=>'ITEM_IS_ALPHANUMERIC'
,p_error_message=>unistr('Veuillez s\00E9lectionner un type de cong\00E9.')
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(12097273773013323)
,p_validation_name=>'VALIDATE_LEAVE_BALANCE'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_employee_id    NUMBER;',
'    l_available_days NUMBER;',
'    l_number_of_days NUMBER;',
'    l_reference_year NUMBER;',
'BEGIN',
'',
'    IF :P8_START_DATE IS NULL',
'       OR :P8_END_DATE IS NULL',
'       OR :P8_LEAVE_TYPE_ID IS NULL',
'    THEN',
'        RETURN NULL;',
'    END IF;',
'',
'    SELECT employee_id',
'    INTO l_employee_id',
'    FROM employees',
'    WHERE UPPER(email) = UPPER(:APP_USER)',
'      AND employee_status = ''ACTIVE'';',
'',
'    l_number_of_days :=',
'        :P8_END_DATE - :P8_START_DATE + 1;',
'',
'    l_reference_year :=',
'        EXTRACT(YEAR FROM :P8_START_DATE);',
'',
'    SELECT allocated_days - used_days - pending_days',
'    INTO l_available_days',
'    FROM leave_balances',
'    WHERE employee_id = l_employee_id',
'      AND leave_type_id = :P8_LEAVE_TYPE_ID',
'      AND reference_year = l_reference_year;',
'',
'    IF l_number_of_days > l_available_days THEN',
'        RETURN',
'            ''Solde insuffisant. Disponible : ''',
'            || l_available_days',
unistr('            || '' jour(s), demand\00E9 : '''),
'            || l_number_of_days',
'            || '' jour(s).'';',
'    END IF;',
'',
'    RETURN NULL;',
'',
'EXCEPTION',
'    WHEN NO_DATA_FOUND THEN',
unistr('        RETURN ''Aucun solde de cong\00E9 disponible pour ce type de cong\00E9.'';'),
'',
'    WHEN OTHERS THEN',
unistr('        RETURN ''Impossible de v\00E9rifier le solde de cong\00E9.'';'),
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P8_LEAVE_TYPE_ID IS NOT NULL',
'AND :P8_START_DATE IS NOT NULL',
'AND :P8_END_DATE IS NOT NULL'))
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(12096490770013315)
,p_process_sequence=>10
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'CREATE_LEAVE_REQUEST'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_employee_id NUMBER;',
'    l_request_id  NUMBER;',
'BEGIN',
'',
'    SELECT employee_id',
'    INTO l_employee_id',
'    FROM employees',
'    WHERE UPPER(email) = UPPER(:APP_USER)',
'      AND employee_status = ''ACTIVE'';',
'',
'    pkg_leave.create_request(',
'        p_employee_id   => l_employee_id,',
'        p_leave_type_id => :P8_LEAVE_TYPE_ID,',
'        p_start_date    => TO_DATE(:P8_START_DATE, ''YYYY-MM-DD''),',
'        p_end_date      => TO_DATE(:P8_END_DATE, ''YYYY-MM-DD''),',
'        p_reason        => :P8_REASON,',
'        p_created_by    => :APP_USER,',
'        p_request_id    => l_request_id',
'    );',
'',
'    :P8_REQUEST_ID := l_request_id;',
'',
'EXCEPTION',
'',
'    WHEN OTHERS THEN',
'',
'        IF SQLCODE = -20006 THEN',
'',
'            raise_application_error(',
'                -20006,',
'                REPLACE(SQLERRM, ''ORA-20006: '', '''')',
'            );',
'',
'        ELSE',
'',
'            RAISE;',
'',
'        END IF;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('Votre demande de cong\00E9 a \00E9t\00E9 soumise avec succ\00E8s.')
,p_internal_uid=>12096490770013315
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(12097175836013322)
,p_process_sequence=>20
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'RESET_LEAVE_FORM'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P8_LEAVE_TYPE_ID := NULL;',
':P8_START_DATE    := NULL;',
':P8_END_DATE      := NULL;',
':P8_REASON        := NULL;',
':P8_REQUEST_ID    := NULL;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>12097175836013322
);
wwv_flow_imp.component_end;
end;
/
