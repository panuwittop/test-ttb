
*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot


*** Keywords ***
Validation driver unauthorized
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()}    message
    Should Be Equal As Strings    ${ResMessage_1}       Unauthorized

The requested endpoint does not exist
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()}    message
    Should Be Equal As Strings    ${ResMessage_1}        The requested endpoint does not exist.

Value is invalid type projectId list history
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()}    message
    Should Be Equal As Strings    ${ResMessage_1}        Cannot destructure property `distance` of 'undefined' or 'null'.

Value is invalid type companyId list history
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()}    message
    Should Be Equal As Strings    ${ResMessage_1}        Cannot destructure property `distance` of 'undefined' or 'null'.

Validation status text correctly
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["data"]}    statusText
    Should Be Equal As Strings    ${ResMessage_1}        สำเร็จ

Validation status text incorrectly
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["data"]}    statusText
    Should Be Equal As Strings    ${ResMessage_1}        ไม่สำเร็จ