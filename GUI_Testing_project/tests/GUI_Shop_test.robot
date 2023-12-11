*** Settings ***
Documentation    Using Browser-library to perform simple GUI testing
...    on the shop part of the website
Library    Browser


*** Variables ***
${CORRECT_USERNAME}    standard_user
${CORRECT_PASSWORD}    secret_sauce
${FIRST_NAME}    John
${LAST_NAME}    Johnson
${POSTAL_CODE}    11234
@{ALL_PRODUCTS}    sauce-labs-onesie    sauce-labs-bike-light    sauce-labs-bolt-t-shirt
...    test.allthethings()-t-shirt-(red)    sauce-labs-backpack    sauce-labs-fleece-jacket

${ERROR_MESSAGE_FIRSTNAME_REQ}    Error: First Name is required
${ERROR_MESSAGE_LASTNAME_REQ}   Error: Last Name is required
${ERROR_MESSAGE_POSTALCODE_REQ}    Error: Postal Code is required


*** Test Cases ***
Order Single Item
    [Documentation]    Go through the whole order process with one item
    Login To Service
    Click    id=add-to-cart-sauce-labs-backpack
    Proceed To Checkout
    Enter Information
    Validate Order Information
    Return To Store And Logout

Order All Items
    [Documentation]    Go through the whole order process with one of each item
    Login To Service
    FOR    ${element}    IN    @{ALL_PRODUCTS}
        Log    ${element}
        Click    id=add-to-cart-${element}
    END
    Proceed To Checkout
    Enter Information
    Validate Order Information
    Return To Store And Logout

Validate Information With Normal Inputs
    [Documentation]    Navigate through the enter-infromation screen with normal inputs
    Login To Service
    Click    id=add-to-cart-sauce-labs-backpack
    Proceed To Checkout
    Fill Text    id=first-name   ${FIRST_NAME}
    Fill Text    id=last-name   ${LAST_NAME} 
    Fill Text    id=postal-code  ${POSTAL_CODE}
    Click    id=continue

Validate Information Without Inputs
    [Documentation]    Navigate through the enter-information screen without any inputs
    Login To Service
    Click    id=add-to-cart-sauce-labs-backpack
    Proceed To Checkout
    Click    id=continue
    ${error}    Get Element By Role    heading    name=${ERROR_MESSAGE_FIRSTNAME_REQ}
    Get Element States    ${error}    contains    visible

Validate Information Without First Name
    [Documentation]    Navigate through the enter-information screen without first name input
    Login To Service
    Click    id=add-to-cart-sauce-labs-backpack
    Proceed To Checkout
    Fill Text    id=last-name   ${LAST_NAME} 
    Fill Text    id=postal-code  ${POSTAL_CODE}
    Click    id=continue
    ${error}    Get Element By Role    heading    name=${ERROR_MESSAGE_FIRSTNAME_REQ}
    Get Element States    ${error}    contains    visible

Validate Information Without Last Name
    [Documentation]    Navigate through the enter-information screen without last name input
    Login To Service
    Click    id=add-to-cart-sauce-labs-backpack
    Proceed To Checkout
    Fill Text    id=first-name   ${FIRST_NAME} 
    Fill Text    id=postal-code  ${POSTAL_CODE}
    Click    id=continue
    ${error}    Get Element By Role    heading    name=${error_message_lastname_req}
    Get Element States    ${error}    contains    visible

Validate Information Without Postal Code
    [Documentation]    Navigate through the enter-information screen without postal code input
    Login To Service
    Click    id=add-to-cart-sauce-labs-backpack
    Proceed To Checkout
    Fill Text    id=first-name   ${FIRST_NAME} 
    Fill Text    id=last-name  ${LAST_NAME}
    Click    id=continue
    ${error}    Get Element By Role    heading    name=${error_message_postalcode_req}
    Get Element States    ${error}    contains    visible


*** Keywords ***
Login To Service
    [Documentation]    Login to the service normally to gain access to the store
    New Page    https://www.saucedemo.com/
    Fill Text    id=user-name    ${CORRECT_USERNAME}
    Fill Text    id=password    ${CORRECT_PASSWORD}
    Click    id=login-button

Enter Information
    [Documentation]    Enter data to the fields as intended
    Fill Text    id=first-name   ${FIRST_NAME}
    Fill Text    id=last-name   ${LAST_NAME} 
    Fill Text    id=postal-code  ${POSTAL_CODE}
    Click    id=continue

Validate Order Information    
    [Documentation]    Make sure that all the necessary parts of the order are visible 
    Get Element    text=Payment Information
    Get Element    text=Shipping Information
    Get Element    text=Price Total
    Get Element    css=.summary_total_label

Proceed To Checkout
    [Documentation]    Proceed to the checkout process once products have been added to the cart
    Click    css=.shopping_cart_link
    Click    id=checkout

Return To Store And Logout
    [Documentation]    Return to main store page and logout of the service
    Click    id=finish
    Click    id=back-to-products
    Click    id=react-burger-menu-btn
    Click    id=logout_sidebar_link
