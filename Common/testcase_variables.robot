*** Variables ***
${url}      https://demoqa.com/
${browser}      Chrome
${Bookcard}     div[class="category-cards"] div:nth-child(6)
${Loginsidebar}     //span[text()='Login']
${Profilesidebar}       //span[text()='Profile']
${Loggedinmessage}      //label[@id='loading-label']
${Username}     userName
${Password}     password
${Logginbutton}     //button[@id='login']
${Purl}     https://demoqa.com/profile
${Signupurl}        https://demoqa.com/register
${LoginURL}     https://demoqa.com/login
${Bookstoreurl}     https://demoqa.com/books
${Profilelink}      //a[contains(text(),'profile')]
${ErrorIcon}        //input[@class='mr-sm-2 is-invalid form-control']
${Errormessage}     //p[text()='Invalid username or password!']
${Newuserbutton}        //button[@id='newUser']
${Logoutbutton}     //button[text()='Log out']
${Author}       //div[contains(text(),'Author')]
${Authorlist}       //div[@class="rt-tr-group"]/div/div[3]
${Searchbox}        //input[@id='searchBox']
${Pageinputpath}        //input[@aria-label="jump to page"]
${Totalpagepath}    //span[@class="-totalPages"]
${Bookslink}        //span[@class="mr-2"]/a
${Details1}      (//label[@id="userName-value"])[2]
${Details2}      (//label[@id="userName-value"])[4]
${Details3}      (//label[@id="userName-value"])[5]
${Addtocollection}      //button[text()='Add To Your Collection']
${UserLogged}       //div[@id='notLoggin-wrapper' and contains(.,'Currently you are not logged')]
${Previousbutton}   //button[text()='Previous']
${Nextbutton}       //button[text()='Next']
${Gotostore}    //button[@id="gotoStore"]
${Backtostore}      //button[text()="Back To Book Store"]
${Deleterecord}     //span[@id='delete-record-undefined']
${Deleteallbook}       (//button[text()='Delete All Books'])[2]
${Deleteaccount}    //button[text()='Delete Account']
${AcceptPopup}      //button[@id="closeSmallModal-ok"]
${Deleteaccpopup}     //div[text()='Do you want to delete your account?']
${Deleteallbookpop}     //div[text()='Do you want to delete all books?']
${Deleterecordpop}      //div[text()='Do you want to delete this book?']