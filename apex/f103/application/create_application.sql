prompt --application/create_application
begin
--   Manifest
--     FLOW: 103
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>12056206813540257
,p_default_application_id=>103
,p_default_id_offset=>0
,p_default_owner=>'LEAVE_APP'
);
wwv_imp_workspace.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'LEAVE_APP')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'GESCON')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'GESCON')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'B38D6A8B7F4CE3C7DCC9DFC47F8B8E4CFF1447CE0A5C6DB210A78BFCE04F507D'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'24.2'
,p_flow_language=>'en'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_allow_feedback_yn=>'Y'
,p_date_format=>'DS'
,p_timestamp_format=>'DS'
,p_timestamp_tz_format=>'DS'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_authentication_id=>wwv_flow_imp.id(12062377223546992)
,p_application_tab_set=>0
,p_logo_type=>'I'
,p_logo=>'#APP_FILES#app-103-logo.png'
,p_public_user=>'APEX_PUBLIC_USER'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'Release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_flow_unavailable_text=>'This application is currently unavailable at this time.'
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'N'
,p_error_handling_function=>'apex_error_handler'
,p_default_error_display_loc=>'INLINE_IN_NOTIFICATION'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>'GESCON'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>33
,p_version_scn=>43072509
,p_print_server_type=>'NATIVE'
,p_file_storage=>'DB'
,p_is_pwa=>'Y'
,p_pwa_is_installable=>'N'
,p_pwa_is_push_enabled=>'N'
,p_copyright_banner=>'@ntadollar.ai - Septembre - 2026'
);
wwv_flow_imp.component_end;
end;
/
