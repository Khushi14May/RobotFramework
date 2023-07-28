*** Settings ***
Library     SeleniumLibrary
Resource     ./testcase_variables.robot

*** Keywords ***
Open the Browser
    Open Browser  ${Url}    ${Browser}
    Maximize Browser Window
    Click Element    Css:${BookCard}
    Sleep    2 Seconds
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)

Close the Browser
    Close Browser

Click on Basic actions_login
    Sleep    2 Seconds
    Click Element    xpath:${LoginSideBar}
    Sleep    2 Seconds

Click on Basic actions_BookStore
    Click Element    Css:${BookCard}
    Sleep    2 Seconds

Click on Baic actions_ProfilePage
    Sleep    2 Seconds
    Click Element    xpath:${LoginSideBar}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Input Text    Id:${Username}    kh1
    Input Password    Id:${Password}    Khushi@1!
    Sleep    2 Seconds
    Click Element    xpath:${LoginButton}
    Sleep    2 Seconds

Add To Collections
    ${Var}=     Set Variable   //a[contains(text(),'Speaking JavaScript')]
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    ${Var}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2 Seconds
    Click Element    xpath:${AddToCollection}
    Sleep    1 Seconds
    Alert Should Be Present
    Sleep    2 Seconds
    Go To    ${Purl}

    