*** Settings ***
Resource     ../../Common/testcase_resource.robot
Test Setup     Open the Browser
Test Teardown      Close the Browser
Library    Collections
Library    String


*** Test Cases ***

Verify the Profile page when the user is not logged in
    Click Element    xpath:${Profilesidebar}
    Sleep    2 Seconds
    ${text}=      Get Text    xpath:${UserLogged}
    Should Be True    "${text}"=="${Notloggedin}"
    Log To Console    Verification of user is not logged in is successful

Verify the Profile page when the user is logged in
    Click on Baic actions_ProfilePage
    Page Should Not Contain Element    xpath:${UserLogged}
    Log To Console    Verification of user is logged in is successful

Verify Book Search bar
    Click on Baic actions_ProfilePage
    Go To    ${Bookstoreurl}
    Add To Collections
    ${Listofbook}=      Create List     Java  JAVA  JAva
    ${value}=  Evaluate  random.choice(${Listofbook})  random
    Log To Console    ${value}
    ${source}=    Set Variable    ${value}
    Sleep    2 Seconds
    Input Text    xpath:${Searchbox}    ${source}
    ${source}=  Convert To Lower Case    ${source}
    Sleep    3 Seconds
    ${Booklist}=    Get WebElements    ${Bookslink}
    ${Listcompare1}=     Create List
    ${Listcompare2}=     Create List
    FOR    ${item}    IN    @{Booklist}
        Log To Console    Items:${item.text}
        ${items}=   Convert To Lower Case   ${item.text}
        Append To List    ${Listcompare2}    ${items}
        IF  '${source}' in '${items}'
            Append To List    ${Listcompare1}    ${items}
        END
    END
    Should Be True    "${Listcompare1}"=="${Listcompare2}"
    Log To Console    Verification of search bar is successful

Verify Previous button in the collection's Table
    Click on Baic actions_ProfilePage
    Go To    ${Bookstoreurl}
    Add To Collections
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    xpath:${Pageinputpath}    2
    Press Keys      xpath:${Pageinputpath}  ENTER
    ${PageText}=    Get Element Attribute    ${Pageinputpath}    value
    IF    ${PageText} != 1
        Wait Until Element Is Enabled    xpath:${Previousbutton}
        Log To Console    Verification of Previous button is enable is successful
    END
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    xpath:${Pageinputpath}    1
    Press Keys      xpath:${Pageinputpath}  ENTER
    ${PageText}=    Get Element Attribute    ${Pageinputpath}    value
    IF    ${PageText} == 1
        Element Should Be Disabled    xpath:${Previousbutton}
        Log To Console    Verification of Previous button is disable is successful
    END


Verify Next button in the collection's Table
    Click on Baic actions_ProfilePage
    Go To    ${Bookstoreurl}
    Add To Collections
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    ${PageText}=    Get Element Attribute    ${Pageinputpath}    value
    ${TotalText}=       Get Text    xpath:${Totalpagepath}
    IF    ${PageText} < ${TotalText} and ${PageText}!=0
         Wait Until Element Is Enabled    xpath:${Nextbutton}
         Log To Console    Verification of Next button is enabled is successful
    END
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    xpath:${Pageinputpath}    ${TotalText}
    Sleep    2 Seconds
    Press Keys      xpath:${Pageinputpath}  ENTER
    Sleep    2 Seconds
    ${PageText}=    Get Element Attribute    ${Pageinputpath}    value
    IF    ${PageText} == ${TotalText}
        Element Should Be Disabled    xpath:${Nextbutton}
        Log To Console    Verification of Next button is disable is successful
    END


Verify functionality of delete icon in the table
    Click on Baic actions_ProfilePage
    Go To    ${Bookstoreurl}
    Add To Collections
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    ${count}=   Get Element Count    xpath:${Deleterecord}
    Log To Console    ${count}
    IF    ${count} == 1
        ${Value}=   Set Variable    1
    ELSE
        ${Random Numbers}=     Evaluate  random.sample(range(1, ${count}),1)   random
        ${Value}=   Set Variable    ${Random Numbers}[0]
        ${Value}=   Convert To String    ${Value}
    END
    ${var}=     Replace String    (//span[@id='delete-record-undefined'])[value]    value    ${Value}
    ${var2}=     Replace String    (//span[@class="mr-2"]/a)[value]    value    ${Value}
    ${Intialtext}=  Get Text    xpath:${var2}
    Click Element    ${var}
    Sleep    5 Seconds
    Wait Until Element Is Visible    xpath:${Deleterecordpop}
    Click Element    xpath:${AcceptPopup}
    Handle Alert
    Page Should Not Contain    ${Intialtext}
Verify the Dropdown of selection of rows on Profile Page.
    Click on Baic actions_ProfilePage
    Go To    ${Bookstoreurl}
    Add To Collections
    Sleep    2 Seconds
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Select From List By Value    xpath://select[@aria-label="rows per page"]    10
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    ${Droupdowntext}=   Get Selected List Value    xpath://select[@aria-label="rows per page"]
    ${count}=   Get Element Count    xpath:${Bookslink}
    Should Be True    ${count}<=${Droupdowntext}
    Log To Console    Verification of droupdown is successful



Verify the Go to book store button
    Click on Baic actions_ProfilePage
    Set Window Size    742    522
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Scroll Element Into View    xpath:${Gotostore}
    Click Element    xpath:${Gotostore}
    Maximize Browser Window
    Sleep    2 Seconds
    ${Bookstoreurl1}=   Get Location
    Should Be True    '${Bookstoreurl}' == '${Bookstoreurl1}'
    Log To Console    Verification of Go to book store button is successful


Verify the delete all books button
    Click on Baic actions_ProfilePage
    Set Window Size    742    522
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Scroll Element Into View    xpath:${Deleteallbook}
    Click Element    xpath:${Deleteallbook}
    Sleep    2 Seconds
    Wait Until Element Is Visible    xpath:${Deleteallbookpop}
    Click Element    xpath:${AcceptPopup}
    Handle Alert
    Maximize Browser Window
    Page Should Contain    ${Norows}
    Log To Console    Verification of delete all the books is successful


Verify the delete account button
    Click on Baic actions_ProfilePage
    Set Window Size    742    522
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Scroll Element Into View    xpath:${Deleteaccount}
    Click Element    xpath:${Deleteaccount}
    Sleep    2 Seconds
    Wait Until Element Is Visible    xpath:${Deleteaccpopup}
    Click Element    xpath:${AcceptPopup}
    Handle Alert
    Maximize Browser Window
    Go To    ${LoginURL}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    Element Should Be Visible    xpath:${Errormessage}
    Log To Console    Verification of delete account is successful

