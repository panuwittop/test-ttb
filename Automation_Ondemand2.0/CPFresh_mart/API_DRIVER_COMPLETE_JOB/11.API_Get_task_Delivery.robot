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
    ${TaskID[2]}=    Get File                   TaskID[2].txt
    Set Global Variable                         ${TaskID[2]}

TC_001_GET TASK DELIVERY SUCCESS
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasks/${TaskID[2]}
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    ${TodoID_DELIVERY}=                             Get From Dictionary         ${resp.json()["data"]}                               todos
    Create File  ${EXECDIR}/TodoID_DELIVERY[0].txt                           ${TodoID_DELIVERY[0]}         
    Create File  ${EXECDIR}/TodoID_DELIVERY[1].txt                           ${TodoID_DELIVERY[1]} 
    Create File  ${EXECDIR}/TodoID_DELIVERY[2].txt                           ${TodoID_DELIVERY[2]} 
    Create File  ${EXECDIR}/TodoID_DELIVERY[3].txt                           ${TodoID_DELIVERY[3]} 
    Create File  ${EXECDIR}/TodoID_DELIVERY[4].txt                           ${TodoID_DELIVERY[4]}
    Create File  ${EXECDIR}/TodoID_DELIVERY[5].txt                           ${TodoID_Delivery[5]}  


TC_002_GET Task delivery access token if inval username or password
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasks/${TaskID[2]}
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}        


TC_003_GET Task delivery data not found
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasks/xxx
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}      
    Validation Http status code 400 Bad request    ${http_status_res_code} 


TC_004_GET Task delivery path environment incorect
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasksxxx/${TaskID[2]}
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}      
    Validation Http status code 404 NOT FOUND   ${http_status_res_code}  
    The requested resource could not be found   ${resp} 

# TC_005_GET Task delivery path environment incorect
#     Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
#     ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
#     ${resp}=                                      Get Request                 session                                              /v1/tasksxxx/${TaskID[2]}
#     ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
#     log                                           ${resp.json()}      
#     Validation Http status code 500 the request time out   ${http_status_res_code} 


