*** Settings ***
Resource    ../../global_resource.robot
Resource    ../../global_variable.robot


*** Keywords ***
Open Browser URL : Herokuapp
    Open Browser               ${URL}       Chrome
    Set Selenium Speed         1 seconds
    Maximize Browser Window


Login to herokuapp successfully
    Input Text                ${input_username}    ${username}
    Input Text                ${input_password}    ${password}
    Click Element             ${btn_login}
    Element Should Contain    ${message_logged}    You logged into a secure area!

Logout to herokuapp successfully
    Click Element             ${btn_logout}
    Element Should Contain    ${message_logged}    You logged out of the secure area!

Login to herokuapp failed
    Input Text                   ${input_username}          ${username_invalid}
    Input Text                   ${input_password}          ${password_invalid}
    Click Element                ${btn_login}
    Element Should Be Visible    ${message_logged_error}    Your username is invalid!

Login to herokuapp username not found
    Input Text                   ${input_username}          ${username_not_found}
    Input Text                   ${input_password}          ${password_not_found}
    Click Element                ${btn_login}
    Element Should Be Visible    ${message_logged_error}    Your username is invalid!





