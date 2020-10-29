*** Variables ***
##### Endpoint ####
${on_demand_host}         https://api.staging.true-e-logistics.com/ondemand-gateway
${on_demand_host_staing}  http://10.150.0.67:8080
${path}                   /v1/order
${headers}                Create Dictionary                                           
${Content-Type}           application/json


##### Order Detail ####
${consignment}      TOPTEST022620200001
${orderType}                2
${vehicle_type}             1
${vehicle_amount}           1
${extensionFlow}            ONDEMAND

##### Pickup Address ####
${sender_name}              Panuwit Supageeratirod
${sender_phone}             0873842085
${sender_address}           True Digital park 101   Sukhumvit Bangchak Bangkok 10120
${sender_postcode}          10120   
${sender_lat}               13.6851249
${sender_long}              100.6088319
${pickup_start}             2020-02-04T07:00:00.000Z
${pickup_end}               2020-02-04T10:00:00.000Z
${note_sender}              Test Automation Robot


###########  Delivery Address  ##########
${recipient_name}              Pattareya Putaworakun
${recipient_phone}             0805192296
${recipient_address}           Asoke tower
${recipient_postcode}          10120   
${recipient_lat}               13.7456081
${recipient_ong}               100.5619628

###########  parcels #############
${parcels_productId_1}       34001 
${parcels_sku_1}             000000000051050233
${parcels_name_1}            pockie
${parcels_descriptions_1}    pockie
${parcels_price_1}           60
${parcels_weight_1}          1000

${parcels_productId_2}       34045
${parcels_sku_2}             000000000051050534
${parcels_name_2}            chicken fried
${parcels_descriptions_2}    cpfreshmart
${parcels_price_2}           29
${parcels_weight_2}          100

###########  dimension  ###########
${dimension_width_1}           50
${dimension_height_1}          23.22
${dimension_depth_1}           77.78

${dimension_width_2}           20
${dimension_height_2}          40.21
${dimension_depth_2}           5


######### payment  ############
${payment_method}             CASH
${payment_amount}             89
${note_recipient}             Test Automation Robot



${project-id}                   5ec78aecf3a41244b9031586
${company-id}                   5ea93cda890a1f52c86637e3
${language_th}                  th 
${language_en}                  en