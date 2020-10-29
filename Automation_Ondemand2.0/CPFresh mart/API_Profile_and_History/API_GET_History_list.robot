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


TC_001_GET History list (Thai language)
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary          Authorization=${Authorization}                                    Content-Type=${Content-Type}                     project-id=${project-id}   company-id=${company-id}   language=${language_th} 
    ${resp}=                                      Get Request                session                       /v1/mobile/driver/schedule              headers=${headers}
    log                                           ${resp.json()}   
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                            
    Validation Http status code success 200 OK    ${http_status_res_code}   

TC_002_GET History list (Englist language)
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary          Authorization=${Authorization}                                    Content-Type=${Content-Type}                     project-id=${project-id}   company-id=${company-id}   language=${language_en} 
    ${resp}=                                      Get Request                session                       /v1/mobile/driver/schedule              headers=${headers}
    log                                           ${resp.json()}   
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                            
    Validation Http status code success 200 OK    ${http_status_res_code}   


TC_003_GET History list access token unauthorized
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary          Authorization=xxxxxx                                      Content-Type=${Content-Type}           project-id=${project-id}   company-id=${company-id}   language=${language_th}                    
    ${resp}=                                      Get Request                session                                           /v1/mobile/driver/schedule              headers=${headers}
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()}  
    Validation driver unauthorized                ${resp}  
   

TC_004_GET History list path environment incorect
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary          Authorization=${Authorization}                                      Content-Type=${Content-Type}           project-id=${project-id}   company-id=${company-id}   language=${language_th}                            
    ${resp}=                                      Get Request                session                                              /v1/mobile/driver/schedulexx              headers=${headers}
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
    log                                           ${resp.json()} 
    Validation Http status code 404 NOT FOUND   ${http_status_res_code}  
    The requested endpoint does not exist   ${resp}  


TC_005_GET History list projectId incorect
    Create Session                                session                    https://api.staging.true-e-logistics.com
    ${headers}=                                   Create Dictionary         Authorization=${Authorization}                                       Content-Type=${Content-Type}        project-id=xxxx   company-id=${company-id}   language=${language_th}                       
    ${resp}=                                      Get Request                session                  /v1/mobile/driver/schedule              headers=${headers}                           
    log                                           ${resp.json()}
    ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                   
    Validation Http status code 500 Internal Server Error   ${http_status_res_code}  
    Value is invalid type projectId list history                      ${resp} 

# TC_006_GET History list companyId incorect
#     Create Session                                session                   https://api.staging.true-e-logistics.com
#     ${headers}=                                   Create Dictionary          Authorization=${Authorization}                                      Content-Type=${Content-Type}          project-id=${project-id}   company-id=xxxx   language=${language_th}                                   
#     ${resp}=                                      Get Request                session                                            /v1/mobile/driver/schedule              headers=${headers}
#     ${http_status_res_code}=                      Set Variable               ${resp.status_code}                                  
#     log                                           ${resp.json()} 
#     Validation Http status code 500 Internal Server Error  ${http_status_res_code}  
#     Value is invalid type companyId list history                      ${resp} 
