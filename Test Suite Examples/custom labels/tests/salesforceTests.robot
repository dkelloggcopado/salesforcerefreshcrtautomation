# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library                   DataDriver                  reader_class=TestDataApi    name=custom_labels.csv
Resource                  ../resources/common.robot
Suite Setup               Setup Browser
Suite Teardown            End suite
Test Template             Update Custom Labels
Library                   String


*** Test Cases ***
Update Custom Labels with ${custom_label} ${custom_label_value} ${environment}


*** Keywords ***
Update Custom Labels
    [Arguments]           ${custom_label}             ${custom_label_value}       ${environment}

    ${contains}=          Run Keyword And Return Status                           Should Contain            ${login_url}      ${environment}
    Convert To String     ${contains}
    Set Suite Variable    ${suite_environment}        ${environment}

    IF                    "${contains}"=="True"
        GoTo              ${login_url}
        ${itsthere}       isText                      Log In to Sandbox
        Runkeyword if     ${itsthere}                 Login to Sandbox
        ClickText         Setup
        ClickText         SetupOpens in a new tab     delay=1
        SwitchWindow      NEW
        TypeText          Quick Find                  Custom Labels               anchor=Home               delay=4
        ClickText         Custom Labels               anchor=Didn't find what you're looking for?           delay=2
        ClickText         ${custom_label}             anchor=Del                  partial_match=false
        ClickText         Edit                        anchor=Delete
        TypeText          Value                       ${custom_label_value}
        ClickText         Cancel                      anchor=Save & New
        GoTo              ${login_url}
    END

Login to sandbox
    TypeText              Username                    ${sandbox_username}.${suite_environment}
    LogScreenshot
    TypeText              Password                    ${sandbox_password}
    LogScreenshot
    ClickText             Log In To Sandbox