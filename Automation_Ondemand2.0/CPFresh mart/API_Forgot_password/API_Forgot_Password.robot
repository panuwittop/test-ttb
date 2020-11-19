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
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary          Content-Type=${Content-Type}                language=TH
    ${json_string}                                Get File                   TC_0001_Send_OTP_success.json
    ${resp}=                                      Post Request               session                                     /4pl-authentication/v1/otp    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}
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
    ${headers}=                                  Create Dictionary          Content-Type=${Content-Type}                            language=TH                   template=ODM
    ${json_string}                               Get File                   TC_0004_Phone_number not complete 10 characters.json
    ${resp}=                                     Post Request               session                                                 /4pl-authentication/v1/otp    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                     Set Variable               ${resp.status_code}
    log                                          ${resp.json()}             
    Validation Http status code 404 NOT FOUND    ${http_status_res_code}    

TC_0005_Driver_fill in phone number not available
    Create Session                               session                     https://api.staging.true-e-logistics.com
    ${headers}=                                  Create Dictionary           Content-Type=${Content-Type}                language=TH                   template=ODM
    ${json_string}                               Get File                    TC_0005_Phone number not available.json
    ${resp}=                                     Post Request                session                                     /4pl-authentication/v1/otp    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                     Set Variable                ${resp.status_code}
    log                                          ${resp.json()}              
    Validation Http status code 404 NOT FOUND    ${http_status_res_code} 

TC_0006_Verify that format phone number starts with 0
    Create Session                                session                      https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary            Content-Type=${Content-Type}                                 language=TH                   template=ODM
    ${json_string}                                Get File                     TC_0006_Verify that format phone number start with 0.json
    ${resp}=                                      Post Request                 session                                                      /4pl-authentication/v1/otp    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                 ${resp.status_code}
    log                                           ${resp.json()}               
    Validation Http status code success 200 OK    ${http_status_res_code}
    ${otpRefCode}=                                Get From Dictionary          ${resp.json()["data"]}                                       otpRefCode 
    ${otpCode}=                                   Get From Dictionary          ${resp.json()["data"]}                                       otpCode 
    Create File                                   ${EXECDIR}/otpRefCode.txt    ${otpRefCode}                                                
    Create File                                   ${EXECDIR}/otpCode.txt       ${otpCode}                                                   
    Set Global Variable                           ${otpRefCode}
    Set Global Variable                           ${otpCode}                   

TC_0007_Verify that format phone number with +66
    Create Session                               session                     https://api.staging.true-e-logistics.com
    ${headers}=                                  Create Dictionary           Content-Type=${Content-Type}                   language=TH                   template=ODM
    ${json_string}                               Get File                    TC_0007_Verify that format phone numbe.json
    ${resp}=                                     Post Request                session                                        /4pl-authentication/v1/otp    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                     Set Variable                ${resp.status_code}
    log                                          ${resp.json()}              
    Validation Http status code 404 NOT FOUND    ${http_status_res_code} 


TC_0008_Driver Validation OTP Success
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
    Set Global Variable                           ${token_forgotpassword}

TC_0009_Driver Validation OTP when path environment incorect
    Create Session                               session                    https://api.staging.true-e-logistics.com
    ${headers}=                                  Create Dictionary          Content-Type=${Content-Type}                language=TH
    ${json_string}                               Get File                   TC_0001_Validation_OTP_success.json 
    ${resp}=                                     Post Request               session                                     /4pl-authentication/v1/otp/verify/userxxx    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                     Set Variable               ${resp.status_code}
    log                                          ${resp.json()}             
    Validation Http status code 404 NOT FOUND    ${http_status_res_code}    



# TC_00010_Driver_Validation_OTP time out
#    Create Session                                          session                    https://api.staging.true-e-logistics.com
#    ${headers}=                                             Create Dictionary          Content-Type=${Content-Type}                language=TH
#    ${json_string}                                          Get File                   TC_0001_Validation_OTP_success.json 
#    ${resp}=                                                Post Request               session                                     /4pl-authentication/v1/otp/verify/user    data=${json_string}    headers=${headers} 
#    ${http_status_res_code}=                                Set Variable               ${resp.status_code}
#    log                                                     ${resp.json()}             
#    Validation Http status code 500 the request time out    ${http_status_res_code}    

