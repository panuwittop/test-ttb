# ondemand-robot-automation-test
should be connect VPN : tel-sg

# Install python 3.7.2
 - URL : https://www.python.org/downloads/release/python-372/
 - python --version


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
 - ${url}        https://api.staging.true-e-logistics.com
 - ${path}       ondemand-gateway/v1/order

*** Keywords ***
 - Validation Http status code success 200 OK
 -  [Arguments]                   ${http_status_res_code}
 -  Should Be Equal As Strings    ${http_status_res_code}    200

*** Test Cases ***
 - TC_0001_Login to success
  