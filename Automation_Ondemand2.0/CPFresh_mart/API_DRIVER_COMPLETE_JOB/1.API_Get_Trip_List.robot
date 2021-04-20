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



TC_001_GET Trip list success
    Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                    Content-Type=${Content-Type}                                                                                                                                                                  x-consumer-username=CPF    
    ${resp}=                                      Get Request                session                                              /v1/trips?limit=5&page=1&sort=%7B%22createdAt%22%3A%20-1%7D&search={"$and":[{"status": "PENDING"}, {"projectId": "5ec78aecf3a41244b9031586"}, {"companyId": "5ea93cda890a1f52c86637e3"}]} 
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()}             
    Validation Http status code success 200 OK    ${http_status_res_code}    
    ${TripID}=                                    Get From Dictionary        ${resp.json()["data"]["data"][0]}                    _id 
    Set Global Variable                           ${TripID}
    Create File                                   ${EXECDIR}/TripID.txt      ${TripID}                                            


TC_002_GET Trip list access token if invalid username or password
    Create Session              session              http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                 Create Dictionary    apiKey=xxxxxx                                        Content-Type=${Content-Type}                                   x-consumer-username=CPF    
    ${resp}=                    Get Request          session                                              /v1/trips?limit=5&page=1&sort=%7B%22createdAt%22%3A%20-1%7D
    ${http_status_res_code}=    Set Variable         ${resp.status_code}                                  
    log                         ${resp.json()}       

TC_003_GET Trip list data not found
    Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                    Content-Type=${Content-Type}                                   x-consumer-username=CPF    
    ${resp}=                                      Get Request                session                                              /v1/trips?limit=5&page=1&sort=%7B%22createdAt%22%3A%20-1%7D
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}    


TC_004_GET Trip list path environment incorect
    Create Session                               session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                  Create Dictionary          apiKey=${api-key}                                    Content-Type=${Content-Type}                                        x-consumer-username=CPF    
    ${resp}=                                     Get Request                session                                              /v1/tripsxxxxx?limit=5&page=1&sort=%7B%22createdAt%22%3A%20-1%7D
    ${http_status_res_code}=                     Set Variable               ${resp.status_code}                                  
    log                                          ${resp.json()} 
    Validation Http status code 404 NOT FOUND    ${http_status_res_code}    
    The requested resource could not be found    ${resp}                    


TC_005_GET Trip list projectId incorect
    Create Session                                 session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                    Create Dictionary          apiKey=${api-key}                                    Content-Type=${Content-Type}                                                                                                                                             x-consumer-username=CPF    
    ${resp}=                                       Get Request                session                                              /v1/trips?limit=5&page=1&sort=%7B%22createdAt%22%3A%20-1%7D&search={"$and":[{"status": "PENDING"}, {"projectId": "xxx"}, {"companyId": "5ea93cda890a1f52c86637e3"}]} 
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}                                  
    log                                            ${resp.json()} 
    Validation Http status code 400 Bad request    ${http_status_res_code}    
    value is invalid type projectId                ${resp} 

TC_006_GET Trip list companyId incorect
    Create Session                                 session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                    Create Dictionary          apiKey=${api-key}                                    Content-Type=${Content-Type}                                                                                                                                             x-consumer-username=CPF    
    ${resp}=                                       Get Request                session                                              /v1/trips?limit=5&page=1&sort=%7B%22createdAt%22%3A%20-1%7D&search={"$and":[{"status": "PENDING"}, {"projectId": "5ec78aecf3a41244b9031586"}, {"companyId": "xxx"}]} 
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}                                  
    log                                            ${resp.json()} 
    Validation Http status code 400 Bad request    ${http_status_res_code}    
    value is invalid type companyId                ${resp} 

TC_007_GET Trip list status order equal "PENDING"
    Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                    Content-Type=${Content-Type}                                                                                                                                                                  x-consumer-username=CPF    
    ${resp}=                                      Get Request                session                                              /v1/trips?limit=5&page=1&sort=%7B%22createdAt%22%3A%20-1%7D&search={"$and":[{"status": "PENDING"}, {"projectId": "5ec78aecf3a41244b9031586"}, {"companyId": "5ea93cda890a1f52c86637e3"}]} 
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}    

TC_008_GET Trip list status order equal "CANCELLED"
    Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                    Content-Type=${Content-Type}                                                                                                                                                                    x-consumer-username=CPF    
    ${resp}=                                      Get Request                session                                              /v1/trips?limit=5&page=1&sort=%7B%22createdAt%22%3A%20-1%7D&search={"$and":[{"status": "CANCELLED"}, {"projectId": "5ec78aecf3a41244b9031586"}, {"companyId": "5ea93cda890a1f52c86637e3"}]} 
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}    

TC_009_GET Trip list status order equal "DONE"
    Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                    Content-Type=${Content-Type}                                                                                                                                                               x-consumer-username=CPF    
    ${resp}=                                      Get Request                session                                              /v1/trips?limit=5&page=1&sort=%7B%22createdAt%22%3A%20-1%7D&search={"$and":[{"status": "DONE"}, {"projectId": "5ec78aecf3a41244b9031586"}, {"companyId": "5ea93cda890a1f52c86637e3"}]} 
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}    

# TC_0010_GET Trip list Time out
#    Create Session                                          session                     http://app-4pl-tms-api.drivs.staging.tel.internal
#    ${headers}=                                             Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}                                                                                                                                                               x-consumer-username=CPF    
#    ${resp}=                                                Get Request                 session                                              /v1/trips?limit=5&page=1&sort=%7B%22createdAt%22%3A%20-1%7D&search={"$and":[{"status": "DONE"}, {"projectId": "5ec78aecf3a41244b9031586"}, {"companyId": "5ea93cda890a1f52c86637e3"}]} 
#    ${http_status_res_code}=                                Set Variable                ${resp.status_code}                                  
#    log                                                     ${resp.json()} 
#    Validation Http status code 500 the request time out    ${http_status_res_code} 
