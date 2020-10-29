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

Read variable text    
    ${TripID}=    Get File                      TripID.txt
    Set Global Variable                         ${TripID}


TC_001_GET Trip id Success
    Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                session                                              /v1/trips/${TripID}
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()}             
    Validation Http status code success 200 OK    ${http_status_res_code}    
    ${TaskID}=                                    Get From Dictionary        ${resp.json()["data"]}                               tasks
    Create File  ${EXECDIR}/TaskID[0].txt                           ${TaskID[0]}               
    Create File  ${EXECDIR}/TaskID[1].txt                          ${TaskID[1]}               
    Create File  ${EXECDIR}/TaskID[2].txt                           ${TaskID[2]}     

TC_002_GET Trip id access token if invalid username or password
    Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=xxx                                   Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                session                                              /v1/trips/${TripID}
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()}     

TC_003_GET Trip id data not found
    Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                     Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                session                                              /v1/trips/5f7be9cef326430011b43e8dxx
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()}             
    Validation Http status code 400 Bad request        ${http_status_res_code} 
    Validation trip id data not found                   ${resp}

TC_004_GET Trip id path environment incorect
    Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                     Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                session                                              /v1/tripsxx/${TripID}
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()}             
    Validation Http status code 404 NOT FOUND        ${http_status_res_code} 
    The requested resource could not be found   ${resp} 

# TC_005_GET Trip id time out
#     Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
#     ${headers}=                                   Create Dictionary          apiKey=${api-key}                                     Content-Type=${Content-Type}    x-consumer-username=CPF    
#     ${resp}=                                      Get Request                session                                              /v1/tripsxx/${TripID}
#     ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
#     log                                           ${resp.json()}             
#     Validation Http status code 500 the request time out   ${http_status_res_code} 

   