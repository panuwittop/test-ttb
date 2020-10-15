*** Variables ***
##### Endpoint ####
${on_demand_host}         http://app-4pl-authentication.drivs.staging.tel.internal
${on_demand_host_staing}  http://10.150.0.67:8080
${path}                   /v1/auth/login-citizen-id
${headers}                Create Dictionary                                           
${Content-Type}           application/json

