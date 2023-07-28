*** Variables ***
${Url}      https://demoqa.com/
${Browser}      Chrome
${BookCard}     div[class="category-cards"] div:nth-child(6)
${LoginSideBar}     //span[text()='Login']
${ProfileSideBar}       //span[text()='Profile']
${LoggedInMessage}      //label[@id='loading-label']
${Username}     userName
${Password}     password
${LoginButton}     //button[@id='login']
${Purl}     https://demoqa.com/profile
${SignupUrl}        https://demoqa.com/register
${LoginURL}     https://demoqa.com/login
${BookStoreUrl}     https://demoqa.com/books
${ProfileLink}      //a[contains(text(),'profile')]
${ErrorIcon}        //input[@class='mr-sm-2 is-invalid form-control']
${ErrorMessage}     //p[text()='Invalid username or password!']
${NewUserbutton}        //button[@id='newUser']
${LogoutButton}     //button[text()='Log out']
${Author}       //div[contains(text(),'Author')]
${AuthorList}       //div[@class="rt-tr-group"]/div/div[3]
${SearchBox}        //input[@id='searchBox']
${PageInputPath}        //input[@aria-label="jump to page"]
${TotalPagePath}    //span[@class="-totalPages"]
${BooksLink}        //span[@class="mr-2"]/a
${Details1}      (//div[@class="col-md-9 col-sm-12"]//label)[2]
${Details2}      (//div[@class="col-md-9 col-sm-12"]//label)[4]
${Details3}      (//div[@class="col-md-9 col-sm-12"]//label)[5]
${AddToCollection}      //button[text()='Add To Your Collection']
${UserLogged}       //div[@id='notLoggin-wrapper' and contains(.,'Currently you are not logged')]
${PreviousButton}   //button[text()='Previous']
${NextButton}       //button[text()='Next']
${GoToStore}    //button[@id="gotoStore"]
${BackToStore}      //button[text()="Back To Book Store"]
${DeleteRecord}     //span[@id='delete-record-undefined']
${DeleteAllBook}       //div[@class="text-right button di"]//button
${DeleteAccount}    //button[text()='Delete Account']
${AcceptPopup}      //button[@id="closeSmallModal-ok"]
${DeleteAccPopup}     //div[text()='Do you want to delete your account?']
${DeleteAllBookPop}     //div[text()='Do you want to delete all books?']
${DeleteRecordPop}      //div[text()='Do you want to delete this book?']
