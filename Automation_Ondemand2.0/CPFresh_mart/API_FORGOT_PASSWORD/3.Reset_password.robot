*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot
Resource    ../user_keywords.robot
Resource    ../authentication.robot
Resource    user_keywords_forgot_password.robot


*** Test Cases ***

Setting Selenium Options
    Set Selenium Speed      5
    Set Selenium Timeout    60

Read variable text
    ${token_forgotpassword}=          Get File         token_forgotpassword.txt 
    Set Global Variable    ${token_forgotpassword}


TC_0001_Reset_password_success
    Create Session                                session                                https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary                      Content-Type=${Content-Type}                   language=TH
    ${json_string}                                Get File                               TC_0001_Reset_password_success.json
    ${new_json_string}=                           Reset password success                  ${json_string}                  
    ${resp}=                                      Post Request                           session                                       /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                           ${resp.status_code}
    log                                           ${resp.json()}                         
    Validation Http status code success 200 OK    ${http_status_res_code} 

TC_0002_System_should_not_be_able_to_reset_password_success_when_driver_reset_password_duplicate
    Create Session                                session                                https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary                      Content-Type=${Content-Type}                   language=TH
    ${json_string}                                Get File                               TC_0001_Reset_password_success.json
    ${new_json_string}=                           Reset password success    ${json_string}                  
    ${resp}=                                      Post Request                           session                                       /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                           ${resp.status_code}
    log                                           ${resp.json()}                         
    Validation Token has already been used    ${resp} 
   
  
Tc_0003_To_verify_can_not_validation_OTP_when_path_environment_incorect
    Create Session                                session                                https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary                      Content-Type=${Content-Type}                   language=TH
    ${json_string}                                Get File                               TC_0001_Reset_password_success.json
    ${new_json_string}=                           Reset password success    ${json_string}                  
    ${resp}=                                      Post Request                           session                                       /4pl-authentication/v1/auth/password/resetxxx    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                           ${resp.status_code}
    log                                           ${resp.json()}                         
    Validation Http status code 404 NOT FOUND  ${http_status_res_code} 

# Tc_0004_varify_that_validation_OTP_time_out
#     Create Session                                session                                https://api.staging.true-e-logistics.com
#     ${headers}=                                   Create Dictionary                      Content-Type=${Content-Type}                   language=TH
#     ${json_string}                                Get File                               TC_0001_Reset_password_success.json
#     ${new_json_string}=                           Reset password success    ${json_string}                  
#     ${resp}=                                      Post Request                           session                                       /4pl-authentication/v1/auth/password/reset   data=${new_json_string}    headers=${headers} 
#     ${http_status_res_code}=                      Set Variable                           ${resp.status_code}
#     log                                           ${resp.json()}                         
#     Validation Http status code 500 the request time out    ${http_status_res_code}  

Tc_0005_Verify_that_driver_fill_in_new_password is_not_valid_according_to_the_pattern.
    Create Session                                session                                https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary                      Content-Type=${Content-Type}                   language=TH
    ${json_string}                                Get File                               Tc_0005_newpassword_incorect_pattern.json
    ${new_json_string}=                           Reset password success    ${json_string}                  
    ${resp}=                                      Post Request                           session                                       /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                           ${resp.status_code}
    log                                           ${resp.json()}                         
    Validation incorect pattern newpassword   ${resp} 

Tc_0006_Verify_that_driver_fill_in_new_password_is_more_than_20_characters
    Create Session                                session                                https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary                      Content-Type=${Content-Type}                   language=TH
    ${json_string}                                Get File                               Tc_0006_newpassword_fill_in_more_than_20_characters.json
    ${new_json_string}=                           Reset password success    ${json_string}                  
    ${resp}=                                      Post Request                           session                                       /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                           ${resp.status_code}
    log                                           ${resp.json()}                         
    Validation incorect pattern newpassword   ${resp} 

Tc_0007_Verify_that_driver_fill_in_phone_number_incorrectly
    Create Session                                session                                https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary                      Content-Type=${Content-Type}                   language=TH
    ${json_string}                                Get File                               Tc_0007_newpassword_Invalid_phone_number.json
    ${new_json_string}=                           Reset password success                   ${json_string}                  
    ${resp}=                                      Post Request                           session                                       /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                           ${resp.status_code}
    log                                           ${resp.json()}  
    Validation Invalid phone number     ${resp} 

Tc_0008_Verify_that_driver_not_fill_in_new_password 
    Create Session                                session                            https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary                      Content-Type=${Content-Type}                   language=TH
    ${json_string}                                Get File                               Tc_0008_newpassword_not_fill_in_new_password.json
    ${new_json_string}=                           Reset password success                ${json_string}                  
    ${resp}=                                      Post Request                           session                                       /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                           ${resp.status_code}
    log                                           ${resp.json()}                         
    Validation incorect pattern newpassword   ${resp} 


Tc_0009_fill_in_token_incorrectly
    Create Session                                session                                https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                Tc_0009_fill_in_token_incorrectly.json
    ${resp}=                                      Post Request                            session                              4pl-authentication/v1/auth/password/reset    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()}                         
    Validation Invalid token   ${resp} 


# Tc_0010_Verify that driver reset password expired
#     Create Session                                session                                https://api.staging.true-e-logistics.com
#     ${headers}=                                   Create Dictionary                      Content-Type=${Content-Type}                   language=TH
#     ${json_string}                                Get File                               TC_0001_Reset_password_success.json
#     ${new_json_string}=                           Reset password success    ${json_string}                  
#     ${resp}=                                      Post Request                           session                                       /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
#     ${http_status_res_code}=                      Set Variable                           ${resp.status_code}
#     log                                           ${resp.json()}                         
#     Validation Invalid token   ${resp}  