
*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot


*** Keywords ***
Validation OTP success
    [Arguments]          ${json_string}
    ${json_string}=      evaluate                  json.loads('''${json_string}''')          json
    ${otpRefCode}=         Get File         otpRefCode.txt
    ${otpCode}=            Get File         otpCode.txt 
    set to dictionary    ${json_string}            otpCode=${otpCode}
    set to dictionary    ${json_string}            otpRefCode=${otpRefCode}
    ${json_string}=      evaluate                  json.dumps(${json_string})                json
    [Return]             ${json_string}

Reset password success
    [Arguments]          ${json_string}
    ${json_string}=      evaluate                  json.loads('''${json_string}''')          json
    ${token_forgotpassword}=          Get File       token_forgotpassword.txt 
    set to dictionary    ${json_string}            token=${token_forgotpassword}
    ${json_string}=      evaluate                  json.dumps(${json_string})                json
    [Return]             ${json_string}

Validation token incorrect
    [Arguments]          ${json_string}
    ${json_string}=      evaluate                  json.loads('''${json_string}''')          json
    ${token_forgotpassword}=          Get File       token_forgotpassword.txt 
    set to dictionary    ${json_string}            token=${otpCode}
    ${json_string}=      evaluate                  json.dumps(${json_string})                json
    [Return]             ${json_string}

Validation incorect pattern newpassword
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage}  data/newPassword must be an match with pattern minimum eight characters maximum twenty characters, at least one upper case English letter, one lower case English letter, one number and one special character

Validation Token has already been used
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage}  Token has already been used


Validation Invalid phone number
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage}  Invalid phone number
    
Validation Invalid token
    [Arguments]                   ${resp}
    ${ResMessage} =               Get From Dictionary    ${resp.json()["error"]}    message
    Should Be Equal As Strings    ${ResMessage}  Invalid token
