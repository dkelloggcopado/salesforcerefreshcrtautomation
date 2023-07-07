# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library                   DataDriver                  reader_class=TestDataApi    name=custom_metadata.csv
Resource                  ../resources/common.robot
Suite Setup               Setup Browser
Suite Teardown            End suite
Test Template             Update Custom Metadata


*** Test Cases ***
Update Custom Metadata with ${custom_metadata_name} ${custom_metadata_value}


*** Keywords ***
Update Custom Metadata
    [Arguments]           ${custom_metadata_name}     ${custom_metadata_value}    ${environment}


    ${contains}=          Run Keyword And Return Status                           Should Contain              ${login_url}      ${environment}
    Convert To String     ${contains}
    Set Suite Variable    ${suite_environment}        ${environment}

    IF                    "${contains}"=="True"
        GoTo              ${login_url}
        ${itsthere}       isText                      Log In to Sandbox
        Runkeyword if     ${itsthere}                 Login to Sandbox
        ClickText         Setup                       delay=2
        ClickText         SetupOpens in a new tab     delay=1
        SwitchWindow      NEW
        TypeText          Quick Find                  Custom Metadata
        ClickText         Custom Metadata Types       partial_match=false
        ClickText         Manage Records              anchor=Copado Setting
        ClickText         Big Metadata                partial_match=false
        ClickText         Edit
        ClickCheckbox     Enabled                     on
        ClickText         Cancel
        GoTo              ${login_url}
    END
Login to sandbox
    TypeText              Username                    ${sandbox_username}.${suite_environment}
    LogScreenshot
    TypeText              Password                    ${sandbox_password}
    LogScreenshot
    ClickText             Log In To Sandbox