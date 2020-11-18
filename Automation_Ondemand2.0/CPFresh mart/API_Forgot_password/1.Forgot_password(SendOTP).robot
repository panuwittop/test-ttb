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


TC_0001_Driver_Forgot_password_success
    Create Session                                session                      https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary            Content-Type=${Content-Type}                language=TH
    ${json_string}                                Get File                     TC_0001_Send_OTP_success.json
    ${resp}=                                      Post Request                 session                                     /4pl-authentication/v1/otp    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                 ${resp.status_code}
    log                                           ${resp.json()}               
    Validation Http status code success 200 OK    ${http_status_res_code}      
                             



TC_0002_Driver_forgot password when path environment incorect
    Create Session                               session                    https://api.staging.true-e-logistics.com
    ${headers}=                                  Create Dictionary          Content-Type=${Content-Type}                language=TH
    ${json_string}                               Get File                   TC_0001_Send_OTP_success.json
    ${resp}=                                     Post Request               session                                     /4pl-authentication/v1/otpxxx    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                     Set Variable               ${resp.status_code}
    log                                          ${resp.json()}             
    Validation Http status code 404 NOT FOUND    ${http_status_res_code}    



# TC_0003_Driver_forgot password time out
#    Create Session                                          session                    https://api.staging.true-e-logistics.com
#    ${headers}=                                             Create Dictionary          Content-Type=${Content-Type}                language=TH
#    ${json_string}                                          Get File                   TC_0001_Send_OTP_success.json
#    ${resp}=                                                Post Request               session                                     /4pl-authentication/v1/otp    data=${json_string}    headers=${headers} 
#    ${http_status_res_code}=                                Set Variable               ${resp.status_code}
#    log                                                     ${resp.json()}             
#    Validation Http status code 500 the request time out    ${http_status_res_code}    


TC_0004_Driver_fill in phone number not complete 10 characters
    Create Session                               session                    https://api.staging.true-e-logistics.com
    ${headers}=                                  Create Dictionary          Content-Type=${Content-Type}                            language=TH             template=ODM
    ${json_string}                               Get File                   TC_0004_Phone_number not complete 10 characters.json
    ${resp}=                                     Post Request               session                                                 /4pl-authentication/v1/otp    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                     Set Variable               ${resp.status_code}
    log                                          ${resp.json()}             
    Validation Http status code 404 NOT FOUND    ${http_status_res_code}    

TC_0005_Driver_fill in phone number not available
    Create Session                               session                     https://api.staging.true-e-logistics.com
    ${headers}=                                  Create Dictionary           Content-Type=${Content-Type}                language=TH        template=ODM
    ${json_string}                               Get File                    TC_0005_Phone number not available.json
    ${resp}=                                     Post Request                session                                     /4pl-authentication/v1/otp    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                     Set Variable                ${resp.status_code}
    log                                          ${resp.json()}              
    Validation Http status code 404 NOT FOUND    ${http_status_res_code} 

TC_0006_Verify that format phone number starts with 0
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary          Content-Type=${Content-Type}                                 language=TH       template=ODM
    ${json_string}                                Get File                   TC_0006_Verify that format phone number start with 0.json
    ${resp}=                                      Post Request               session                                                      /4pl-authentication/v1/otp    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}
    log                                           ${resp.json()}             
    Validation Http status code success 200 OK    ${http_status_res_code}
    ${otpRefCode}=                                Get From Dictionary          ${resp.json()["data"]}                      otpRefCode 
    ${otpCode}=                                   Get From Dictionary          ${resp.json()["data"]}                      otpCode 
    Create File                                   ${EXECDIR}/otpRefCode.txt    ${otpRefCode}                               
    Create File                                   ${EXECDIR}/otpCode.txt       ${otpCode}         

TC_0007_Verify that format phone number with +66
    Create Session                               session                     https://api.staging.true-e-logistics.com
    ${headers}=                                  Create Dictionary           Content-Type=${Content-Type}                   language=TH       template=ODM
    ${json_string}                               Get File                    TC_0007_Verify that format phone numbe.json
    ${resp}=                                     Post Request                session                                        /4pl-authentication/v1/otp    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                     Set Variable                ${resp.status_code}
    log                                          ${resp.json()}              
    Validation Http status code 404 NOT FOUND    ${http_status_res_code} 