TC_00011_Verify driver fill in OTP incorrectly
    Create Session                                 session                    https://api.staging.true-e-logistics.com
    ${headers}=                                    Create Dictionary          Content-Type=${Content-Type}                language=TH
    ${json_string}                                 Get File                   TC_0004_Validation_OTP incorrectly.json
    ${resp}=                                       Post Request               session                                     /4pl-authentication/v1/otp/verify/user    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}
    log                                            ${resp.json()}             
    Validation Http status code 400 Bad request    ${http_status_res_code}    

TC_00012_Verify driver not filled out all the OTP
    Create Session                                 session                    https://api.staging.true-e-logistics.com
    ${headers}=                                    Create Dictionary          Content-Type=${Content-Type}                          language=TH
    ${json_string}                                 Get File                   TC_0005_Validation_not filled out all the OTP.json
    ${resp}=                                       Post Request               session                                               /4pl-authentication/v1/otp/verify/user    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}
    log                                            ${resp.json()}             
    Validation Http status code 400 Bad request    ${http_status_res_code}    


TC_00013_Verify driver only fill in OTP with the number
    Create Session                                 session                    https://api.staging.true-e-logistics.com
    ${headers}=                                    Create Dictionary          Content-Type=${Content-Type}                                 language=TH
    ${json_string}                                 Get File                   TC_0006_Validation_ only fill in OTP with the number.json
    ${resp}=                                       Post Request               session                                                      /4pl-authentication/v1/otp/verify/user    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}
    log                                            ${resp.json()}             
    Validation Http status code 400 Bad request    ${http_status_res_code}    

TC_00014_Validation OTP expired 30 second
    Create Session                                 session                    https://api.staging.true-e-logistics.com
    ${headers}=                                    Create Dictionary          Content-Type=${Content-Type}                language=TH
    ${json_string}                                 Get File                   TC_0001_Validation_OTP_success.json 
    ${resp}=                                       Post Request               session                                     /4pl-authentication/v1/otp/verify/user    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}
    log                                            ${resp.json()}             
    Validation Http status code 400 Bad request    ${http_status_res_code}    


TC_00015_Reset password success
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Content-Type=${Content-Type}                language=TH
    ${json_string}                                Get File                    TC_0001_Reset_password_success.json
    ${new_json_string}=                           Reset password success      ${json_string}                              
    ${resp}=                                      Post Request                session                                     /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 

TC_00016_System should not be able to reset password success when driver reset password duplicate
    Create Session                            session                   https://api.staging.true-e-logistics.com
    ${headers}=                               Create Dictionary         Content-Type=${Content-Type}                language=TH
    ${json_string}                            Get File                  TC_0001_Reset_password_success.json
    ${new_json_string}=                       Reset password success    ${json_string}                              
    ${resp}=                                  Post Request              session                                     /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                  Set Variable              ${resp.status_code}
    log                                       ${resp.json()}            
    Validation Token has already been used    ${resp} 


Tc_00017_To verify can not validation OTP when path environment incorect
    Create Session                               session                     https://api.staging.true-e-logistics.com
    ${headers}=                                  Create Dictionary           Content-Type=${Content-Type}                language=TH
    ${json_string}                               Get File                    TC_0001_Reset_password_success.json
    ${new_json_string}=                          Reset password success      ${json_string}                              
    ${resp}=                                     Post Request                session                                     /4pl-authentication/v1/auth/password/resetxxx    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                     Set Variable                ${resp.status_code}
    log                                          ${resp.json()}              
    Validation Http status code 404 NOT FOUND    ${http_status_res_code} 

