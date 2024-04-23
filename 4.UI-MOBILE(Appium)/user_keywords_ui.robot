*** Settings ***
Resource    ../global_variable.robot


*** Keywords ***
SETTING DEVICE APPLICATION
    Open Application    ${REMOTE_URL}    platformName=${platformName}    platformVersion=${platformVersion}    deviceName=${deviceName}    appPackage=${appPackage}    appActivity=${appActivity}

ADD ANY TODOS LIST SUCCESS
    Wait Until Element Is Visible    ${icon_addnode}       15s
    Click Element                    id=${icon_addnode}
    Wait Until Element Is Visible    ${edit_note}          15s
    Click Element                    id=${edit_note} 
    Input Text                       id=${edit_note}       BUY COMPUTERS
    Wait Until Element Is Visible    ${buttonsave}         15s
    Click Element                    id=${buttonsave}


VERIFY THAT ADD ANY TODOS LIST COMPUTERS SUCCESS
    Wait Until Element Is Visible    ${view_title}    15s
    Element Text Should Be           ${view_title}    BUY COMPUTERS

UPDATE TODOS LIST SUCCESS
    Wait Until Element Is Visible    ${view_title}       15s
    Click Element                    ${view_title}       
    Wait Until Element Is Visible    ${edit_note}        15s
    Click Element                    id=${edit_note} 
    Clear Text                       id=${edit_note} 
    Input Text                       id=${edit_note}     UPDATE BUY PHONE
    Wait Until Element Is Visible    ${buttonsave}       15s
    Click Element                    id=${buttonsave}

VERIFY THAT UPDATE TODOS LIST PHONE SUCCESS
    Wait Until Element Is Visible    ${view_title}    15s
    Element Text Should Be           ${view_title}    UPDATE BUY PHONE


REMIND ME TODOS LIST AND SET SCHEDULE SUCCESS
    Wait Until Element Is Visible    ${view_title}       15s
    Click Element                    ${view_title}       
    Wait Until Element Is Visible    ${remind_me}        15s
    Click Element                    ${remind_me}        
    Wait Until Element Is Visible    ${seting_date}      15s
    Click Element                    ${seting_date}      
    Wait Until Element Is Visible    ${select_date}      15s
    Click Element                    ${select_date}      
    Wait Until Element Is Visible    ${confirm_date}     15s
    Click Element                    ${confirm_date}     
    Wait Until Element Is Visible    ${buttonsave}       15s
    Click Element                    id=${buttonsave}

CHENGE NINGTH MODE SUCCESS
    Wait Until Element Is Visible    ${menu}                   15s
    Click Element                    ${menu}                   
    Wait Until Element Is Visible    ${menu_seting}            15s
    Click Element                    ${menu_seting}            
    Wait Until Element Is Visible    ${checbox_ningth_mode}    15s
    Click Element                    ${checbox_ningth_mode}    
    Wait Until Element Is Visible    ${back_button}            15s
    Click Element                    ${back_button}            


