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
    ${TaskID[0]}=    Get File                   TaskID[0].txt
    ${TaskID[1]}=    Get File                   TaskID[1].txt
    ${TaskID[2]}=    Get File                   TaskID[2].txt
    Set Global Variable                         ${TripID}
    Set Global Variable                         ${TaskID[0]}
    Set Global Variable                         ${TaskID[1]}
    Set Global Variable                         ${TaskID[2]}

TC_001_GET task accept trip success
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasks/${TaskID[0]}
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    ${TodoID}=                                    Get From Dictionary         ${resp.json()["data"]}                               todos
    Set Global Variable                           ${TodoID[0]}   
    Create File  ${EXECDIR}/TodoID[0].txt         ${TodoID[0]}  


TC_002_GET task accept trip token if invalid username or password
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=xxxxx                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasks/${TaskID[0]}
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
   

TC_003_GET task accept trip data not found
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasks/xxxxxx
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 400 Bad request        ${http_status_res_code} 
    Validation trip id data not found                   ${resp}


TC_004_GET task accept path environment incorect
    Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                     Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                session                                              /v1/tasksxxx/${TaskID[0]}
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()}             
    Validation Http status code 404 NOT FOUND        ${http_status_res_code} 
    The requested resource could not be found   ${resp} 

# TC_005_GET task accept time out
#     Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
#     ${headers}=                                   Create Dictionary          apiKey=${api-key}                                     Content-Type=${Content-Type}    x-consumer-username=CPF    
#     ${resp}=                                      Get Request                session                                              /v1/tripsxx/${TripID}
#     ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
#     log                                           ${resp.json()}             
#     Validation Http status code 500 the request time out   ${http_status_res_code} 

   