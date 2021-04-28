*** Settings ***
Resource          ../global_resource.robot
Resource          ../global_variable.robot
Resource          ../authentication.robot
Resource          ../user_keywords.robot
Suite Teardown    Close All Browsers





*** Test Cases ***
TC_000 Connect DatabaseLibrary
    ###--- Get MongoDB Databases  ---###
    Connect To Mongodb    ${HOST_DB_TEMP}     27017                                              
    @{output}=            Get MongoDB Databases
    Log Many              @{output}
    Should Contain        ${output}                                                           4pl-fleet

   ###--- Get MongoDB Collections  ---###
    @{output}=        Get MongoDB Collections    4pl-fleet
    Log Many          @{output}
    Should Contain    ${output}                  appointments

    ###--- Find MongoDB Records by query mongo---###
    ${QueryJSON}      Set Variable                   {"metaData.ruleType" : "1", "deleted":false}
    ${output}=    Retrieve Some MongoDB Records       4pl-fleet     appointments       ${QueryJSON} 
    Log           ${output}
    

TC_001 Clear data appointments ruleType : 1
    ########  Query mongo and Update database ############
    ${QueryJSON}      Set Variable                   {"metaData.ruleType" : "1", "deleted":false}
    ${UpdateJSON}     Set Variable                   {"$set": {"deleted" : true}}
    ${allResults}=    Retrieve and Update One Mongodb Record    4pl-fleet   appointments    ${QueryJSON}    ${UpdateJSON}
    Log               ${allResults}


TC_002 Clear data appointments ruleType : 2
    ########  Query mongo and Update database ############
    ${QueryJSON}      Set Variable                   {"metaData.ruleType" : "2", "deleted":false}
    ${UpdateJSON}     Set Variable                   {"$set": {"deleted" : true}}
    ${allResults}=    Retrieve and Update One Mongodb Record    4pl-fleet   appointments    ${QueryJSON}    ${UpdateJSON}
    Log               ${allResults}

TC_003 Clear data appointments ruleType : 3
    ########  Query mongo and Update database ############
    ${QueryJSON}      Set Variable                   {"metaData.ruleType" : "3", "deleted":false}
    ${UpdateJSON}     Set Variable                   {"$set": {"deleted" : true}}
    ${allResults}=    Retrieve and Update One Mongodb Record    4pl-fleet   appointments    ${QueryJSON}    ${UpdateJSON}
    Log               ${allResults}

TC_004 Clear data appointments ruleType : 4
    ########  Query mongo and Update database ############
    ${QueryJSON}      Set Variable                   {"metaData.ruleType" : "4", "deleted":false}
    ${UpdateJSON}     Set Variable                   {"$set": {"deleted" : true}}
    ${allResults}=    Retrieve and Update One Mongodb Record    4pl-fleet   appointments    ${QueryJSON}    ${UpdateJSON}
    Log               ${allResults}

TC_006 Clear data appointments ruleType : 6
    ########  Query mongo and Update database ############
    ${QueryJSON}      Set Variable                   {"metaData.ruleType" : "6", "deleted":false}
    ${UpdateJSON}     Set Variable                   {"$set": {"deleted" : true}}
    ${allResults}=    Retrieve and Update One Mongodb Record    4pl-fleet   appointments    ${QueryJSON}    ${UpdateJSON}
    Log               ${allResults}

TC_007 Clear data appointments ruleType : 7
    ########  Query mongo and Update database ############
    ${QueryJSON}      Set Variable                   {"metaData.ruleType" : "7", "deleted":false}
    ${UpdateJSON}     Set Variable                   {"$set": {"deleted" : true}}
    ${allResults}=    Retrieve and Update One Mongodb Record    4pl-fleet   appointments    ${QueryJSON}    ${UpdateJSON}
    Log               ${allResults}

TC_008 Clear data appointments ruleType : 8
    ########  Query mongo and Update database ############
    ${QueryJSON}      Set Variable                   {"metaData.ruleType" : "8", "deleted":false}
    ${UpdateJSON}     Set Variable                   {"$set": {"deleted" : true}}
    ${allResults}=    Retrieve and Update One Mongodb Record    4pl-fleet   appointments    ${QueryJSON}    ${UpdateJSON}
    Log               ${allResults}

TC_009 Clear data appointments ruleType : 9
    ########  Query mongo and Update database ############
    ${QueryJSON}      Set Variable                   {"metaData.ruleType" : "9", "deleted":false}
    ${UpdateJSON}     Set Variable                   {"$set": {"deleted" : true}}
    ${allResults}=    Retrieve and Update One Mongodb Record    4pl-fleet   appointments    ${QueryJSON}    ${UpdateJSON}
    Log               ${allResults}

TC_0010 Clear data appointments ruleType : 10
    ########  Query mongo and Update database ############
    ${QueryJSON}      Set Variable                   {"metaData.ruleType" : "10", "deleted":false}
    ${UpdateJSON}     Set Variable                   {"$set": {"deleted" : true}}
    ${allResults}=    Retrieve and Update One Mongodb Record    4pl-fleet   appointments    ${QueryJSON}    ${UpdateJSON}
    Log               ${allResults}
