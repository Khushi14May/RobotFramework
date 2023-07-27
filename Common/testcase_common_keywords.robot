*** Settings ***
Library     SeleniumLibrary
Resource     ./testcase_variables.robot

*** Keywords ***
Open the Browser
    Open Browser  ${url}    ${browser}
    Maximize Browser Window
    Click Element    Css:${Bookcard}
    Sleep    2 Seconds
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)

Close the Browser
    Close Browser

Click on Basic actions_login
    Sleep    2 Seconds
    Click Element    xpath:${Loginsidebar}
    Sleep    2 Seconds

Click on Basic actions_BookStore
    Click Element    Css:${Bookcard}
    Sleep    2 Seconds

Click on Baic actions_ProfilePage
    Sleep    2 Seconds
    Click Element    xpath:${Loginsidebar}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Sleep    2 Seconds
    Click Element    xpath:${Logginbutton}
    Sleep    2 Seconds

Add To Collections
    ${var}=     Set Variable   //a[contains(text(),'Speaking JavaScript')]
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    ${var}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    xpath:${Addtocollection}
    Sleep    1 Seconds
    Alert Should Be Present
    Sleep    2 Seconds
    Go To    ${Purl}