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


Login
    Create Session                                session                    http://app-4pl-authentication.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                           Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                   TC_001_login.json
    ${resp}=                                      Post Request               session                                                     /v1/auth/login-citizen-id       data=${json_string}        headers=${headers} 
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}
    log                                           ${resp.json()}             
    Validation Http status code success 200 OK    ${http_status_res_code}    
    ${Token}=                                     Get From Dictionary        ${resp.json()["data"]}                                      token
    Create File  ${EXECDIR}/TokenDriver.txt                           ${Token}
    Set Global Variable         ${Token}


Read variable text    
    ${TodoID[0]}=    Get File                      TodoID[0].txt
    Set Global Variable                            ${TodoID[0]}
         

TC_001_PUT TASK ACCEPT TRIP SUCCESS
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}    project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_lat_long.json
    ${resp}=                                      PUT Request                 session                                              /v1/todos/${TodoID[0]}          data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 

TC_002_PUT Task accept trip duplicate
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}    project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_lat_long.json
    ${resp}=                                      PUT Request                 session                                              /v1/todos/${TodoID[0]}          data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 400 Bad request    ${http_status_res_code} 
    Validation accept trip duplicate                ${resp}
            
TC_003_PUT Task accept trip access token if inval username or password
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=xxx                              Content-Type=${Content-Type}    project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_lat_long.json
    ${resp}=                                      PUT Request                 session                                              /v1/todos/${TodoID[0]}          data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 400 Bad request    ${http_status_res_code} 
    Validation access token if invalid username or password               ${resp}

# TC_004_PUT Task accept trip time out 
#     Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
#     ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}    project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
#     ${json_string}                                Get File                    TC_004_lat_long.json
#     ${resp}=                                      PUT Request                 session                                              /v1/todos/${TodoID[0]}          data=${json_string}                    headers=${headers} 
#     ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
# log                                           ${resp.json()}              
#     Validation Http status code 500 the request time out   ${http_status_res_code} 


TC_005_PUT Task accept trip data not found
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}    project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_lat_long.json
    ${resp}=                                      PUT Request                 session                                              /v1/todos/xxxxx          data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 400 Bad request    ${http_status_res_code} 

TC_006_PUT Task accept trip path environment incorect
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}    project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_lat_long.json
    ${resp}=                                      PUT Request                 session                                              /v1/todosxxx/${TodoID[0]}            data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 404 NOT FOUND   ${http_status_res_code}  
    The requested resource could not be found   ${resp} 

TC_007_PUT Task accept trip required field "lat"
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}    project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_validation_lat.json
    ${resp}=                                      PUT Request                 session                                              /v1/todos/${TodoID[0]}            data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 400 Bad request    ${http_status_res_code}  
    Validation required field "lat"   ${resp}   
    

TC_008_PUT Task accept trip required field "lng"
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}    project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_validation_lng.json
    ${resp}=                                      PUT Request                 session                                              /v1/todos/${TodoID[0]}            data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 400 Bad request    ${http_status_res_code}  
    Validation required field "lng"  ${resp}   
    