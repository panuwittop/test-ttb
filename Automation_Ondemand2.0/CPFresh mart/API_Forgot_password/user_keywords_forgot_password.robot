
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
