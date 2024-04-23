
*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot


*** Keywords ***
GET USER PROFILE SUCCESS
    Create Session    session              ${REQRES_HOST}
    ${headers}=       Create Dictionary    Accept-Language=${Accept-Language}    Content-Type=${Content-Type}    
    ${resp}=          GET On Session       session                               ${PATH_USERS}                   headers=${headers}    
    [Return]          ${resp}
    LOG               ${resp.json()}       

GET USER PROFILE NOT FOUND
    Create Session    session              ${REQRES_HOST}
    ${headers}=       Create Dictionary    Accept-Language=${Accept-Language}    Content-Type=${Content-Type}    
    ${resp}=          GET On Session       session                               ${PATH_USERS_NOT_FOUND}         headers=${headers}    
    [Return]          ${resp}
    LOG               ${resp.json()}       


Validation response body correclty
    [Arguments]                   ${resp}                
    ${ResMessage} =               Get From Dictionary    ${resp.json()["data"]}    id
    Should Be Equal As Strings    ${ResMessage}          12

    ${ResMessage} =               Get From Dictionary    ${resp.json()["data"]}     email
    Should Be Equal As Strings    ${ResMessage}          rachel.howell@reqres.in

    ${ResMessage} =               Get From Dictionary    ${resp.json()["data"]}    first_name
    Should Be Equal As Strings    ${ResMessage}          Rachel

    ${ResMessage} =               Get From Dictionary    ${resp.json()["data"]}    last_name
    Should Be Equal As Strings    ${ResMessage}          Howell

    ${ResMessage} =               Get From Dictionary    ${resp.json()["data"]}                      avatar
    Should Be Equal As Strings    ${ResMessage}          https://reqres.in/img/faces/12-image.jpg
