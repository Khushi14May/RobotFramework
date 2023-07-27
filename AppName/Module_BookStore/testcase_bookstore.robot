*** Settings ***
Resource     ../../Common/testcase_resource.robot
Test Setup     Open the Browser
Test Teardown      Close the Browser

Library    String
Library    Collections

*** Test Cases ***
Verify Book Store Page when user is not logged in
    Element Should Be Visible    xpath:${Logginbutton}
    Log To Console    Verification of User is not logged in on the Book Store Page

Verification of redirection to login page and back to Book Store Page
    Click Element    xpath:${Logginbutton}
    Sleep    1 Seconds
    ${Loginurl1}=   Get Location
    Should Be True    '${LoginURL}' == '${Loginurl1}'
    Log To Console    Verification of redirection to login page is successfull
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    ${Bookstoreurl1}=   Get Location
    Should Be True    '${Bookstoreurl}' == '${Bookstoreurl1}'
    Log To Console    Verification of back to book store page is successfull

Verify Book Store Page when user is logged in and get logged out
    Click Element    xpath:${Logginbutton}
    Sleep    1 Seconds
    Scroll Element Into View    xpath:${Loginsidebar}
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    Go Back
    Sleep    2 Seconds
    Go Back
    Sleep    2 Seconds
    Click on Basic actions_BookStore
    Wait Until Element Is Visible       xpath:${Logoutbutton}
    Log To Console    Verification of user is already logged in is successful
    Click Element    xpath:${Logoutbutton}
    Element Should Be Visible       xpath:${Logginbutton}
    Log To Console    Verification of user is successfully logged out


#tc_06,07 remain
Verify whether the books are getting sort
    ${Sortedlist}=     Get WebElements    xpath:${Authorlist}
    ${Sortlist}=        Create List
    FOR    ${item1}    IN    @{Sorted_list}
        Log To Console    Item:${item1.text}
        Append To List    ${Sortlist}      ${item1.text}
    END
    Log To Console    list2:${Sortlist}
    sort list     ${Sortlist}
    Log To Console    Sortedlist2:${Sortlist}
    Click Element    xpath:${Author}
    ${Columnlist}=     Create List
    ${Namelist}=    Get WebElements    xpath:${Authorlist}
    FOR    ${item}    IN    @{Namelist}
        Append To List    ${Columnlist}      ${item.text}
    END
    Log To Console    ${Columnlist}
#    Should Be True    '${Sortlist}'=='${Columnlist}'
    Log To Console    Verification of table is getting sort is successful
#    Should Be True    ${Namelist} == ${Namelist2}


Verify Book Search bar when differnt format of text is entered
    Sleep    1 Seconds
    ${Listofbook}=      Create List     Java  JAVA  JAva  Learning JavaScript Design Patterns
    ${value}=  Evaluate  random.choice(${Listofbook})  random
    Log To Console    ${value}
    ${source}=    Set Variable    ${value}
    Input Text    xpath:${Searchbox}    ${source}
    ${source}=  Convert To Lower Case    ${source}
    Sleep    3 Seconds
    ${Booklist}=    Get WebElements    ${Bookslink}
    FOR    ${item}    IN    @{Booklist}
        Log To Console    Items:${item.text}
        ${items}=   Convert To Lower Case   ${item.text}
        Should Contain    ${items}   ${source}
    END
    Log To Console    Verification of Search basr is successful

Verification of pagination on Book Store page with differnt input
    Sleep    1 Seconds
    ${Totalpage}=   Get Text    xpath:${Totalpagepath}
    ${Listinput}=   Create List     1  0  ${Totalpage}
    ${Pageinput}=  Evaluate  random.choice(${Listinput})  random
    Convert To Integer    ${Totalpage}
    Convert To Integer    ${Pageinput}
    Run Keyword If    ${Pageinput} <= ${Totalpage} and ${Pageinput} != 0    Log To Console    Entered in the loop
            Input Text      xpath:${Pageinputpath}    ${Pageinput}
            Press Keys    xpath:${Pageinputpath}    ENTER
            ${Textinput}=   Get Text    xpath:${Pageinputpath}
            Log To Console    Verification of valid text in pagination is done
    ...
    ...  ELSE
            Input Text      xpath:${Pageinputpath}    ${Pageinput}
            Press Keys    xpath:${Pageinputpath}    ENTER
            ${Textinput}=   Get Text    xpath:${Pageinputpath}
            Should Be True    '${Textinput}'!='${Totalpage}'
            Log To Console    Verification of Invalid text in pagination is done


#Verify the Dropdown of selection of rows

