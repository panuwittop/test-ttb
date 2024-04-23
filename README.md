# Install python 3.7.2
 - URL : https://www.python.org/downloads/release/python-372/
 - python --version

#Install Appium
https://github.com/appium/appium-desktop/releases/tag/1.8.0

#Install Android studio
https://developer.android.com/studio/

CMD : pip install robotframework-appiumlibrary
pip install Appium-Python-Client

adb devices  > device Name เช่น 42004677e08c4503 
adb shell  > dumpsys window windows | grep -E 'mCurrentFocus'
"appPackage": "com.facebook.katana"
"appActivity": "com.facebook.katana.dbl.activity.FacebookLoginActivity"


# Install robotframework
 - pip install robotframework
 - robot --version
 - pip install robotframework-selenium2library
 - pip install robotframework-requests

| Resource files | Description |
| ------ | ------ |
| global_resource.robot | List of imported Robotframework library for example HTTP Request, Selenuim Library |
| ${page}.robot | List of page elements or api related elements |
| authentication.robot | List of username, password and API keys |
| ${page}_user_keywords.robot | List of user keyword |
| global_variable.robot | List of global variable |
| custom_keyword.robot | List of custom keyword ( custom library) |

# Example Robotframework

Settings Library

*** Settings ***
 - Library    Selenium2Library

*** Variables ***
 - ${browser}    chrome
 - ${url}        https://${host}
 - ${path}       /${path}

*** Keywords ***
 - Validation Http status code success 200 OK
 -  [Arguments]                   ${http_status_res_code}
 -  Should Be Equal As Strings    ${http_status_res_code}    200

*** Test Cases ***
 - TC_0001_Login to success
  