*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot
Resource    ../user_keywords.robot
Resource    ../authentication.robot
Resource    user_keywords_created_order.robot


*** Test Cases ***

Setting Selenium Options
    Set Selenium Speed      5
    Set Selenium Timeout    60


TC_0001_Customer_Create_Order
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}                     Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                                TC_0001_Customer_Create_Order.json
    ${new_json_string}=                           To verify random consignment number    ${json_string}
    ${resp}=                                      Post Request                            session                               ${path}                         data=${new_json_string}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()}                          
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    To verify create order success                ${resp}
    Validation field success equal true           ${resp}
    Set Global Variable                           ${json_string}
    Set Global Variable                           ${new_json_string}                      


TC_0002_Customer_Create_Order_Duplicate consignment
    Create Session                                  session                    ${on_demand_host}
    ${headers}=                                     Create Dictionary          apiKey=${api-key}                               Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                  Get File                   TC_0002_Customer_Create_Order_Duplicate.json
    ${resp}=                                        Post Request               session                                         ${path}                         data=${json_string}        headers=${headers}    
    log                                             ${resp.json()}             
    ${http_status_res_code}=                        Set Variable               ${resp.status_code}
    Validation Http status code 400 Bad request     ${http_status_res_code}
    To verify create order Duplicate consignment    ${resp}


TC_0003_Customer_Create_Order_access token if invalid
    Create Session                                             session                    ${on_demand_host}
    ${headers}=                                                Create Dictionary          apiKey=xxxx            Content-Type=${Content-Type}    x-consumer-username=CPF
    ${resp}=                                                   Post Request               session                ${path}                         data=${json_string}        headers=${headers}
    log                                                        ${resp.json()}             
    ${http_status_res_code}=                                   Set Variable               ${resp.status_code}
    Validation Http status code 401 access token if invalid    ${http_status_res_code}    
    To verify create order access token if invalid             ${resp}

# TC_0005_Customer_Create_Order_Time out
#    Create Session                                          session                    ${on_demand_host}
#    ${headers}=                                             Create Dictionary          apiKey=${api-key}      Content-Type=${Content-Type}    x-consumer-username=CPF
#    ${resp}=                                                Post Request               session                ${path}                         data=${json_string}        headers=${headers}
#    log                                                     ${resp.json()}             
#    ${http_status_res_code}=                                Set Variable               ${resp.status_code}
#    Validation Http status code 500 the request time out    ${http_status_res_code}    

TC_0006_Customer_Create_Order_data not found
    Create Session                               session                    ${on_demand_host}
    ${headers}=                                  Create Dictionary          apiKey=${api-key}      Content-Type=${Content-Type}    x-consumer-username=CPF
    ${resp}=                                     Post Request               session                /v1/orderx/xxx                  data=${json_string}        headers=${headers}
    log                                          ${resp.json()}             
    ${http_status_res_code}=                     Set Variable               ${resp.status_code}
    Validation Http status code 404 NOT FOUND    ${http_status_res_code}


TC_0007_Customer_required field consignment
    Create Session                                 session                    ${on_demand_host}
    ${headers}=                                    Create Dictionary          apiKey=${api-key}                                   Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                 Get File                   TC_0007_Customer_required field consignment.json
    ${resp}=                                       Post Request               session                                             ${path}                         data=${json_string}        headers=${headers}
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}
    log                                            ${resp.json()} 
    Validation Http status code 400 Bad request    ${http_status_res_code}    
    Validation field success equal false           ${resp}
    To verify create order required field          ${resp}


TC_0008_Customer_required 2 field consignment
    Create Session                                 session                    ${on_demand_host}
    ${headers}=                                    Create Dictionary          apiKey=${api-key}                                     Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                 Get File                   TC_0008_Customer_required 2 field consignment.json
    ${resp}=                                       Post Request               session                                               ${path}                         data=${json_string}        headers=${headers}
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}
    log                                            ${resp.json()} 
    Validation Http status code 400 Bad request    ${http_status_res_code}    
    Validation field success equal false           ${resp}
    To verify create order required 2 field        ${resp}

