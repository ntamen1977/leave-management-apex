prompt --application/pages/page_00014
begin
--   Manifest
--     PAGE: 00014
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
 p_id=>14
,p_name=>unistr('Fiche employ\00E9')
,p_alias=>unistr('FICHE-EMPLOY\00C9')
,p_step_title=>unistr('Fiche employ\00E9')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(12088851825943285)
,p_protection_level=>'C'
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12490133520790492)
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
 p_id=>wwv_flow_imp.id(12491282305816801)
,p_button_sequence=>140
,p_button_name=>'CREATE_EMPLOYEE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>unistr('Cr\00E9er employ\00E9')
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(12491811342816807)
,p_button_sequence=>150
,p_button_name=>'SAVE_EMPLOYEE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>unistr('MAJ employ\00E9')
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12099819968013349)
,p_name=>'P16_EMPLOYEE_ID'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12099954141013350)
,p_name=>'P16_FIRST_NAME'
,p_item_sequence=>30
,p_prompt=>'First Name'
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
 p_id=>wwv_flow_imp.id(12491393236816802)
,p_name=>'P16_LAST_NAME'
,p_item_sequence=>50
,p_prompt=>'Last Name'
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
 p_id=>wwv_flow_imp.id(12491469525816803)
,p_name=>'P16_EMAIL'
,p_is_required=>true
,p_item_sequence=>60
,p_prompt=>'Courriel'
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
 p_id=>wwv_flow_imp.id(12491578208816804)
,p_name=>'P16_EMPLOYEE_STATUS'
,p_item_sequence=>110
,p_prompt=>unistr('Statut Employ\00E9')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:ACTIVE;ACTIVE,INACTIVE;INACTIVE'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12491635728816805)
,p_name=>'P16_MANAGER_ID'
,p_item_sequence=>90
,p_prompt=>'Manager ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    first_name || '' '' || last_name AS display_value,',
'    employee_id AS return_value',
'FROM employees',
'WHERE employee_status = ''ACTIVE''',
'  AND employee_id <> NVL(:P16_EMPLOYEE_ID, -1)',
'ORDER BY last_name, first_name;'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12492318020816812)
,p_name=>'P16_EMPLOYEE_NUMBER'
,p_item_sequence=>20
,p_prompt=>'Matricule'
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
 p_id=>wwv_flow_imp.id(12492499310816813)
,p_name=>'P16_DEPARTMENT_ID'
,p_is_required=>true
,p_item_sequence=>70
,p_prompt=>'Departement ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    departement_code || '' '' || departement_name AS display_value,',
'    departement_id AS return_value',
'FROM departements',
'WHERE active_flag = ''Y''',
'  AND departement_id <> NVL(:P16_DEPARTEMENT_ID, -1)',
'ORDER BY departement_name, departement_code;'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12492660548816815)
,p_name=>'P16_HIRE_DATE'
,p_is_required=>true
,p_item_sequence=>100
,p_prompt=>'Manager ID'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(12492734036816816)
,p_name=>'P16_CREATED_DATE'
,p_item_sequence=>130
,p_prompt=>'Manager ID'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(12492000755816809)
,p_validation_name=>'VALIDATE_EMAIL'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_count NUMBER;',
'BEGIN',
'',
'    SELECT COUNT(*)',
'    INTO l_count',
'    FROM employees',
'    WHERE UPPER(email) = UPPER(TRIM(:P16_EMAIL))',
'      AND employee_id <> NVL(:P16_EMPLOYEE_ID, -1);',
'',
'    RETURN l_count = 0;',
'',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('Cette adresse courriel est d\00E9j\00E0 utilis\00E9e par un autre employ\00E9.')
,p_when_button_pressed=>wwv_flow_imp.id(12491811342816807)
,p_associated_item=>wwv_flow_imp.id(12491469525816803)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(12491919503816808)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SAVE_EMPLOYEE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'    IF :P16_EMPLOYEE_ID IS NULL THEN',
'',
'        INSERT INTO employees (',
'            first_name,',
'            last_name,',
'            email,',
'            employee_status,',
'            manager_id',
'        )',
'        VALUES (',
'            :P16_FIRST_NAME,',
'            :P16_LAST_NAME,',
'            LOWER(TRIM(:P16_EMAIL)),',
'            :P16_EMPLOYEE_STATUS,',
'            :P16_MANAGER_ID',
'        )',
'        RETURNING employee_id',
'        INTO :P16_EMPLOYEE_ID;',
'',
'        apex_application.g_print_success_message :=',
unistr('            ''Employ\00E9 cr\00E9\00E9 avec succ\00E8s.'';'),
'',
'    ELSE',
'',
'        UPDATE employees',
'        SET first_name      = :P16_FIRST_NAME,',
'            last_name       = :P16_LAST_NAME,',
'            email           = LOWER(TRIM(:P16_EMAIL)),',
'            employee_status = :P16_EMPLOYEE_STATUS,',
'            manager_id      = :P16_MANAGER_ID',
'        WHERE employee_id = :P16_EMPLOYEE_ID;',
'',
'        apex_application.g_print_success_message :=',
unistr('            ''Employ\00E9 modifi\00E9 avec succ\00E8s.'';'),
'',
'    END IF;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>12491919503816808
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(12491713112816806)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'LOAD_EMPLOYEE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    IF :P16_EMPLOYEE_ID IS NOT NULL THEN',
'',
'        SELECT',
'            first_name,',
'            last_name,',
'            email,',
'            employee_status,',
'            manager_id',
'        INTO',
'            :P16_FIRST_NAME,',
'            :P16_LAST_NAME,',
'            :P16_EMAIL,',
'            :P16_EMPLOYEE_STATUS,',
'            :P16_MANAGER_ID',
'        FROM employees',
'        WHERE employee_id = :P16_EMPLOYEE_ID;',
'',
'    END IF;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>12491713112816806
);
wwv_flow_imp.component_end;
end;
/
