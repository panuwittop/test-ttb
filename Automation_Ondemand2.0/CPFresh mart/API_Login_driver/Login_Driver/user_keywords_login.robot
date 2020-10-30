*** Settings ***
Resource    ../../global_resource.robot
Resource    ../../global_variable.robot


*** Keywords ***

Validation Http status code success
    [Arguments]                    ${URL}                 ${ENDPOINT}            ${REQ_HEADER}=${None}
    ${resp}=                       Get Request            session                ${Path}                  
    Should Be Equal As Integers    ${resp.status_code}    200
    ${api} =                       Get From Dictionary    ${resp.json()}         success
    Should Be True                 ${api}
    ${STATUS_CODE}=                Set Variable           ${resp.status_code}
    [Return]                       ${STATUS_CODE}
    
Validation Http status code success 200 OK
    [Arguments]                   ${http_status_res_code}
    Should Be Equal As Strings    ${http_status_res_code}    200


Validation status code 404 Bad request
    [Arguments]                   ${http_status_res_code}
    Should Be Equal As Strings    ${http_status_res_code}    404

Validation data should have required property 'password'
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage}  data should have required property 'password'


Validation data should have required property citizenId and password
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage}  data should have required property 'citizenId', data should have required property 'password'


data/citizenId should be string, data should have required property 'password'
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage}  data/citizenId should be string, data should have required property 'password'
    


