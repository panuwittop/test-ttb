*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot
Resource    ../user_keywords.robot
Resource    ../authentication.robot
Resource    user_keywords_forgot_password.robot


*** Test Cases ***

Setting Selenium Options
    Set Selenium Speed      5
    Set Selenium Timeout    60


TC_0001_Reset_password_success
                   
