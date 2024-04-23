*** Settings ***
Resource          ../../global_resource.robot
Resource          ../../global_variable.robot
Resource          ../../authentication.robot
Resource          user_keywords_ui.robot
Suite Teardown    Close All Browsers



*** Test Cases ***
Login success
    Open Browser URL : Herokuapp
    Login to herokuapp successfully
    Logout to herokuapp successfully

Login failed - Password incorrect
    Login to herokuapp failed

Login failed - Username not found
    Login to herokuapp username not found