TC_0009_ Customer_Add note sender and recipient
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}      Content-Type=${Content-Type}    x-consumer-username=CPF
    ${new_json_string}=                           To verify random consignment number    ${json_string}
    ${resp}=                                      Post Request                            session                ${path}                         data=${new_json_string}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    Validation field success equal true           ${resp}                                 
    # To verify note sender and recipients             ${resp}


TC_0010_ Customer_Chcek lat and lng sender and recipient
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}      Content-Type=${Content-Type}    x-consumer-username=CPF
    To verify random consignment number          ${json_string}
    ${new_json_string}=                           To verify random consignment number    ${json_string}
    ${resp}=                                      Post Request                            session                ${path}                         data=${new_json_string}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    Validation field success equal true           ${resp}                                 
    # To verify note lat/lng sender and recipients       ${resp}

TC_0012_ Customer_Chcek Check Time zone
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}      Content-Type=${Content-Type}    x-consumer-username=CPF
    ${new_json_string}=                           To verify random consignment number    ${json_string}
    ${resp}=                                      Post Request                            session                ${path}                         data=${new_json_string}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    Validation field success equal true           ${resp}                                 
    # To verify time zone pick up at       ${resp}

TC_0013_Check field consignment if user fill-in data with string
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}      Content-Type=${Content-Type}    x-consumer-username=CPF
    ${new_json_string}=                           To verify random consignment number    ${new_json_string}
    ${resp}=                                      Post Request                            session                ${path}                         data=${new_json_string}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    Validation field success equal true           ${resp} 
    # To verify time zone pick up at       ${resp}


TC_0014_Validation order type number equal -1
    Create Session                                 session                    ${on_demand_host}
    ${headers}=                                    Create Dictionary          apiKey=${api-key}                                     Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                 Get File                   TC_0014_Validation order type number equal -1.json
    ${resp}=                                       Post Request               session                                               ${path}                         data=${json_string}        headers=${headers}
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}
    log                                            ${resp.json()} 
    Validation Http status code 400 Bad request    ${http_status_res_code}
    To verify create order order type incorrect    ${resp}

TC_0015_Validation orderType correct
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}      Content-Type=${Content-Type}    x-consumer-username=CPF
    ${new_json_string}=                           To verify random consignment number    ${new_json_string}
    ${resp}=                                      Post Request                            session                ${path}                         data=${new_json_string}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}
    Validation field success equal true           ${resp} 
    # To verify create order type       ${resp}


TC_0016_Validation field vehicle type number incorrect
    Create Session                                          session                    ${on_demand_host}
    ${headers}=                                             Create Dictionary          apiKey=${api-key}                                              Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                          Get File                   TC_0016_Validation filed vehicle type number incorrect.json
    ${resp}=                                                Post Request               session                                                        ${path}                         data=${json_string}        headers=${headers}
    ${http_status_res_code}=                                Set Variable               ${resp.status_code}
    log                                                     ${resp.json()} 
    Validation Http status code 400 Bad request             ${http_status_res_code}
    To verify create order vehicle type number incorrect    ${resp}

TC_0017_Validation consignment must be a string
    Create Session                                 session                    ${on_demand_host}
    ${headers}=                                    Create Dictionary          apiKey=${api-key}                                       Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                 Get File                   TC_0017_Validation consignment must be a string.json
    ${resp}=                                       Post Request               session                                                 ${path}                         data=${json_string}        headers=${headers}
    ${http_status_res_code}=                       Set Variable               ${resp.status_code}
    log                                            ${resp.json()} 
    Validation Http status code 400 Bad request    ${http_status_res_code}
    Validation field success equal false           ${resp}
    To verify consignment must be a string         ${resp}