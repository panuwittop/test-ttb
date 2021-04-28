*** Variables ***
##### Endpoint ####
${wfm_host}    https://api.staging.true-e-logistics.com
${wfm_path}    /wfm-api/v2/installation/query-appointments    
${wfm_path_reserve_appointment}               /wfm-api/v2/installation/reserve-appointments
${Content-Type}    application/json

${HOST_DB_TEMP}         mongodb+srv://teladmin:teladmin@test-newprod-drivs-gene.enlew.mongodb.net/?authSource=admin
${HOST_DB_EKS}     mongodb://teladmin:teladmin@mongo.datastore.staging.tel.internal

