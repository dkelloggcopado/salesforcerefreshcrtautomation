# NOTE: readme.txt contains important information you need to take into account
# before running this suite.
*** Settings ***
Library                   DataDriver                  reader_class=TestDataApi    name=named_credentials.csv
Resource                  ../resources/common.robot
Suite Setup               Setup Browser
Suite Teardown            End suite
Test Template             Update Named Credentials

*** Test Cases ***
Update Named Credentials with ${named_credential} ${named_credential_url}


*** Keywords ***
Update Named Credentials
    [Arguments]           ${named_credential}         ${named_credential_url}     ${environment}
    [Documentation]       Update named credentials from csv file

    ${contains}=          Run Keyword And Return Status                           Should Contain              ${login_url}      ${environment}
    Convert To String     ${contains}
    Set Suite Variable    ${suite_environment}        ${environment}
    
    IF                    "${contains}"=="True"
        GoTo              ${login_url}
        ${itsthere}       isText                      Log In to Sandbox
        Runkeyword if     ${itsthere}                 Login to Sandbox
        ClickText         Setup
        ClickText         SetupOpens in a new tab     delay=1
        SwitchWindow      NEW
        TypeText          Quick Find                  Named Credentials           anchor=Object Manager
        ClickText         Named Credentials           anchor=Didn't Find what you're looking for?             delay=5
        ClickText         ${named_credential}         delay=3
        ClickText         Edit                        anchor=delete
        TypeText          URL                         ${named_credential_url}
        ClickText         Cancel                      anchor=Save
    END
Login to sandbox
    TypeText              Username                    ${sandbox_username}
    TypeText              Password                    ${sandbox_password}
    ClickText             Log In To Sandbox