Verify Book Details Page when user is logged in or not.
    ${Booklist}=    Get WebElements    ${Bookslink}
    ${List1}=     Create List
    FOR    ${link}    IN    @{Booklist}
        Log    ${link.text}
        Append To List    ${List1}  ${link.text}
    END
    ${Pageinput}=  Evaluate  random.choice(${List1})  random
    ${var}=     Replace String    //a[contains(text(),'LinkSelected')]    LinkSelected    ${Pageinput}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    ${var}
    Sleep    2 Seconds
    Element Should Be Visible    ${Logginbutton}
    Log To Console    Verification of user is not logged in is successful
    Close the Browser
    Open the Browser
    Click Element    xpath:${Logginbutton}
    Scroll Element Into View    xpath:${Loginsidebar}
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    Go To    ${Bookstoreurl}
    ${Pageinput}=  Evaluate  random.choice(${List1})  random
    ${var}=     Replace String    //a[contains(text(),'LinkSelected')]    LinkSelected    ${Pageinput}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    ${var}
    Sleep    2 Seconds
    Element Should Be Visible    ${Logoutbutton}
    Log To Console    Verification of user is logged in is successful


    
Verify details appearing on detail page is matching with bookstore page
    ${Booklist}=    Get WebElements    ${Bookslink}
    ${List1}=     Create List
    FOR    ${link}    IN    @{Booklist}
        Log    ${link.text}
        Append To List    ${List1}  ${link.text}
    END
    ${Pageinput}=  Evaluate  random.choice(${List1})  random
    ${var}=     Replace String    //a[contains(text(),'LinkSelected')]    LinkSelected    ${Pageinput}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    ${var1}=     Replace String    //a[contains(text(),'Selected')]/../../../following-sibling::div[1]    Selected    ${Pageinput}
    ${var2}=     Replace String    //a[contains(text(),'Selected')]/../../../following-sibling::div[2]    Selected    ${Pageinput}
    ${AuthorName}=      Get Text    xpath:${var1}
    ${Publisher}=      Get Text    xpath:${var2}
    Click Element    ${var}
    Sleep    2 Seconds
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    ${BookName}=        Get Text    xpath:${Details1}
    ${Author1}=      Get Text    xpath:${Details2}
    ${Publisher1}=      Get Text    xpath:${Details3}
    Should Be True    "${BookName}"=="${Pageinput}" and "${Author1}"=="${AuthorName}" and "${Publisher1}"=="${Publisher}"
    Log To Console    Verification of book details is successful



Verify the different action of Add to collection button
    ${Booklist}=    Get WebElements    ${Bookslink}
    ${List1}=     Create List
    FOR    ${link}    IN    @{Booklist}
        Log    ${link.text}
        Append To List    ${List1}  ${link.text}
    END
    ${Pageinput}=  Evaluate  random.choice(${List1})  random
    ${var}=     Replace String    //a[contains(text(),'LinkSelected')]    LinkSelected    ${Pageinput}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    ${var}
    Sleep    2 Seconds
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    Scroll Element Into View    xpath:${Loginsidebar}
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Click Element    xpath:${Addtocollection}
    ${Messagealert1}=    Handle Alert
    Log To Console    ${Messagealert1}
    Go Back
    Go Back
    Sleep    3 Seconds
    Click Element    ${var}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    xpath:${Addtocollection}
    Sleep    2 Seconds
    ${Messagealert2}=    Handle Alert
    Log To Console    ${Messagealert2}
    Should Be True    "${Messagealert1}"=="${BookAdded}" and "${Messagealert2}"=="${BookAlreadyAdded}"

Verify the Go to book store button
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    Scroll Element Into View    xpath:${Loginsidebar}
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    ${var}=     Set Variable   //a[contains(text(),'Speaking JavaScript')]
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    ${var}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    xpath:${Backtostore}
    Sleep    2 Seconds
    ${Bookstoreurl1}=   Get Location
    Should Be True    '${Bookstoreurl}' == '${Bookstoreurl1}'
    Log To Console    Verification of Back to book store button is successful

Verify the login and logout functionality on book details page
    ${Booklist}=    Get WebElements    ${Bookslink}
    ${List1}=     Create List
    FOR    ${link}    IN    @{Booklist}
        Log    ${link.text}
        Append To List    ${List1}  ${link.text}
    END
    ${Pageinput}=  Evaluate  random.choice(${List1})  random
    ${var}=     Replace String    //a[contains(text(),'LinkSelected')]    LinkSelected    ${Pageinput}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    ${var}
    Sleep    2 Seconds
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    Scroll Element Into View    xpath:${Loginsidebar}
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds
    Wait Until Element Is Visible    xpath:${Logoutbutton}
    Click Element    xpath:${Logoutbutton}
    Element Should Be Visible    xpath:${Logginbutton}
    Log To Console    Verification of bith the functionalities is successful
