
*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot


*** Keywords ***
To verify tripID
    [Arguments]                   ${resp}
    ${TripID} =         Get From Dictionary    ${resp.json()["data"]["data"][0]}            _id
    [Return]             ${TripID}

To verify role
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary     ${resp.json()}    data
    Should Be Equal As Strings    ${ResMessage[0]}          ADMIN

The requested resource could not be found
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()}    message
    Should Be Equal As Strings    ${ResMessage_1}        The requested resource could not be found.

value is invalid type projectId
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    projectId
    Should Be Equal As Strings    ${ResMessage_1}        value xxx is invalid type of mongoose ObjectId for Model Trip

value is invalid type companyId
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    companyId
    Should Be Equal As Strings    ${ResMessage_1}        value xxx is invalid type of mongoose ObjectId for Model Trip

Validation trip id data not found 
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    _id
    Should Be Equal As Strings    ${ResMessage_1}        field not valid type mongoose ObjectId

Validation accept trip duplicate 
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage_1}        Not allowed to accept trip in the doing trip

Validation access token if invalid username or password
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage_1}        data should have required property 'userId'

Validation required field "lat"
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage_1}        data should have required property 'lat'

Validation required field "lng"
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage_1}        data should have required property 'lng'

Validation required field "images"
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage_1}        data should have required property 'images'

Validation required field "price"
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage_1}        data should have required property 'price'

Validation start task duplicate 
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage_1}        Not allowed to set off in the doing task

Validation take a photo duplicate
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage_1}        Not allowed to take_a_photo in the done todo

Validation pod duplicate 
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage_1}        Not allowed to e_signature in the done todo


Validation picked up duplicate
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage_1}        Not allowed to picked up in the done task

Validation cod duplicate
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage_1}        Not allowed to cod in the done todo

Validation delivered duplicate
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage_1}       Not allowed to delivered in the done trip

Validation driver online success 
    [Arguments]                   ${resp}
    ${ResMessage} =             Get From Dictionary    ${resp.json()["data"]}    status
    Should Be Equal As Strings    ${ResMessage}       ONLINE

Validation driver offline success 
    [Arguments]                   ${resp}
    ${ResMessage} =             Get From Dictionary    ${resp.json()["data"]}     status
    Should Be Equal As Strings    ${ResMessage}       OFFLINE
  

Validation driver online/offline is required field             
    [Arguments]                   ${resp}
    ${ResMessage} =             Get From Dictionary    ${resp.json()}     message
    Should Be Equal As Strings    ${ResMessage}       field is required

Validation driver unauthorized
     [Arguments]                   ${resp}
    ${ResMessage} =             Get From Dictionary    ${resp.json()}     message
    Should Be Equal As Strings    ${ResMessage}       Unauthorized

Validation endpoint does not exist
    [Arguments]                   ${resp}
    ${ResMessage} =             Get From Dictionary    ${resp.json()}     message
    Should Be Equal As Strings    ${ResMessage}       The requested endpoint does not exist.