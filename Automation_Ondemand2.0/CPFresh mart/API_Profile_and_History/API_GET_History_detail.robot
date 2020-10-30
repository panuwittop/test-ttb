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


TC_001_GET History detail happay case (order status : delivered)
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary          Authorization=${Authorization}              Content-Type=${Content-Type}                                  project-id=${project-id}    company-id=${company-id}    language=${language_th} 
    ${resp}=                                      Get Request                session                                     /v1/mobile/driver/schedule/detail/5f91356d9605610011f98954    headers=${headers}
    log                                           ${resp.json()}             
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                         
    Validation Http status code success 200 OK    ${http_status_res_code}
    Validation status text correctly              ${resp}

TC_002_GET History detail happay case (combine order status : delivered)
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary          Authorization=${Authorization}              Content-Type=${Content-Type}                                  project-id=${project-id}    company-id=${company-id}    language=${language_th} 
    ${resp}=                                      Get Request                session                                     /v1/mobile/driver/schedule/detail/5f97b9fb460c00001158a03a    headers=${headers}
    log                                           ${resp.json()}             
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                         
    Validation Http status code success 200 OK    ${http_status_res_code}
    Validation status text correctly              ${resp}                    

TC_003_GET History detail happay case (order status : Partial Delivered)
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary          Authorization=${Authorization}              Content-Type=${Content-Type}                                  project-id=${project-id}    company-id=${company-id}    language=${language_en} 
    ${resp}=                                      Get Request                session                                     /v1/mobile/driver/schedule/detail/5f97c345460c00001158a0b4    headers=${headers}
    log                                           ${resp.json()}             
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                         
    Validation Http status code success 200 OK    ${http_status_res_code}
    Validation status text correctly              ${resp}                    

TC_004_GET History detail unhappay case (order status : Canceled)
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary          Authorization=${Authorization}              Content-Type=${Content-Type}                                  project-id=${project-id}    company-id=${company-id}    language=${language_en} 
    ${resp}=                                      Get Request                session                                     /v1/mobile/driver/schedule/detail/5f979f10460c000011589e37    headers=${headers}
    log                                           ${resp.json()}             
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                         
    Validation Http status code success 200 OK    ${http_status_res_code}
    Validation status text incorrectly            ${resp} 

TC_005_GET History detail unhappay case (order status : Failed)
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Authorization}              Content-Type=${Content-Type}                                  project-id=${project-id}    company-id=${company-id}    language=${language_en} 
    ${resp}=                                      Get Request                 session                                     /v1/mobile/driver/schedule/detail/5f979ce2460c000011589dd8    headers=${headers}
    log                                           ${resp.json()}              
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                         
    Validation Http status code success 200 OK    ${http_status_res_code} 
    Validation status text incorrectly            ${resp} 

TC_006_GET History detail unhappay case(order status : Rejected)
    Create Session                                session                     https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary           Authorization=${Authorization}              Content-Type=${Content-Type}                                  project-id=${project-id}    company-id=${company-id}    language=${language_en} 
    ${resp}=                                      Get Request                 session                                     /v1/mobile/driver/schedule/detail/5f9140499605610011f98bd8    headers=${headers}
    log                                           ${resp.json()}              
    ${http_status_res_code}=                      Set Variable                ${resp.status_code}                         
    Validation Http status code success 200 OK    ${http_status_res_code} 
    Validation status text incorrectly            ${resp} 