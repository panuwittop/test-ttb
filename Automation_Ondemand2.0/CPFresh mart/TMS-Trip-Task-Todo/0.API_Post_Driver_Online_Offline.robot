*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot
Resource    ../user_keywords.robot
Resource    ../authentication.robot
Resource    user_keywords_trip_task_todo.robot


*** Test Cases ***

Setting Selenium Options
    Set Selenium Speed      10s
    Set Selenium Timeout    60

Driver Login
    Create Session         session                http://app-4pl-authentication.drivs.staging.tel.internal
    ${headers}=            Create Dictionary      apiKey=${api-key}                                           Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}         Get File               TC_001_login.json
    ${resp}=               Post Request           session                                                     /v1/auth/login-citizen-id       data=${json_string}        headers=${headers}    
    ${Token}=              Get From Dictionary    ${resp.json()["data"]}                                      token
    Set Global Variable    ${Token}


TC_001_PUT UPDATE DRIVER OFFLINE SUCCESS
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                      Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_000_Driver_offline.json
    ${resp}=                                      PUT Request                 session                                     /v1/mobile/staff/updateStatus    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                         
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    Validation driver offline success             ${resp} 

TC_002_PUT UPDATE DRIVER ONLINE SUCCESS
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                      Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_000_Driver_online.json
    ${resp}=                                      PUT Request                 session                                     /v1/mobile/staff/updateStatus    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                         
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    Validation driver online success              ${resp} 


TC_003_PUT update driver online/offline is required field
    ${headers}=                                   Create Dictionary           Authorization=${Token}        Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_000_Driver_required_filed_online_offline.json
    ${resp}=                                      PUT Request                 session                       /v1/mobile/staff/updateStatus    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}           
    log                                           ${resp.json()}              
    Validation Http status code 400 Bad request   ${http_status_res_code} 
    Validation driver online/offline is required field             ${resp} 

# TC_004_PUT update driver online/offline time out
#    Create Session                                          session                    https://api.staging.true-e-logistics.com
#    ${headers}=                                             Create Dictionary          Authorization=${Token}                      Content-Type=${Content-Type}       project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
#    ${json_string}                                          Get File                   TC_000_Driver_online.json
#    ${resp}=                                                PUT Request                session                                     /v1/mobile/staff/updateStatus    data=${json_string}                    headers=${headers} 
#    ${http_status_res_code}=                                Set Variable               ${resp.status_code}                         
#    log                                                     ${resp.json()}             
#    Validation Http status code 500 the request time out    ${http_status_res_code}

TC_005_PUT update driver online/offline authorization if invalid
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=xxx                   Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_000_Driver_online.json
    ${resp}=                                      PUT Request                 session                                     /v1/mobile/staff/updateStatus    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                         
    log                                           ${resp.json()}              
    Validation Http status code 401 access token if invalid   ${http_status_res_code} 
    Validation driver unauthorized             ${resp} 


TC_006_PUT update driver online/offline data not found
   Create Session                                 session                     https://api.staging.true-e-logistics.com
   ${headers}=                                    Create Dictionary           Authorization=${Token}                      Content-Type=${Content-Type}    project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
   ${json_string}                                 Get File                    TC_000_Driver_online.json
   ${resp}=                                       PUT Request                 session                                     /v1/mobile/staff/updateStatus/xxxx                 data=${json_string}                    headers=${headers} 
   ${http_status_res_code}=                       Set Variable                ${resp.status_code}                         
   log                                            ${resp.json()}              
   Validation Http status code 404 NOT FOUND   ${http_status_res_code} 

TC_007_PUT update driver online/offline path environment incorect
   Create Session                               session                    https://api.staging.true-e-logistics.com
   ${headers}=                                  Create Dictionary          Authorization=${Token}                      Content-Type=${Content-Type}          project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
   ${json_string}                               Get File                   TC_000_Driver_online.json
   ${resp}=                                     PUT Request                session                                     /v1/mobile/staff/updateStatus/xxxx       data=${json_string}                    headers=${headers} 
   ${http_status_res_code}=                     Set Variable               ${resp.status_code}                         
   log                                          ${resp.json()}             
   Validation Http status code 404 NOT FOUND    ${http_status_res_code}    
   Validation endpoint does not exist    ${resp} 
