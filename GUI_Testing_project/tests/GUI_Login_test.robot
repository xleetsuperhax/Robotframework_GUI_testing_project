*** Settings ***
Documentation    Using Browser-library to perform simple GUI testing
...    on the login part of the website
Library    Browser


*** Variables ***
${CORRECT_USERNAME}    standard_user
@{CORRECT_USERNAMES}    standard_user    locked_out_user    problem_user    performance_glitch_user
...    error_user    visual_user
${CORRECT_PASSWORD}    secret_sauce
${WRONG_USERNAME}    user1
${WRONG_PASSWORD}   password
${ERROR_MESSAGE_USERNAME_REQ}    Epic sadface: Username is required
${ERROR_MESSAGE_PASSWORD_REQ}    Epic sadface: Password is required
${ERROR_MESSAGE_AUTH_ERROR}   Epic sadface: Username and password do not match any user in this service


*** Test Cases ***
Login With Valid Credentials
    [Documentation]    Logs in the service once
    New Page    https://www.saucedemo.com/
    Fill Text    id=user-name    ${CORRECT_USERNAME}
    Fill Text    id=password    ${CORRECT_PASSWORD}
    Click    id=login-button

Login With All Valid Usernames
    [Documentation]    Logs in the service with all the different 
    ...    usernames provided by the site
    FOR    ${user}    IN    @{CORRECT_USERNAMES}
        Log    ${user}
        New Page    https://www.saucedemo.com/
        Fill Text    id=user-name    ${user}
        Fill Text    id=password    ${CORRECT_PASSWORD}
        Take Screenshot
        Click    id=login-button
    END

Login With Invalid Username
    [Documentation]    Attempts to log in the service with invalid username
    New Page    https://www.saucedemo.com/
    Fill Text    id=user-name    ${WRONG_USERNAME}
    Fill Text    id=password    ${CORRECT_PASSWORD}
    Click    id=login-button
    ${error}    Get Element By Role    heading    name=${error_message_auth_error}
    Get Element States    ${error}    contains    visible

Login With Invalid Password
    [Documentation]    Attempts to log in the service with invalid password
    New Page    https://www.saucedemo.com/
    Fill Text    id=user-name   ${CORRECT_USERNAME} 
    Fill Text    id=password    ${wrong_password}
    Click    id=login-button
    ${error}    Get Element By Role    heading    name=${error_message_auth_error}
    Get Element States    ${error}    contains    visible

Login With No Credentials
    [Documentation]    Attempts to log in the service without inputs
    New Page    https://www.saucedemo.com/
    Click    id=login-button
    ${error}    Get Element By Role    heading    name=${ERROR_MESSAGE_USERNAME_REQ}
    Get Element States    ${error}    contains    visible

Login With No Username
    [Documentation]    Attempts to log in the service without username
    New Page    https://www.saucedemo.com/
    Fill Text    id=password  ${CORRECT_PASSWORD} 
    Click    id=login-button
    ${error}    Get Element By Role    heading    name=${ERROR_MESSAGE_USERNAME_REQ}
    Get Element States    ${error}    contains    visible

Login With No Password
    [Documentation]    Attempts to log in the service without password
    New Page    https://www.saucedemo.com/
    Fill Text    id=user-name   ${CORRECT_USERNAME} 
    Click    id=login-button
    ${error}    Get Element By Role    heading    name=${ERROR_MESSAGE_PASSWORD_REQ}
    Get Element States    ${error}    contains    visible
