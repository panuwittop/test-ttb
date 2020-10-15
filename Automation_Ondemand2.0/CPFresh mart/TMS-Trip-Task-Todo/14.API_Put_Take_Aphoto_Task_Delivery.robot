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
    ${TodoID_DELIVERY[2]}=    Get File                      TodoID_DELIVERY[2].txt
    ${Token}=    Get File                          TokenDriver.txt
    Set Global Variable                            ${TodoID_DELIVERY[2]}  
    Set Global Variable                            ${Token} 

TC_001_PUT TAKE A PHOTO TASK DELIVERY SUCCESS
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_009_Take_Photo.json
    ${resp}=                                      PUT Request                 session                                              /v1/todos/${TodoID_DELIVERY[2]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code success 200 OK    ${http_status_res_code} 

TC_002_PUT TAKE A PHOTO TASK DELIVERY DUPLICATE
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=${Token}                               Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_009_Take_Photo.json
    ${resp}=                                      PUT Request                 session                                              /v1/todos/${TodoID_DELIVERY[2]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 400 Bad request    ${http_status_res_code} 
    Validation take a photo duplicate               ${resp}
    

TC_003_PUT take a photo delivery access token if invalid username or password
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=xxx                               Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_009_Take_Photo.json
    ${resp}=                                      PUT Request                 session                                              /v1/todos/${TodoID_DELIVERY[2]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 400 Bad request    ${http_status_res_code} 
    Validation access token if invalid username or password               ${resp}

# TC_004_PUT take a photo task delivery Time out
#     Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
#     ${headers}=                                   Create Dictionary           Authorization=${Token}                                Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
#     ${json_string}                                Get File                    TC_009_Take_Photo.json
#     ${resp}=                                      PUT Request                 session                                              /v1/todos/${TodoID_DELIVERY[2]}    data=${json_string}                    headers=${headers} 
#     ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
#     log                                           ${resp.json()}              
#     Validation Http status code 500 the request time out   ${http_status_res_code}

TC_005_PUT take a photo task delivery data not found
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=${Token}                                Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_009_Take_Photo.json
    ${resp}=                                      PUT Request                 session                                              /v1/todos/xxx    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 400 Bad request    ${http_status_res_code} 

TC_006_PUT take a photo task delivery path environment incorect
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=${Token}                                Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_009_Take_Photo.json
    ${resp}=                                      PUT Request                 session                                              /v1/todosxxx/${TodoID_DELIVERY[2]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 404 NOT FOUND   ${http_status_res_code}  
    The requested resource could not be found   ${resp} 


TC_007_PUT take a photo task delivery required field "lat"
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=${Token}                                Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_009_Validation_Take_Photo_lat.json
    ${resp}=                                      PUT Request                 session                                              /v1/todos/${TodoID_DELIVERY[2]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 400 Bad request    ${http_status_res_code}  
    Validation required field "lat"   ${resp}   

TC_008_PUT take a photo task delivery required field "lng"
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=${Token}                                Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_009_Validation_Take_Photo_lng.json
    ${resp}=                                      PUT Request                 session                                              /v1/todos/${TodoID_DELIVERY[2]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 400 Bad request    ${http_status_res_code}  
    Validation required field "lng"   ${resp} 

TC_009_PUT take a photo task delivery required field "images"
    Create Session                                session                     http://app-4pl-tms-api.drivs.staging.tel.internal
    ${headers}=                                   Create Dictionary           Authorization=${Token}                                Content-Type=${Content-Type}     project-id=5ec78aecf3a41244b9031586    company-id=5ea93cda890a1f52c86637e3    
    ${json_string}                                Get File                    TC_009_Validation_Take_Photo.json
    ${resp}=                                      PUT Request                 session                                              /v1/todos/${TodoID_DELIVERY[2]}    data=${json_string}                    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                                  
    log                                           ${resp.json()}              
    Validation Http status code 400 Bad request    ${http_status_res_code}  
    Validation required field "images"   ${resp}     