*** Settings ***
Library           AppiumLibrary
Resource          ../global_resource.robot
Resource          ../global_variable.robot
Resource          ../user_keywords.robot
Resource          ../authentication.robot
Resource          user_keywords_ui.robot
Suite Teardown    Close All Applications

*** Test Cases ***
Open Test Application Minimal
    [Documentation]               Setting application minimal
    SETTING DEVICE APPLICATION

TC0001:Add todos list and verify title
    [Documentation]                                     To verify that the user add todos list and verify notes success
    ADD ANY TODOS LIST SUCCESS
    VERIFY THAT ADD ANY TODOS LIST COMPUTERS SUCCESS

TC0002:Update todos list and verify new title
    [Documentation]                               To verify that the user update todos list and verify new title success
    UPDATE TODOS LIST SUCCESS
    VERIFY THAT UPDATE TODOS LIST PHONE SUCCESS


TC0003: Remind me todos list and seting schedule
    [Documentation]                                  To verify that the user click remind me todos list and seting schedule
    REMIND ME TODOS LIST AND SET SCHEDULE SUCCESS


TC0004: To verify the user change to nigth mode success
    [Documentation]               To verify the user change to nigth mode success
    CHENGE NINGTH MODE SUCCESS