# Tc_00018 varify tha validation OTP time out
#    Create Session                                          session                    https://api.staging.true-e-logistics.com
#    ${headers}=                                             Create Dictionary          Content-Type=${Content-Type}                language=TH
#    ${json_string}                                          Get File                   TC_0001_Reset_password_success.json
#    ${new_json_string}=                                     Reset password success     ${json_string}                              
#    ${resp}=                                                Post Request               session                                     /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
#    ${http_status_res_code}=                                Set Variable               ${resp.status_code}
#    log                                                     ${resp.json()}             
#    Validation Http status code 500 the request time out    ${http_status_res_code}    

Tc_00019_Verify that driver fill in new password is not valid according to the pattern.
    Create Session                             session                   https://api.staging.true-e-logistics.com
    ${headers}=                                Create Dictionary         Content-Type=${Content-Type}                 language=TH
    ${json_string}                             Get File                  Tc_0005_newpassword_incorect_pattern.json
    ${new_json_string}=                        Reset password success    ${json_string}                               
    ${resp}=                                   Post Request              session                                      /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                   Set Variable              ${resp.status_code}
    log                                        ${resp.json()}            
    Validation incorect pattern newpassword    ${resp} 

Tc_00020_Verify that driver fill in new password is more than 20 characters
    Create Session                             session                   https://api.staging.true-e-logistics.com
    ${headers}=                                Create Dictionary         Content-Type=${Content-Type}                                language=TH
    ${json_string}                             Get File                  Tc_0006_newpassword_fill_in_more_than_20_characters.json
    ${new_json_string}=                        Reset password success    ${json_string}                                              
    ${resp}=                                   Post Request              session                                                     /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                   Set Variable              ${resp.status_code}
    log                                        ${resp.json()}            
    Validation incorect pattern newpassword    ${resp} 

Tc_00021_Verify that driver fill in phone number incorrectly
    Create Session                     session                   https://api.staging.true-e-logistics.com
    ${headers}=                        Create Dictionary         Content-Type=${Content-Type}                     language=TH
    ${json_string}                     Get File                  Tc_0007_newpassword_Invalid_phone_number.json
    ${new_json_string}=                Reset password success    ${json_string}                                   
    ${resp}=                           Post Request              session                                          /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=           Set Variable              ${resp.status_code}
    log                                ${resp.json()}            
    Validation Invalid phone number    ${resp} 

Tc_00022_Verify that driver not fill in new password
    Create Session                             session                   https://api.staging.true-e-logistics.com
    ${headers}=                                Create Dictionary         Content-Type=${Content-Type}                         language=TH
    ${json_string}                             Get File                  Tc_0008_newpassword_not_fill_in_new_password.json
    ${new_json_string}=                        Reset password success    ${json_string}                                       
    ${resp}=                                   Post Request              session                                              /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                   Set Variable              ${resp.status_code}
    log                                        ${resp.json()}            
    Validation incorect pattern newpassword    ${resp} 


Tc_00023_fill in token incorrectly
    Create Session              session              https://api.staging.true-e-logistics.com
    ${headers}=                 Create Dictionary    Content-Type=${Content-Type}
    ${json_string}              Get File             Tc_0009_fill_in_token_incorrectly.json
    ${resp}=                    Post Request         session                                     4pl-authentication/v1/auth/password/reset    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=    Set Variable         ${resp.status_code}
    log                         ${resp.json()}       
    Validation Invalid token    ${resp} 


# Tc_0024_Verify that driver reset password expired
#    Create Session              session                   https://api.staging.true-e-logistics.com
#    ${headers}=                 Create Dictionary         Content-Type=${Content-Type}                language=TH
#    ${json_string}              Get File                  TC_0001_Reset_password_success.json
#    ${new_json_string}=         Reset password success    ${json_string}                              
#    ${resp}=                    Post Request              session                                     /4pl-authentication/v1/auth/password/reset    data=${new_json_string}    headers=${headers} 
#    ${http_status_res_code}=    Set Variable              ${resp.status_code}
#    log                         ${resp.json()}            
#    Validation Invalid token    ${resp}                   