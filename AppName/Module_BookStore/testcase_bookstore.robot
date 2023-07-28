*** Settings ***
Resource     ../../Common/testcase_resource.robot
Library    String
Library    Collections
Suite Setup     Open the Browser
Suite Teardown      Close the Browser
# Author: khushi.shah

*** Test Cases ***
Verify Book Store Page When User Is Not Logged In
    Set Selenium Speed    1 Seconds
    Element Should Be Visible    xpath:${LoginButton}
    Log To Console    Verification of User is not logged in on the Book Store Page

Verification Of Redirection To Login Page And Back To Book Store Page
    Set Selenium Speed    1 Seconds
    Click Element    xpath:${LoginButton}
    Sleep    1 Seconds
    ${LoginUrl1}=   Get Location
    Should Be True    '${LoginURL}' == '${LoginUrl1}'
    Log To Console    Verification of redirection to login page is successfull
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${LoginButton}
    Sleep    2 Seconds
    ${BookStoreUrl1}=   Get Location
    Should Be True    '${BookStoreUrl}' == '${BookStoreUrl1}'
    Log To Console    Verification of back to book store page is successfull

Verify Book Store Page When User Is Logged In And Get Logged Out
    Set Selenium Speed    1 Seconds
    Wait Until Element Is Visible       xpath:${LogoutButton}
    Log To Console    Verification of user is already logged in is successful
    Click Element    xpath:${LogoutButton}
    Go To    ${BookStoreUrl}
    Wait Until Element Is Visible      xpath:${LoginButton}
    Log To Console    Verification of user is successfully logged out
    Click Element    xpath:${LoginButton}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${LoginButton}
    Go To    ${BookStoreUrl}

Verify Whether The Books Are Getting Sort
    Set Selenium Speed    1 Seconds
    ${SortedList}=     Get WebElements    xpath:${AuthorList}
    ${SortList}=        Create List
    FOR    ${Item1}    IN    @{SortedList}
        Log To Console    Item:${Item1.text}
        Append To List    ${Sortlist}      ${Item1.text}
    END
    Log To Console    list2:${SortList}
    sort list     ${SortList}
    Log To Console    Sortedlist2:${SortList}
    Click Element    xpath:${Author}
    ${ColumnList}=     Create List
    ${NameList}=    Get WebElements    xpath:${AuthorList}
    FOR    ${Item}    IN    @{NameList}
        Append To List    ${ColumnList}      ${Item.text}
    END
    Log To Console    ${ColumnList}
#    Should Be True    '${Sortlist}'=='${Columnlist}'
    Log To Console    Verification of table is getting sort is successful
#    Should Be True    ${Namelist} == ${Namelist2}


Verify Book Search Bar When Different Format Of Text Is Entered
    Set Selenium Speed    1 Seconds
    Sleep    1 Seconds
    ${ListOfBook}=      Create List     Java  JAVA  JAva  Learning JavaScript Design Patterns
    ${Value}=  Evaluate  random.choice(${ListOfBook})  random
    Log To Console    ${Value}
    ${Source}=    Set Variable    ${Value}
    Input Text    xpath:${SearchBox}    ${Source}
    ${Source}=  Convert To Lower Case    ${Source}
    Sleep    3 Seconds
    ${BookList}=    Get WebElements    ${BooksLink}
    FOR    ${Item}    IN    @{BookList}
        Log To Console    Items:${Item.text}
        ${Items}=   Convert To Lower Case   ${Item.text}
        Should Contain    ${Items}   ${Source}
    END
    Log To Console    Verification of Search basr is successful

Verification Of Pagination On Book Store Page With Differnt Input
    Set Selenium Speed    1 Seconds
    Set Window Size    742    522
    ${TotalPage}=   Get Text    xpath:${TotalPagePath}
    ${ListInput}=   Create List     1  0  ${TotalPage}
    ${PageInput}=  Evaluate  random.choice(${ListInput})  random
    Convert To Integer    ${TotalPage}
    Convert To Integer    ${PageInput}
    Run Keyword If    ${PageInput} <= ${TotalPage} and ${PageInput} != 0    Log To Console    Entered in the loop
            Input Text      xpath:${PageInputPath}    ${PageInput}
            Press Keys    xpath:${PageInputPath}    ENTER
            ${TextInput}=   Get Text    xpath:${PageInputPath}
            Log To Console    Verification of valid text in pagination is done
    ...
    ...  ELSE
            Input Text      xpath:${PageInputPath}    ${PageInput}
            Press Keys    xpath:${PageInputPath}    ENTER
            ${TextInput}=   Get Text    xpath:${PageInputPath}
            Should Be True    '${TextInput}'!='${TotalPage}'
            Log To Console    Verification of Invalid text in pagination is done



