# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library                   DataDriver                  reader_class=TestDataApi    name=remote_site_settings.csv
Resource                  ../resources/common.robot
Suite Setup               Setup Browser
Suite Teardown            End suite
Test Template             Update Remote Site Settings


*** Test Cases ***
Update Remote Site Settings with ${name} ${url}

*** Keywords ***

Update Remote Site Settings
    [Arguments]           ${name}                     ${url}                      ${environment}

    ${contains}=          Run Keyword And Return Status                           Should Contain              ${login_url}           ${environment}
    Convert To String     ${contains}
    Set Suite Variable    ${suite_environment}        ${environment}

    IF                    "${contains}"=="True"
        GoTo              ${login_url}
        ${itsthere}       isText                      Log In to Sandbox
        Runkeyword if     ${itsthere}                 Login to Sandbox
        ClickText         Setup
        ClickText         SetupOpens in a new tab     delay=1
        SwitchWindow      NEW
        TypeText          Quick Find                  Remote Site Settings        anchor=Setup Home           partial_match=false
        ClickText         Remote Site Settings        anchor=Didn't find what you're looking for?             delay=3
        ClickText         Edit                        anchor=${name}
        TypeText          Remote Site URL             ${url}
        ClickText         Cancel                      anchor=Remote Site Name
        GoTo              ${login_url}
    END
Login to sandbox
    TypeText              Username                    ${sandbox_username}
    TypeText              Password                    ${sandbox_password}
    ClickText             Log In To Sandbox