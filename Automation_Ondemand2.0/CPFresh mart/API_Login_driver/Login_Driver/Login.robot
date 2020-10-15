*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot
Resource    ../authentication.robot
Resource    ../user_keywords.robot

*** Test Cases ***

TC_0001_Login
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_001_Login.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    Validation Http status code success 200 OK    ${http_status_res_code}     

TC_0002_Validation_Login_Fail
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_002_Validation _Login_fail.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    Validation status code 404 Bad request    ${http_status_res_code}     

TC_0003_Validation Test with valid username empty password such that login must get fail

    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_003_Validation _username_empty.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    Validation status code 404 Bad request     ${http_status_res_code}     

TC_004_Validation _Password_empty

    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_004_Validation _Password_empty.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    Validation status code 404 Bad request    ${http_status_res_code}     

TC_005_Validation_Empty_username_and_empty_password

    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_005_Validation_Empty_username_and_empty_password.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    Validation status code 404 Bad request    ${http_status_res_code}     

TC_006_Validation_Verify_character_limit
    
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_006_Validation_Verify_character_limit.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    Validation data should have required property 'password'   ${resp}  

TC_007_Validation_Handles_case_sensitive

    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_007_Validation_Handles_case_sensitive.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    Validation data should have required property 'password'   ${resp}  

TC_008_Validation_Enter_Username_in_characters

    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_008_Validation_Enter_Username_in_characters.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    Validation data should have required property 'password'  ${resp}

TC_009_Validation_Enter Username_in_special_characters

    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_009_Validation_Enter Username_in_special_characters.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    Validation data should have required property citizenId and password   ${resp}

TC_010_Validation_Enter_Password_in_characters

    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_010_Validation_Enter_Password_in_characters.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    Validation data should have required property 'password'   ${resp}    

TC_011_Validation_Enter_Password_in_special_characters
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_011_Validation_Enter_Password_in_special_characters.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    Validation data should have required property 'password'   ${resp}   

TC_012_Validation_Verify_type_Username_type_int

    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_012_Validation_Verify_type_Username_type_int.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    data/citizenId should be string, data should have required property 'password'  ${resp}   

TC_013_Validation_Verify_type_double

    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_013_Validation_Verify_type_double.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    data/citizenId should be string, data should have required property 'password'  ${resp} 

TC_014_Validation_Verify_type_Password_type_int

    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_014_Validation_Verify_type_Password_type_int.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    Validation data should have required property 'password'  ${resp} 

TC_015_Validation_Verify_type_Password_type_doble

    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       Content-Type=${Content-Type}
    ${json_string}                                Get File                                TC_015_Validation_Verify_type_Password_type_doble.json
    ${resp}=                                      Post Request                            session                               ${path}                         data=${json_string}      headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    Validation data should have required property 'password'  ${resp} 

