*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot
Resource    ../user_keywords.robot
Resource    ../authentication.robot
Resource    user_keywords_get_appointment.robot


*** Test Cases ***

Setting Selenium Options
    Set Selenium Speed      5
    Set Selenium Timeout    60

TC_0001_GET_APPOINTMENT_CAPABILITIES : TYPE RULE 1
    GET CURRENT TIME
    ${http_status_res_code}=  GET APPOINTMENT TYPE RULE 1    
    Validation Http status code success 200 OK    ${http_status_res_code}

# TC_0002_GET_APPOINTMENT_CAPABILITIES : TYPE RULE 2
#     GET CURRENT TIME
#     ${http_status_res_code}=  GET APPOINTMENT TYPE RULE 2    
#     Validation Http status code success 200 OK    ${http_status_res_code}

# TC_0003_GET_APPOINTMENT_CAPABILITIES : TYPE RULE 3
#     GET CURRENT TIME
#     ${http_status_res_code}=  GET APPOINTMENT TYPE RULE 3    
#     Validation Http status code success 200 OK    ${http_status_res_code}

# TC_0004_GET_APPOINTMENT_CAPABILITIES : TYPE RULE 4
#     GET CURRENT TIME
#     ${http_status_res_code}=  GET APPOINTMENT TYPE RULE 4  
#     Validation Http status code success 200 OK    ${http_status_res_code}

# TC_0007_GET_APPOINTMENT_CAPABILITIES : TYPE RULE 7
#     GET CURRENT TIME
#     ${http_status_res_code}=  GET APPOINTMENT TYPE RULE 7  
#     Validation Http status code success 200 OK    ${http_status_res_code}

# TC_0008_GET_APPOINTMENT_CAPABILITIES : TYPE RULE 8
#     GET CURRENT TIME
#     ${http_status_res_code}=  GET APPOINTMENT TYPE RULE 8  
#     Validation Http status code success 200 OK    ${http_status_res_code}

# TC_0009_GET_APPOINTMENT_CAPABILITIES : TYPE RULE 9
#     GET CURRENT TIME
#     ${http_status_res_code}=  GET APPOINTMENT TYPE RULE 9  
#     Validation Http status code success 200 OK    ${http_status_res_code}

# TC_00010_GET_APPOINTMENT_CAPABILITIES : TYPE RULE 10
#     GET CURRENT TIME
#     ${http_status_res_code}=  GET APPOINTMENT TYPE RULE 10  
#     Validation Http status code success 200 OK    ${http_status_res_code}