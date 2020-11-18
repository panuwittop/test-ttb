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
    ${otpRefCode}=         Get File         otpRefCode.txt
    ${otpCode}=            Get File         otpCode.txt
    Set Global Variable    ${otpRefCode}
    Set Global Variable    ${otpCode}

TC_0001_Driver_Validation_OTP_Success
    Create Session                                session                                https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary                      Content-Type=${Content-Type}                   language=TH
    ${json_string}                                Get File                               TC_0001_Validation_OTP_success.json 
    ${new_json_string}=                           Validation OTP success                 ${json_string}                                 
    ${resp}=                                      Post Request                           session                                        /4pl-authentication/v1/otp/verify/user    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                           ${resp.status_code}
    log                                           ${resp.json()}                         
    Validation Http status code success 200 OK    ${http_status_res_code}                
    ${token_forgotpassword}=                      Get From Dictionary                    ${resp.json()["data"]["resetPasswordInfo"]}    token                                
    Create File                                   ${EXECDIR}/token_forgotpassword.txt    ${token_forgotpassword}                        


TC_0002_Driver_Validation_OTP when path environment incorect
    Create Session                               session                    https://api.staging.true-e-logistics.com
    ${headers}=                                  Create Dictionary          Content-Type=${Content-Type}                language=TH
    ${json_string}                               Get File                   TC_0001_Validation_OTP_success.json 
    ${resp}=                                     Post Request               session                                     /4pl-authentication/v1/otp/verify/userxxx    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                     Set Variable               ${resp.status_code}
    log                                          ${resp.json()}             
    Validation Http status code 404 NOT FOUND    ${http_status_res_code}    



# TC_0003_Driver_Validation_OTP time out
#    Create Session                                          session                    https://api.staging.true-e-logistics.com
#    ${headers}=                                             Create Dictionary          Content-Type=${Content-Type}                language=TH
#    ${json_string}                                          Get File                   TC_0001_Validation_OTP_success.json 
#    ${resp}=                                                Post Request               session                                     /4pl-authentication/v1/otp/verify/user    data=${json_string}    headers=${headers} 
#    ${http_status_res_code}=                                Set Variable               ${resp.status_code}
#    log                                                     ${resp.json()}             
#    Validation Http status code 500 the request time out    ${http_status_res_code}    

TC_0004_Verify driver fill in OTP incorrectly
    Create Session                                 session                    https://api.staging.true-e-logistics.com
    ${headers}=                                    Create Dictionary          Content-Type=${Content-Type}                language=TH
    ${json_string}                                 Get File                   TC_0004_Validation_OTP incorrectly.json
    ${resp}=                                       Post Request               session                                     /4pl-authentication/v1/otp/verify/user    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}
    log                                            ${resp.json()}             
    Validation Http status code 400 Bad request    ${http_status_res_code}    

TC_0005_Verify driver not filled out all the OTP
    Create Session                                 session                    https://api.staging.true-e-logistics.com
    ${headers}=                                    Create Dictionary          Content-Type=${Content-Type}                          language=TH
    ${json_string}                                 Get File                   TC_0005_Validation_not filled out all the OTP.json
    ${resp}=                                       Post Request               session                                               /4pl-authentication/v1/otp/verify/user    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}
    log                                            ${resp.json()}             
    Validation Http status code 400 Bad request    ${http_status_res_code}    


TC_0006_Verify driver only fill in OTP with the number
    Create Session                                 session                    https://api.staging.true-e-logistics.com
    ${headers}=                                    Create Dictionary          Content-Type=${Content-Type}                                 language=TH
    ${json_string}                                 Get File                   TC_0006_Validation_ only fill in OTP with the number.json
    ${resp}=                                       Post Request               session                                                      /4pl-authentication/v1/otp/verify/user    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}
    log                                            ${resp.json()}             
    Validation Http status code 400 Bad request    ${http_status_res_code}    

TC_0007_Validation OTP expired 30 second
    Create Session                                 session                    https://api.staging.true-e-logistics.com
    ${headers}=                                    Create Dictionary          Content-Type=${Content-Type}                language=TH
    ${json_string}                                 Get File                   TC_0001_Validation_OTP_success.json 
    ${resp}=                                       Post Request               session                                     /4pl-authentication/v1/otp/verify/user    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}
    log                                            ${resp.json()}             
    Validation Http status code 400 Bad request    ${http_status_res_code}    