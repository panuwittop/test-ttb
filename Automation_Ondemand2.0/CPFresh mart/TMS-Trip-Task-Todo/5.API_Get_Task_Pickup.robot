*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot
Resource    ../user_keywords.robot
Resource    ../authentication.robot


*** Test Cases ***

Setting Selenium Options
    Set Selenium Speed      10s
    Set Selenium Timeout    60


Read variable text    
    ${TaskID[1]}=    Get File                      TaskID[1].txt
    Set Global Variable                            ${TaskID[1]}            


TC_001_GET TASK PICK UP SUCCESS
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasks/${TaskID[1]}
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    ${TodoID_PICKUP}=                             Get From Dictionary         ${resp.json()["data"]}                               todos
    Create File  ${EXECDIR}/TodoID_PICKUP[0].txt                           ${TodoID_PICKUP[0]}         
    Create File  ${EXECDIR}/TodoID_PICKUP[1].txt                           ${TodoID_PICKUP[1]} 
    Create File  ${EXECDIR}/TodoID_PICKUP[2].txt                            ${TodoID_PICKUP[2]} 
    Create File  ${EXECDIR}/TodoID_PICKUP[3].txt                            ${TodoID_PICKUP[3]} 
    Create File  ${EXECDIR}/TodoID_PICKUP[4].txt                            ${TodoID_PICKUP[4]} 


TC_002_GET Task pick up access token if inval username or password
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasks/${TaskID[1]}
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}        


TC_003_GET Task pick up data not found
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasks/xxx
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}      
    Validation Http status code 400 Bad request    ${http_status_res_code} 


TC_004_GET Task pick up path environment incorect
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasksxxx/${TaskID[1]}
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}      
    Validation Http status code 404 NOT FOUND   ${http_status_res_code}  
    The requested resource could not be found   ${resp} 

# TC_005_GET Task pick up path environment incorect
#     Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
#     ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
#     ${resp}=                                      Get Request                 session                                              /v1/tasksxxx/${TaskID[1]}
#     ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
#     log                                           ${resp.json()}      
#     Validation Http status code 500 the request time out   ${http_status_res_code} 


