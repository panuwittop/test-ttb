*** Settings ***
Resource    ../../global_resource.robot
Resource    ../../global_variable.robot
Resource    ../../user_keywords.robot
Resource    ../../authentication.robot
Resource    user_keywords_get_user.robot


*** Test Cases ***

Setting Selenium Options
    Set Selenium Speed      5
    Set Selenium Timeout    60

TC_0001_Get_user_profile_success
 [Documentation]    To verify get user profile api will return correct data when trying to get profile of existing user
                    ${resp}=                                                                                               GET USER PROFILE SUCCESS
                    Validation response body correclty                                                                     ${resp}
                    Validation Http status code success 200 OK                                                             ${resp.status_code}

TC_0002_Get_user_profile_but_user_not_found
 [Documentation]    To verify get user profile api will return 404 not found when trying to get exist profile of not existing user
                    ${resp}=                                                                                                          GET USER PROFILE NOT FOUND
                    Validation Http status code 404 NOT FOUND                                                                         ${resp.status_code}

