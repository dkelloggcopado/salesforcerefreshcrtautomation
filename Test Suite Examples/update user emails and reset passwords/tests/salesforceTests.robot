# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library              QWeb
Library              DataDriver                  reader_class=TestDataApi    name=Refresh_Steps_-_Sheet1.csv
Resource             ../resources/common.robot
Suite Setup          Setup Browser
Suite Teardown       End suite
Test Template        Reset Email and Generate Password

*** Test Cases ***
Reset Email and Generate Password with ${password_name} ${password_email}

*** Keywords ***
Reset Email and Generate Password
    [Arguments]      ${password_name}            ${password_email}

    #Loop Below steps for each

    ${itsthere}      isText                      Log In to Sandbox
    Runkeyword if    ${itsthere}                 Login to Sandbox
    GoTo             ${login_url}
    ClickText        Setup
    ClickText        SetupOpens in a new tab     delay=1
    SwitchWindow     NEW
    TypeText         Search Setup                ${password_name}            delay=2
    ClickText        User                        anchor=${password_name}     delay=5
    VerifyText       Sharing                     timeout=45
    ClickText        Edit
    VerifyText       First Name                  anchor=User Edit
    TypeText         Email                       ${password_email}           anchor=Alias
    ClickCheckbox    Generate new password and notify user immediately       on
    ClickText        Cancel                      delay=3
Login to sandbox
    GoTo             ${sandbox_url}
    TypeText         Username                    ${sandbox_username}
    TypeText         Password                    ${sandbox_password}
    ClickText        Log In To Sandbox
