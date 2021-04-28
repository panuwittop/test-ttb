
*** Settings ***
Resource    global_resource.robot
Resource    global_variable.robot


*** Keywords ***
Validation Http status code success 200 OK
    [Arguments]                   ${http_status_res_code}
    Should Be Equal As Strings    ${http_status_res_code}    200

Validation Http status code success 201 Created
    [Arguments]                   ${http_status_res_code}
    Should Be Equal As Strings    ${http_status_res_code}    201

Validation Http status code 401 access token if invalid
    [Arguments]                   ${http_status_res_code}
    Should Be Equal As Strings    ${http_status_res_code}    401

Validation Http status code 400 Bad request
    [Arguments]                   ${http_status_res_code}
    Should Be Equal As Strings    ${http_status_res_code}    400

Validation Http status code 404 NOT FOUND
    [Arguments]                   ${http_status_res_code}
    Should Be Equal As Strings    ${http_status_res_code}    404    

Validation Http status code 500 the request time out
    [Arguments]                   ${http_status_res_code}
    Should Be Equal As Strings    ${http_status_res_code}    500  

Validation Http status code 500 Internal Server Error
    [Arguments]                   ${http_status_res_code}
    Should Be Equal As Strings    ${http_status_res_code}    500  


Validation field success equal true
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()}    success
    Should Be Equal As Strings    ${ResMessage}          True

Validation field success equal false
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()}    success
    Should Be Equal As Strings    ${ResMessage}          False