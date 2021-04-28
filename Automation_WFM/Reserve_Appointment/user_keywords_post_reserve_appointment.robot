
*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot


*** Keywords ***
GET CURRENT TIME
    ${Crrent_time}=        Get Current Date    result_format=%Y-%m-%d
    Set Global Variable    ${Crrent_time}


RESERVE APPOINTMENT TYPE RULE 1
    Create Session    session              ${wfm_host} 
    ${headers}=       Create Dictionary    x-api-key=${api-key}                   Content-Type=${Content-Type}    
    ${json_string}    Get File             BODY_RESERVE_APPOINTMENT_TYPE1.json

    ### Change body "INSTALLATION_DATE" ###
    ${json_current_time}=    evaluate                json.loads('''${json_string}''')    json
    set to dictionary    ${json_current_time["APPOINTMENT_TIME"]}      APPOINTMENT_DATE=${Crrent_time}
    ${json_string}=          evaluate                json.dumps(${json_current_time})    json

    ### POST APPOINTMENT ###
    ${resp}=                    Post Request      session                ${wfm_path_reserve_appointment}    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=    Set Variable      ${resp.status_code}
    log                         ${resp.json()}    

    ${Verify_ruletype} =          Get From Dictionary        ${resp.json()}    RULE_TYPE
    Should Be Equal As Strings    ${Verify_ruletype}         1                 
    [Return]                      ${http_status_res_code}    


RESERVE APPOINTMENT TYPE RULE 2
    Create Session    session              ${wfm_host} 
    ${headers}=       Create Dictionary    x-api-key=${api-key}                   Content-Type=${Content-Type}    
    ${json_string}    Get File             BODY_RESERVE_APPOINTMENT_TYPE2.json

    ### Change body "INSTALLATION_DATE" ###
    ${json_current_time}=    evaluate                json.loads('''${json_string}''')    json
    set to dictionary    ${json_current_time["APPOINTMENT_TIME"]}      APPOINTMENT_DATE=${Crrent_time}
    ${json_string}=          evaluate                json.dumps(${json_current_time})    json

    ### POST APPOINTMENT ###
    ${resp}=                    Post Request      session                ${wfm_path_reserve_appointment}    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=    Set Variable      ${resp.status_code}
    log                         ${resp.json()}    

    ${Verify_ruletype} =          Get From Dictionary        ${resp.json()}    RULE_TYPE
    Should Be Equal As Strings    ${Verify_ruletype}         2                 
    [Return]                      ${http_status_res_code}    

RESERVE APPOINTMENT TYPE RULE 3
    Create Session    session              ${wfm_host} 
    ${headers}=       Create Dictionary    x-api-key=${api-key}                   Content-Type=${Content-Type}    
    ${json_string}    Get File             BODY_RESERVE_APPOINTMENT_TYPE3.json

    ### Change body "INSTALLATION_DATE" ###
    ${json_current_time}=    evaluate                json.loads('''${json_string}''')    json
    set to dictionary    ${json_current_time["APPOINTMENT_TIME"]}      APPOINTMENT_DATE=${Crrent_time}
    ${json_string}=          evaluate                json.dumps(${json_current_time})    json

    ### POST APPOINTMENT ###
    ${resp}=                    Post Request      session                ${wfm_path_reserve_appointment}    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=    Set Variable      ${resp.status_code}
    log                         ${resp.json()}    

    ${Verify_ruletype} =          Get From Dictionary        ${resp.json()}    RULE_TYPE
    Should Be Equal As Strings    ${Verify_ruletype}         3                 
    [Return]                      ${http_status_res_code}    

RESERVE APPOINTMENT TYPE RULE 4
    Create Session    session              ${wfm_host} 
    ${headers}=       Create Dictionary    x-api-key=${api-key}                   Content-Type=${Content-Type}    
    ${json_string}    Get File             BODY_RESERVE_APPOINTMENT_TYPE4.json

    ### Change body "INSTALLATION_DATE" ###
    ${json_current_time}=    evaluate                json.loads('''${json_string}''')    json
    set to dictionary    ${json_current_time["APPOINTMENT_TIME"]}      APPOINTMENT_DATE=${Crrent_time}
    ${json_string}=          evaluate                json.dumps(${json_current_time})    json

    ### POST APPOINTMENT ###
    ${resp}=                    Post Request      session                ${wfm_path_reserve_appointment}    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=    Set Variable      ${resp.status_code}
    log                         ${resp.json()}    

    ${Verify_ruletype} =          Get From Dictionary        ${resp.json()}    RULE_TYPE
    Should Be Equal As Strings    ${Verify_ruletype}         4                 
    [Return]                      ${http_status_res_code}    

