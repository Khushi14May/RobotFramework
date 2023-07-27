*** Settings ***
Resource     ../../Common/testcase_resource.robot
Test Setup     Open the Browser
Test Teardown      Close the Browser


*** Test Cases ***
Verify the user is logged in or not and launch of Profile page
    Click on Basic actions_login
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${Logginbutton}
    Sleep    3 Seconds
    Go Back
    Sleep    3 Seconds
    Go Back
    Sleep    3 Seconds
    Click Element    Css:${Bookcard}
    Sleep    2 Seconds
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Click on Basic actions_login
    Scroll Element Into View    xpath:${Loginsidebar}
    Sleep    2 Seconds
    Page Should Contain Element    xpath:${Loggedinmessage}
    Log To Console      Verification of user is logged in or not is done
    Click Element    xpath:${Profilelink}
    Sleep    2 Seconds
    ${ProfileUrl}=      Get Location
    Should Be True    '${ProfileUrl}' == '${Purl}'
    Log To Console    Verification of Launching Profile page is successful


Verify unsuccessful login with empty credentials
    Click on Basic actions_login
    Scroll Element Into View    xpath:${Loginsidebar}
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    ${count}=     Get Element Count    xpath:${ErrorIcon}
    Should Be True    ${count} == 2
    Log To Console    Verification of empty credential is successful.

Verify unsuccessful login with invalid username and valid password
    Click on Basic actions_login
    Scroll Element Into View    xpath:${Loginsidebar}
    Input Text    Id:${Username}    kh2
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    ${Emessage}=    Get Text    xpath:${Errormessage}
    Should Be True    '${Emessage}'=='${InvalidError}'
    Log To Console    Verification of invalid username and valid password is successful

Verify unsuccessful login with valid username and invalid password.
    Click on Basic actions_login
    Scroll Element Into View    xpath:${Loginsidebar}
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@!
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    ${Emessage}=    Get Text    xpath:${Errormessage}
    Should Be True    '${Emessage}'=='${InvalidError}'
    Log To Console    Verification of invalid username and valid password is successful

Verify Successful login
    Click on Basic actions_login
    Scroll Element Into View    xpath:${Loginsidebar}
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    ${ProfileUrl}=      Get Location
    Should Be True    '${ProfileUrl}' == '${Purl}'
    Log To Console    Verification of successful login is done

Verify New User button
    Click on Basic actions_login
    Scroll Element Into View    xpath:${Loginsidebar}
    Click Element    xpath:${Newuserbutton}
    Sleep    1 Seconds
    ${SignUpPage}=      Get Location
    Should Be True    '${SignUpPage}'=='${Signupurl}'
    Log To Console    Verification of redirect to register page using new user button is successful

