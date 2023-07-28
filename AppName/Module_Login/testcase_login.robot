*** Settings ***
Resource     ../../Common/testcase_resource.robot
Suite Setup     Open the Browser
Suite Teardown      Close the Browser
# Author: khushi.shah

*** Test Cases ***
Verify The User Is Logged In Or Not And Launch Of Profile Page
    Set Selenium Speed    1 Seconds
    Click on Basic actions_login
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Sleep    2 Seconds
    Click Element    xpath:${LoginButton}
    Sleep    2 Seconds
    Go To    ${BookStoreUrl}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Click on Basic actions_login
    Scroll Element Into View    xpath:${LoginSideBar}
    Sleep    2 Seconds
    Page Should Contain Element    xpath:${LoggedInMessage}
    Log To Console      Verification of user is logged in or not is done
    Click Element    xpath:${ProfileLink}
    Sleep    2 Seconds
    ${ProfileUrl}=      Get Location
    Should Be True    '${ProfileUrl}' == '${Purl}'
    Log To Console    Verification of Launching Profile page is successful


Verify Unsuccessful Login With Empty Credentials
    Set Selenium Speed    1 Seconds
    Go To    ${BookStoreUrl}
    Click Element    xpath:${LogoutButton}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Click Element    xpath:${LoginButton}
    Sleep    2 Seconds
    ${Count}=     Get Element Count    xpath:${ErrorIcon}
    Should Be True    ${Count} == 2
    Log To Console    Verification of empty credential is successful.

Verify Unsuccessful Login With Invalid Username And Valid Password
    Set Selenium Speed    1 Seconds
    Input Text    Id:${Username}    kh2
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${LoginButton}
    Sleep    2 Seconds
    ${Emessage}=    Get Text    xpath:${ErrorMessage}
    Should Be True    '${Emessage}'=='${InvalidError}'
    Log To Console    Verification of invalid username and valid password is successful

Verify Unsuccessful Login With Valid Username And Invalid Password.
    Set Selenium Speed    1 Seconds
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@!
    Click Element    xpath:${LoginButton}
    Sleep    2 Seconds
    ${Emessage}=    Get Text    xpath:${ErrorMessage}
    Should Be True    '${Emessage}'=='${InvalidError}'
    Log To Console    Verification of invalid username and valid password is successful

Verify Successful Login
    Set Selenium Speed    1 Seconds
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${LoginButton}
    Sleep    2 Seconds
    ${ProfileUrl}=      Get Location
    Should Be True    '${ProfileUrl}' == '${Purl}'
    Log To Console    Verification of successful login is done

Verify New User Button
    Set Selenium Speed    1 Seconds
    Go To    ${LoginURL}
    Click Element    xpath:${LogoutButton}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Click Element    xpath:${NewUserbutton}
    Sleep    1 Seconds
    ${SignUpPage}=      Get Location
    Should Be True    '${SignUpPage}'=='${SignupUrl}'
    Log To Console    Verification of redirect to register page using new user button is successful

