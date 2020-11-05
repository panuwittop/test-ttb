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


TC_0001_Login
    Create Session                                session                    http://app-4pl-authentication.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                           Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                   TC_001_login.json
    ${resp}=                                      Post Request               session                                                     /v1/auth/login-citizen-id       data=${json_string}        headers=${headers} 
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}
    log                                           ${resp.json()}             
    Validation Http status code success 200 OK    ${http_status_res_code}    
    ${Token}=                                     Get From Dictionary        ${resp.json()["data"]}                                      token
    Set Global Variable                           ${Token}


TC_002_GET TRIP LIST
    Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                    Content-Type=${Content-Type}                                   x-consumer-username=CPF    
    ${resp}=                                      Get Request                session                                              /v1/trips?limit=5&page=1&sort=%7B%22createdAt%22%3A%20-1%7D&search={"$and":[{"status": "PENDING"}, {"projectId": "5ec78aecf3a41244b9031586"}, {"companyId": "5ea93cda890a1f52c86637e3"}]} 
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()}             
    Validation Http status code success 200 OK    ${http_status_res_code}    
    ${TripID}=                                    Get From Dictionary        ${resp.json()["data"]["data"][0]}                    _id 
    Set Global Variable                           ${TripID}

TC_003_GET TRIP ID
    Create Session                                session                    http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary          apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                session                                              /v1/trips/${TripID}
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()}             
    Validation Http status code success 200 OK    ${http_status_res_code}    
    ${TaskID}=                                    Get From Dictionary        ${resp.json()["data"]}                               tasks
    Set Global Variable                           ${TaskID[0]}               
    Set Global Variable                           ${TaskID[1]}               
    Set Global Variable                           ${TaskID[2]}               


TC_004_GET TASK ACCEPT TRIP
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasks/${TaskID[0]}
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    ${TodoID}=                                    Get From Dictionary         ${resp.json()["data"]}                               todos
    Set Global Variable                           ${TodoID[0]}                

TC_005_PUT TASK ACCEPT TRIP
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}    project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_lat_long.json
    ${resp}=                                      PUT Request                 session                                              /v1/mobile/todos/${TodoID[0]}          data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    sleep                                         3s

TC_006_GET TASK PICK UP
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasks/${TaskID[1]}
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    ${TodoID_PICKUP}=                             Get From Dictionary         ${resp.json()["data"]}                               todos
    Set Global Variable                           ${TodoID_PICKUP[0]}         
    Set Global Variable                           ${TodoID_PICKUP[1]} 
    Set Global Variable                           ${TodoID_PICKUP[2]} 
    Set Global Variable                           ${TodoID_PICKUP[3]} 
    Set Global Variable                           ${TodoID_PICKUP[4]} 

TC_007_PUT START TASK PICKUP
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_lat_long.json
    ${resp}=                                      PUT Request                 session                                              /v1/mobile/todos/${TodoID_PICKUP[0]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    sleep                                         3s


TC_008_PUT CHECK IN PICKUP
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_lat_long.json
    ${resp}=                                      PUT Request                 session                                              /v1/mobile/todos/${TodoID_PICKUP[1]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    sleep                                         3s

TC_009_PUT Take a photo (pick up)
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_009_Take_Photo.json
    ${resp}=                                      PUT Request                 session                                              /v1/mobile/todos/${TodoID_PICKUP[2]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    sleep                                         3s

TC_010_PUT POD (pick up)
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_010_POD.json
    ${resp}=                                      PUT Request                 session                                              /v1/mobile/todos/${TodoID_PICKUP[3]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    sleep                                         3s


TC_011_PUT PICKED UP (pick up)
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_lat_long.json
    ${resp}=                                      PUT Request                 session                                              /v1/mobile/todos/${TodoID_PICKUP[4]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    sleep                                         3s


TC_0012_GET TASK DELIVERY
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           apiKey=${api-key}                                    Content-Type=${Content-Type}    x-consumer-username=CPF    
    ${resp}=                                      Get Request                 session                                              /v1/tasks/${TaskID[2]}
    ${http_status_res_code}=                      Set Variable             ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    ${TodoID_Delivery}=                           Get From Dictionary         ${resp.json()["data"]}                               todos
    Set Global Variable                           ${TodoID_Delivery[0]}       
    Set Global Variable                           ${TodoID_Delivery[1]} 
    Set Global Variable                           ${TodoID_Delivery[2]} 
    Set Global Variable                           ${TodoID_Delivery[3]} 
    Set Global Variable                           ${TodoID_Delivery[4]} 
    Set Global Variable                           ${TodoID_Delivery[5]} 

TC_0013_PUT START TASK DELIVERY
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}       project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_lat_long.json
    ${resp}=                                      PUT Request                 session                                              /v1/mobile/todos/${TodoID_Delivery[0]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    sleep                                         3s


TC_0014_PUT CHECK IN DELIVERY
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}       project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_lat_long.json
    ${resp}=                                      PUT Request                 session                                              /v1/mobile/todos/${TodoID_Delivery[1]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    sleep                                         3s

TC_0015_PUT Take a photo (DELIVERY)
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}       project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_009_Take_Photo.json
    ${resp}=                                      PUT Request                 session                                              /v1/mobile/todos/${TodoID_Delivery[2]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    sleep                                         3s


TC_0016_PUT COD (DELIVERY)
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}       project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_016_COD.json
    ${resp}=                                      PUT Request                 session                                              /v1/mobile/todos/${TodoID_Delivery[3]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    sleep                                         3s

TC_017_PUT POD (DELIVERY)
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}       project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_010_POD.json
    ${resp}=                                      PUT Request                 session                                              /v1/mobile/todos/${TodoID_Delivery[4]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    sleep                                         3s


TC_018_PUT TASK DELIVERED
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}       project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_004_lat_long.json
    ${resp}=                                      PUT Request                 session                                              /v1/mobile/todos/${TodoID_Delivery[5]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 
    sleep                                         3s