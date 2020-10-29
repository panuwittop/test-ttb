*** Settings ***
Resource    ../global_resource.robot
Resource    ../global_variable.robot
Resource    ../user_keywords.robot
Resource    ../authentication.robot
Resource    user_keywords_change_created_order.robot


*** Test Cases ***

Setting Selenium Options
    Set Selenium Speed      5
    Set Selenium Timeout    60


TC_0001_Customer_Create_Order_1
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}                     Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                                TC_0001_Customer_Create_Order.json
    ${new_json_string}=                           Validation random consignment number    ${json_string}
    ${new_json_string_1}=                         Validation pickup time                  ${new_json_string}
    ${resp}=                                      Post Request                            session                               ${path}                         data=${new_json_string_1}    headers=${headers} 
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()}                          
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    To verify create order success                ${resp}
    Validation field success equal true           ${resp}
    # Set Global Variable                           ${json_string}
    Set Global Variable                           ${new_json_string}                      

TC_0002_Customer_Create_Order_2
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}                     Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                                TC_0002_Customer_Create_Order.json
    ${new_json_string}=                           Validation random consignment number    ${json_string}
    ${new_json_string_1}=                         Validation pickup time                  ${new_json_string}
    ${resp}=                                      Post Request                            session                               ${path}                         data=${new_json_string_1}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    Validation field success equal true           ${resp}                                 


TC_0003_Customer_Create_Order_3
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}                     Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                                TC_0003_Customer_Create_Order.json
    ${new_json_string}=                           Validation random consignment number    ${json_string}
    ${new_json_string_1}=                         Validation pickup time                  ${new_json_string}
    ${resp}=                                      Post Request                            session                               ${path}                         data=${new_json_string_1}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    Validation field success equal true           ${resp}                                 

TC_0004_Customer_Create_Order_4
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}                     Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                                TC_0004_Customer_Create_Order.json
    ${new_json_string}=                           Validation random consignment number    ${json_string}
    ${new_json_string_1}=                         Validation pickup time                  ${new_json_string}
    ${resp}=                                      Post Request                            session                               ${path}                         data=${new_json_string_1}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    Validation field success equal true           ${resp}                                 


TC_0005_Customer_Create_Order_5
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}                     Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                                TC_0005_Customer_Create_Order.json
    ${new_json_string}=                           Validation random consignment number    ${json_string}
    ${new_json_string_1}=                         Validation pickup time                  ${new_json_string}
    ${resp}=                                      Post Request                            session                               ${path}                         data=${new_json_string_1}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    Validation field success equal true           ${resp}                                 

TC_0006_Customer_Create_Order_6
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}                     Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                                TC_0006_Customer_Create_Order.json
    ${new_json_string}=                           Validation random consignment number    ${json_string}
    ${new_json_string_1}=                         Validation pickup time                  ${new_json_string}
    ${resp}=                                      Post Request                            session                               ${path}                         data=${new_json_string_1}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    Validation field success equal true           ${resp}                                 


TC_0007_Customer_Create_Order_7
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}                     Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                                TC_0007_Customer_Create_Order.json
    ${new_json_string}=                           Validation random consignment number    ${json_string}
    ${new_json_string_1}=                         Validation pickup time                  ${new_json_string}
    ${resp}=                                      Post Request                            session                               ${path}                         data=${new_json_string_1}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    Validation field success equal true           ${resp}                                 

TC_0008_Customer_Create_Order_8
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}                     Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                                TC_0008_Customer_Create_Order.json
    ${new_json_string}=                           Validation random consignment number    ${json_string}
    ${new_json_string_1}=                         Validation pickup time                  ${new_json_string}
    ${resp}=                                      Post Request                            session                               ${path}                         data=${new_json_string_1}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    Validation field success equal true           ${resp}                                 

TC_0009_Customer_Create_Order_9
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}                     Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                                TC_0009_Customer_Create_Order.json
    ${new_json_string}=                           Validation random consignment number    ${json_string}
    ${new_json_string_1}=                         Validation pickup time                  ${new_json_string}
    ${resp}=                                      Post Request                            session                               ${path}                         data=${new_json_string_1}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    Validation field success equal true           ${resp}                                 


TC_00010_Customer_Create_Order_10
    Create Session                                session                                 ${on_demand_host}
    ${headers}=                                   Create Dictionary                       apiKey=${api-key}                     Content-Type=${Content-Type}    x-consumer-username=CPF
    ${json_string}                                Get File                                TC_0009_Customer_Create_Order.json
    ${new_json_string}=                           Validation random consignment number    ${json_string}
    ${new_json_string_1}=                         Validation pickup time                  ${new_json_string}
    ${resp}=                                      Post Request                            session                               ${path}                         data=${new_json_string_1}    headers=${headers}
    ${http_status_res_code}=                      Set Variable                            ${resp.status_code}
    log                                           ${resp.json()} 
    Validation Http status code success 200 OK    ${http_status_res_code}                 
    Validation field success equal true           ${resp}                                 