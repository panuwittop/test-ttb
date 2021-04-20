*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot
Resource    ../user_keywords.robot
Resource    ../authentication.robot
Resource    user_keywords_profile_history.robot


*** Test Cases ***

Setting Selenium Options
    Set Selenium Speed      10s
    Set Selenium Timeout    60

Login_driver
    Create Session                                session                    http://app-4pl-authentication.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                           Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                   TC_001_login.json
    ${resp}=                                      Post Request               session                                                     /v1/auth/login-citizen-id       data=${json_string}        headers=${headers} 
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}
    log                                           ${resp.json()}             
    Validation Http status code success 200 OK    ${http_status_res_code}    
    ${Authorization}=                                     Get From Dictionary        ${resp.json()["data"]}                                      token
    Set Global Variable                           ${Authorization}

TC_001_GET History list (Thai language)
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary          Authorization=${Authorization}              Content-Type=${Content-Type}    project-id=${project-id}    company-id=${company-id}    language=${language_th} 
    ${resp}=                                      Get Request                session                                     /v1/mobile/driver/schedule      headers=${headers}
    log                                           ${resp.json()}             
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                         
    Validation Http status code success 200 OK    ${http_status_res_code}    

TC_002_GET History list (Englist language)
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary          Authorization=${Authorization}              Content-Type=${Content-Type}    project-id=${project-id}    company-id=${company-id}    language=${language_en} 
    ${resp}=                                      Get Request                session                                     /v1/mobile/driver/schedule      headers=${headers}
    log                                           ${resp.json()}             
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                         
    Validation Http status code success 200 OK    ${http_status_res_code}    


TC_003_GET History list with unauthorized account 
    Create Session                    session              https://api.staging.true-e-logistics.com
    ${headers}=                       Create Dictionary    Authorization=xxxxxx                        Content-Type=${Content-Type}    project-id=${project-id}    company-id=${company-id}    language=${language_th}    
    ${resp}=                          Get Request          session                                     /v1/mobile/driver/schedule      headers=${headers}
    ${http_status_res_code}=          Set Variable         ${resp.status_code}                         
    log                               ${resp.json()}       
    Validation driver unauthorized    ${resp}              


TC_004_GET History list with incorrect path environment
    Create Session                               session                    https://api.staging.true-e-logistics.com
    ${headers}=                                  Create Dictionary          Authorization=${Authorization}              Content-Type=${Content-Type}    project-id=${project-id}    company-id=${company-id}    language=${language_th}    
    ${resp}=                                     Get Request                session                                     /v1/mobile/driver/schedulexx    headers=${headers}
    ${http_status_res_code}=                     Set Variable               ${resp.status_code}                         
    log                                          ${resp.json()} 
    Validation Http status code 404 NOT FOUND    ${http_status_res_code}    
    The requested endpoint does not exist        ${resp}                    


TC_005_GET History list with incorrect projectId
    Create Session                                           session                    https://api.staging.true-e-logistics.com
    ${headers}=                                              Create Dictionary          Authorization=${Authorization}              Content-Type=${Content-Type}    project-id=xxxx       company-id=${company-id}    language=${language_th}    
    ${resp}=                                                 Get Request                session                                     /v1/mobile/driver/schedule      headers=${headers}    
    log                                                      ${resp.json()}
    ${http_status_res_code}=                                 Set Variable               ${resp.status_code}                         
    Validation Http status code 500 Internal Server Error    ${http_status_res_code}    
    Validation an error message from incorrect projectId             ${resp} 

# TC_006_GET History list with incorrect companyId
#    Create Session                                           session                    https://api.staging.true-e-logistics.com
#    ${headers}=                                              Create Dictionary          Authorization=${Authorization}              Content-Type=${Content-Type}    project-id=${project-id}    company-id=xxxx    language=${language_th}    
#    ${resp}=                                                 Get Request                session                                     /v1/mobile/driver/schedule      headers=${headers}
#    ${http_status_res_code}=                                 Set Variable               ${resp.status_code}                         
#    log                                                      ${resp.json()} 
#    Validation Http status code 500 Internal Server Error    ${http_status_res_code}    
#    Validation an error message from incorrect companyId           ${resp} 