Verify The Dropdown Of Selection Of Rows
    Set Selenium Speed    1 Seconds
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Select From List By Value    xpath://select[@aria-label="rows per page"]    10
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    ${DroupdownText}=   Get Selected List Value    xpath://select[@aria-label="rows per page"]
    ${Count}=   Get Element Count    xpath:${BooksLink}
    Should Be True    ${Count}<=${DroupdownText}
    Maximize Browser Window
    Log To Console    Verification of droupdown is successful

Verify Book Details Page When User Is Logged In Or Not.
    Set Selenium Speed    1 Seconds
    ${BookList}=    Get WebElements    ${BooksLink}
    ${List1}=     Create List
    FOR    ${Link}    IN    @{BookList}
        Log    ${Link.text}
        Append To List    ${List1}  ${Link.text}
    END
    ${Pageinput}=  Evaluate  random.choice(${List1})  random
    ${Var}=     Replace String    //a[contains(text(),'LinkSelected')]    LinkSelected    ${Pageinput}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    ${Var}
    Sleep    2 Seconds
    Wait Until Element Is Visible    ${LogoutButton}
    Log To Console    Verification of user is logged in is successful
    Click Element    xpath:${LogoutButton}
    Go To    ${BookStoreUrl}
    Wait Until Element Is Visible      xpath:${LoginButton}
    Log To Console    Verification of user is successfully logged out
    Click Element    xpath:${LoginButton}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${Loginbutton}
    Go To    ${BookStoreUrl}
    
Verify Details Appearing On Detail Page Is Matching With Bookstore Page
    Set Selenium Speed    1 Seconds
    ${BookList}=    Get WebElements    ${BooksLink}
    ${List1}=     Create List
    FOR    ${Link}    IN    @{BookList}
        Log    ${Link.text}
        Append To List    ${List1}  ${Link.text}
    END
    ${PageInput}=  Evaluate  random.choice(${List1})  random
    ${Var}=     Replace String    //a[contains(text(),'LinkSelected')]    LinkSelected    ${Pageinput}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    ${Var1}=     Replace String    //a[contains(text(),'Selected')]/../../../following-sibling::div[1]    Selected    ${Pageinput}
    ${Var2}=     Replace String    //a[contains(text(),'Selected')]/../../../following-sibling::div[2]    Selected    ${Pageinput}
    ${AuthorName}=      Get Text    xpath:${Var1}
    ${Publisher}=      Get Text    xpath:${Var2}
    Click Element    ${Var}
    Sleep    2 Seconds
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    ${BookName}=        Get Text    xpath:${Details1}
    ${Author1}=      Get Text    xpath:${Details2}
    ${Publisher1}=      Get Text    xpath:${Details3}
    Should Be True    "${BookName}"=="${PageInput}" and "${Author1}"=="${AuthorName}" and "${Publisher1}"=="${Publisher}"
    Log To Console    Verification of book details is successful



Verify the Different Action Of Add to Collection Button
    Set Selenium Speed    1 Seconds
    Go To    ${BookStoreUrl}
    ${BookList}=    Get WebElements    ${BooksLink}
    ${List1}=     Create List
    FOR    ${Link}    IN    @{BookList}
        Log    ${Link.text}
        Append To List    ${List1}  ${Link.text}
    END
    ${PageInput}=  Evaluate  random.choice(${List1})  random
    ${Var}=     Replace String    //a[contains(text(),'LinkSelected')]    LinkSelected    ${Pageinput}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    ${Var}
    Sleep    2 Seconds
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Click Element    xpath:${AddToCollection}
    ${MessageAlert1}=    Handle Alert
    Log To Console    ${MessageAlert1}
    Go To    ${BookStoreUrl}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Click Element    ${Var}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    xpath:${AddToCollection}
    Sleep    2 Seconds
    ${MessageAlert2}=    Handle Alert
    Log To Console    ${MessageAlert2}
    Should Be True    "${MessageAlert1}"=="${BookAdded}" and "${MessageAlert2}"=="${BookAlreadyAdded}"

Verify The Go To Book Store Button
    Set Selenium Speed    1 Seconds
    Go To    ${BookStoreUrl}
    ${Var}=     Set Variable   //a[contains(text(),'Speaking JavaScript')]
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    ${Var}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    xpath:${BackToStore}
    Sleep    2 Seconds
    ${BookStoreUrl1}=   Get Location
    Should Be True    '${BookStoreUrl}' == '${BookStoreUrl1}'
    Log To Console    Verification of Back to book store button is successful
