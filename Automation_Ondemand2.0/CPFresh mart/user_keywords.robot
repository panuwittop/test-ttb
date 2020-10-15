
*** Settings ***
Resource    global_resource.robot
Resource    global_variable.robot


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


Validation field success equal true
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()}    success
    Should Be Equal As Strings    ${ResMessage}          True

Validation field success equal false
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()}    success
    Should Be Equal As Strings    ${ResMessage}          False

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
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"][0]["constraints"]}    isNotDuplicate
    Should Be Equal As Strings    ${ResMessage}          consignment is duplicate

To verify create order access token if invalid
    [Arguments]                   ${resp}                
    ${ResMessage} =               Get From Dictionary    ${resp.json()}                        message
    Should Be Equal As Strings    ${ResMessage}          Invalid authentication credentials

To verify create order required field
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"][0]["constraints"]}    isNotEmpty
    Should Be Equal As Strings    ${ResMessage}          consignment should not be empty

To verify create order required 2 field
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"][1]["constraints"]}    isInt
    Should Be Equal As Strings    ${ResMessage}          orderType must be an integer number


To verify create order order type incorrect
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"][0]["constraints"]}    isValidOrderType
    Should Be Equal As Strings    ${ResMessage}          orderType is not valid

To verify create order vehicle type number incorrect
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"][0]["children"][0]["constraints"]}    isValidVehicleType
    Should Be Equal As Strings    ${ResMessage}          type is not valid

To verify consignment must be a string
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"][0]["constraints"]}    isString
    Should Be Equal As Strings    ${ResMessage}          consignment must be a string

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

Validation random consignment number
    [Arguments]          ${json_string}
    ${json_random}=      evaluate                  json.loads('''${json_string}''')          json
    ${random_int}        Generate random string    4                                         0123456789
    set to dictionary    ${json_random}            consignment=AUTOTEST00IN${random_int}    
    ${json_string}=      evaluate                  json.dumps(${json_random})                json
    [Return]             ${json_string}

Validation pickup time
   [Arguments]          ${json_string} 
    ${json_random}=      evaluate                  json.loads('''${json_string}''')          json
    set to dictionary    ${json_random["sender"]["pickUpAt"]}      start=2020-09-17T07:45:16.071Z
    ${json_string}=      evaluate                  json.dumps(${json_random})                json
    [Return]             ${json_string}


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
  
