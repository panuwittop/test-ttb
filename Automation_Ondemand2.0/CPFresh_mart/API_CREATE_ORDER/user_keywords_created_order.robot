
*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot


*** Keywords ***
To verify response message
    [Arguments]                   ${resp}                
    ${ResMessage} =               Get From Dictionary    ${resp.json()}    message
    Should Be Equal As Strings    ${ResMessage}          xxxx

To verify create order success
    [Arguments]                   ${resp}                
    ${ResMessage} =               Get From Dictionary    ${resp.json()}    status
    Should Be Equal As Strings    ${ResMessage}          OK

To verify create order Duplicate consignment
    [Arguments]                   ${resp}                
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage}          consignment TOPTEST0000004 is duplicate

To verify create order access token if invalid
    [Arguments]                   ${resp}                
    ${ResMessage} =               Get From Dictionary    ${resp.json()}                        message
    Should Be Equal As Strings    ${ResMessage}          Invalid authentication credentials

To verify create order required field
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()}    errors
    Should Be Equal As Strings    ${ResMessage[1]}          consignment should not be empty

To verify create order required 2 field
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage}          Invalid body, check 'errors' property for more info.


To verify create order order type incorrect
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage}          order type is invalid

To verify create order vehicle type number incorrect
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage}          vehicle type is invalid

To verify consignment must be a string
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()}    errors
    Should Be Equal As Strings    ${ResMessage[0]}          consignment must be a string

To verify note sender and recipients
    [Arguments]                   ${resp}
    ${ResMessage_1} =             Get From Dictionary    ${resp.json()["data"]["data"]["sender"]}    note
    Should Be Equal As Strings    ${ResMessage_1}        Test Automation Robot sender

    ${ResMessage_2} =             Get From Dictionary    ${resp.json()["data"]["data"]["recipients"][0]}    note
    Should Be Equal As Strings    ${ResMessage_2}        Test Automation Robot recipients

To verify note lat/lng sender and recipients
    [Arguments]                   ${resp}
    ${ResMessage_1_lat} =         Get From Dictionary    ${resp.json()["data"]["data"]["sender"]}    lat
    ${ResMessage_1_lng} =         Get From Dictionary    ${resp.json()["data"]["data"]["sender"]}    lng
    Should Be Equal As Strings    ${ResMessage_1_lat}    13.6851249
    Should Be Equal As Strings    ${ResMessage_1_lng}    100.6088319

    ${ResMessage_2_lat} =         Get From Dictionary    ${resp.json()["data"]["data"]["recipients"][0]}    lat
    ${ResMessage_2_lng} =         Get From Dictionary    ${resp.json()["data"]["data"]["recipients"][0]}    lng
    Should Be Equal As Strings    ${ResMessage_2_lat}    13.7456081
    Should Be Equal As Strings    ${ResMessage_2_lng}    100.5619628

To verify time zone pick up at
    [Arguments]                   ${resp}
    ${ResMessage_1_lat} =         Get From Dictionary    ${resp.json()["data"]["data"]["sender"][]["pickUpAt"]}    start
    ${ResMessage_1_lng} =         Get From Dictionary    ${resp.json()["data"]["data"]["sender"]["pickUpAt"]}    end
    Should Be Equal As Strings    ${ResMessage_1_lat}    2020-02-04T07:00:00.000Z
    Should Be Equal As Strings    ${ResMessage_1_lng}    2020-02-04T10:00:00.000Z

To verify create order type
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["data"]["data"]}    orderType
    Should Be Equal As Strings    ${ResMessage}          2

To verify random consignment number
    [Arguments]          ${json_string}
    ${json_random}=      evaluate                  json.loads('''${json_string}''')          json
    ${random_int}        Generate random string    4                                         0123456789
    set to dictionary    ${json_random}            consignment=TEST2701IN${random_int}    
    ${json_string}=      evaluate                  json.dumps(${json_random})                json
    [Return]             ${json_string}

To verify pickup time
   [Arguments]          ${json_string} 
    ${json_random}=      evaluate                  json.loads('''${json_string}''')          json
    set to dictionary    ${json_random["sender"]["pickUpAt"]}      start=2020-09-17T07:45:16.071Z
    ${json_string}=      evaluate                  json.dumps(${json_random})                json
    [Return]             ${json_string}

