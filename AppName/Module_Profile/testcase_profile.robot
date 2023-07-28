*** Settings ***
Resource     ../../Common/testcase_resource.robot
Suite Setup     Open the Browser
Suite Teardown      Close the Browser
Library    Collections
Library    String
# Author: khushi.shah

*** Test Cases ***

Verify The Profile Page When The User Is Not Logged In
    Set Selenium Speed    1 Seconds
    Click Element    xpath:${ProfileSideBar}
    Sleep    2 Seconds
    ${Text}=      Get Text    xpath:${UserLogged}
    Should Be True    "${Text}"=="${NotLoggedIn}"
    Log To Console    Verification of user is not logged in is successful

Verify The Profile Page When The User Is Logged In
    Set Selenium Speed    1 Seconds
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Click on Baic actions_ProfilePage
    Page Should Not Contain Element    xpath:${UserLogged}
    Log To Console    Verification of user is logged in is successful

Verify Book Search Bar
    Set Selenium Speed    1 Seconds
    Go To    ${BookStoreUrl}
    Add To Collections
    Go To    ${Purl}
    ${ListOfBook}=      Create List     Java  JAVA  JAva
    ${Value}=  Evaluate  random.choice(${ListOfBook})  random
    Log To Console    ${Value}
    ${Source}=    Set Variable    ${Value}
    Sleep    2 Seconds
    Input Text    xpath:${Searchbox}    ${Source}
    ${Source}=  Convert To Lower Case    ${Source}
    Sleep    3 Seconds
    ${BookList}=    Get WebElements    ${BooksLink}
    ${Listcompare1}=     Create List
    ${Listcompare2}=     Create List
    FOR    ${Item}    IN    @{BookList}
        Log To Console    Items:${Item.text}
        ${Items}=   Convert To Lower Case   ${Item.text}
        Append To List    ${Listcompare2}    ${Items}
        IF  '${Source}' in '${Items}'
            Append To List    ${Listcompare1}    ${Items}
        END
    END
    Should Be True    "${Listcompare1}"=="${Listcompare2}"
    Log To Console    Verification of search bar is successful

Verify Previous Button In The Collection's Table
    Set Selenium Speed    1 Seconds
    Set Window Size    742    522
    Input Text    xpath:${PageInputPath}    2
    Press Keys      xpath:${PageInputPath}  ENTER
    ${PageText}=    Get Element Attribute    ${PageInputPath}    value
    IF    ${PageText} != 1
        Wait Until Element Is Enabled    xpath:${PreviousButton}
        Log To Console    Verification of Previous button is enable is successful
    END
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    xpath:${PageInputPath}    1
    Press Keys      xpath:${PageInputPath}  ENTER
    ${PageText}=    Get Element Attribute    ${PageInputPath}    value
    IF    ${PageText} == 1
        Element Should Be Disabled    xpath:${PreviousButton}
        Log To Console    Verification of Previous button is disable is successful
    END


Verify Next Button In The Collection's Table
    Set Selenium Speed    1 Seconds
    ${PageText}=    Get Element Attribute    ${PageInputPath}    value
    ${TotalText}=       Get Text    xpath:${TotalPagePath}
    IF    ${PageText} < ${TotalText} and ${PageText}!=0
         Wait Until Element Is Enabled    xpath:${NextButton}
         Log To Console    Verification of Next button is enabled is successful
    END
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    xpath:${PageInputPath}    ${TotalText}
    Sleep    2 Seconds
    Press Keys      xpath:${PageInputPath}  ENTER
    Sleep    2 Seconds
    ${PageText}=    Get Element Attribute    ${PageInputPath}    value
    IF    ${PageText} == ${TotalText}
        Element Should Be Disabled    xpath:${NextButton}
        Log To Console    Verification of Next button is disable is successful
    END


Verify Functionality Of Delete Icon In The Table
    Set Selenium Speed    1 Seconds
    Maximize Browser Window
    ${Count}=   Get Element Count    xpath:${DeleteRecord}
    Log To Console    ${Count}
    IF    ${Count} == 1
        ${Value}=   Set Variable    1
    ELSE
        ${RandomNumbers}=     Evaluate  random.sample(range(1, ${Count}),1)   random
        ${Value}=   Set Variable    ${RandomNumbers}[0]
        ${Value}=   Convert To String    ${Value}
    END
    ${Var}=     Replace String    (//span[@id='delete-record-undefined'])[value]    value    ${Value}
    ${Var2}=     Replace String    (//span[@class="mr-2"]/a)[value]    value    ${Value}
    ${IntialText}=  Get Text    xpath:${Var2}
    Click Element    ${Var}
    Sleep    5 Seconds
    Wait Until Element Is Visible    xpath:${DeleteRecordpop}
    Click Element    xpath:${AcceptPopup}
    Handle Alert
    Page Should Not Contain    ${IntialText}

Verify The Dropdown Of Selection Of Rows On Profile Page
    Set Selenium Speed    1 Seconds
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Go To    ${BookStoreUrl}
    Add To Collections
    Sleep    2 Seconds
    Go To    ${Purl}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Select From List By Value    xpath://select[@aria-label="rows per page"]    10
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    ${DroupdownText}=   Get Selected List Value    xpath://select[@aria-label="rows per page"]
    ${Count}=   Get Element Count    xpath:${BooksLink}
    Should Be True    ${Count}<=${DroupdownText}
    Log To Console    Verification of droupdown is successful

Verify The Go To Book Store Button
    Set Selenium Speed    1 Seconds
    Set Window Size    742    522
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Click Element    xpath:${GoToStore}
    Maximize Browser Window
    Sleep    2 Seconds
    ${BookStoreUrl1}=   Get Location
    Should Be True    '${BookStoreUrl}' == '${BookStoreUrl1}'
    Log To Console    Verification of Go to book store button is successful


Verify The Delete All Books Button
    Set Selenium Speed    1 Seconds
    Go To    ${Purl}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Click Element    xpath:${DeleteAllBook}
    Sleep    2 Seconds
    Wait Until Element Is Visible    xpath:${DeleteAllBookPop}
    Click Element    xpath:${AcceptPopup}
    Handle Alert
    Maximize Browser Window
    Page Should Contain    ${NoRows}
    Log To Console    Verification of delete all the books is successful


Verify The Delete Account Button
    Set Selenium Speed    1 Seconds
    Scroll Element Into View    xpath:${DeleteAccount}
    Click Element    xpath:${DeleteAccount}
    Sleep    2 Seconds
    Wait Until Element Is Visible    xpath:${DeleteAccPopup}
    Click Element    xpath:${AcceptPopup}
    Handle Alert
    Maximize Browser Window
    Go To    ${LoginURL}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${LoginButton}
    Sleep    2 Seconds
    Element Should Be Visible    xpath:${ErrorMessage}
    Log To Console    Verification of delete account is successful