RESERVE APPOINTMENT TYPE RULE 6
    Create Session    session              ${wfm_host} 
    ${headers}=       Create Dictionary    x-api-key=${api-key}                   Content-Type=${Content-Type}    
    ${json_string}    Get File             BODY_RESERVE_APPOINTMENT_TYPE6.json

    ### Change body "INSTALLATION_DATE" ###
    ${json_current_time}=    evaluate                json.loads('''${json_string}''')    json
    set to dictionary    ${json_current_time["APPOINTMENT_TIME"]}      APPOINTMENT_DATE=${Crrent_time}
    ${json_string}=          evaluate                json.dumps(${json_current_time})    json

    ### POST APPOINTMENT ###
    ${resp}=                    Post Request      session                ${wfm_path_reserve_appointment}    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=    Set Variable      ${resp.status_code}
    log                         ${resp.json()}    

    ${Verify_ruletype} =          Get From Dictionary        ${resp.json()}    RULE_TYPE
    Should Be Equal As Strings    ${Verify_ruletype}         6                
    [Return]                      ${http_status_res_code}    


RESERVE APPOINTMENT TYPE RULE 7
    Create Session    session              ${wfm_host} 
    ${headers}=       Create Dictionary    x-api-key=${api-key}                   Content-Type=${Content-Type}    
    ${json_string}    Get File             BODY_RESERVE_APPOINTMENT_TYPE7.json

    ### Change body "INSTALLATION_DATE" ###
    ${json_current_time}=    evaluate                json.loads('''${json_string}''')    json
    set to dictionary    ${json_current_time["APPOINTMENT_TIME"]}      APPOINTMENT_DATE=${Crrent_time}
    ${json_string}=          evaluate                json.dumps(${json_current_time})    json

    ### POST APPOINTMENT ###
    ${resp}=                    Post Request      session                ${wfm_path_reserve_appointment}    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=    Set Variable      ${resp.status_code}
    log                         ${resp.json()}    

    ${Verify_ruletype} =          Get From Dictionary        ${resp.json()}    RULE_TYPE
    Should Be Equal As Strings    ${Verify_ruletype}         7              
    [Return]                      ${http_status_res_code}    


RESERVE APPOINTMENT TYPE RULE 8
    Create Session    session              ${wfm_host} 
    ${headers}=       Create Dictionary    x-api-key=${api-key}                   Content-Type=${Content-Type}    
    ${json_string}    Get File             BODY_RESERVE_APPOINTMENT_TYPE8.json

    ### Change body "INSTALLATION_DATE" ###
    ${json_current_time}=    evaluate                json.loads('''${json_string}''')    json
    set to dictionary    ${json_current_time["APPOINTMENT_TIME"]}      APPOINTMENT_DATE=${Crrent_time}
    ${json_string}=          evaluate                json.dumps(${json_current_time})    json

    ### POST APPOINTMENT ###
    ${resp}=                    Post Request      session                ${wfm_path_reserve_appointment}    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=    Set Variable      ${resp.status_code}
    log                         ${resp.json()}    

    ${Verify_ruletype} =          Get From Dictionary        ${resp.json()}    RULE_TYPE
    Should Be Equal As Strings    ${Verify_ruletype}         8                
    [Return]                      ${http_status_res_code}    

RESERVE APPOINTMENT TYPE RULE 9
    Create Session    session              ${wfm_host} 
    ${headers}=       Create Dictionary    x-api-key=${api-key}                   Content-Type=${Content-Type}    
    ${json_string}    Get File             BODY_RESERVE_APPOINTMENT_TYPE9.json

    ### Change body "INSTALLATION_DATE" ###
    ${json_current_time}=    evaluate                json.loads('''${json_string}''')    json
    set to dictionary    ${json_current_time["APPOINTMENT_TIME"]}      APPOINTMENT_DATE=${Crrent_time}
    ${json_string}=          evaluate                json.dumps(${json_current_time})    json

    ### POST APPOINTMENT ###
    ${resp}=                    Post Request      session                ${wfm_path_reserve_appointment}    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=    Set Variable      ${resp.status_code}
    log                         ${resp.json()}    

    ${Verify_ruletype} =          Get From Dictionary        ${resp.json()}    RULE_TYPE
    Should Be Equal As Strings    ${Verify_ruletype}         9                
    [Return]                      ${http_status_res_code}    

RESERVE APPOINTMENT TYPE RULE 10
    Create Session    session              ${wfm_host} 
    ${headers}=       Create Dictionary    x-api-key=${api-key}                   Content-Type=${Content-Type}    
    ${json_string}    Get File             BODY_RESERVE_APPOINTMENT_TYPE10.json

    ### Change body "INSTALLATION_DATE" ###
    ${json_current_time}=    evaluate                json.loads('''${json_string}''')    json
    set to dictionary    ${json_current_time["APPOINTMENT_TIME"]}      APPOINTMENT_DATE=${Crrent_time}
    ${json_string}=          evaluate                json.dumps(${json_current_time})    json

    ### POST APPOINTMENT ###
    ${resp}=                    Post Request      session                ${wfm_path_reserve_appointment}    data=${json_string}    headers=${headers} 
    ${http_status_res_code}=    Set Variable      ${resp.status_code}
    log                         ${resp.json()}    

    ${Verify_ruletype} =          Get From Dictionary        ${resp.json()}    RULE_TYPE
    Should Be Equal As Strings    ${Verify_ruletype}         10                
    [Return]                      ${http_status_res_code}    