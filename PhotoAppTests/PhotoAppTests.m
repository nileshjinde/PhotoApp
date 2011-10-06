//
//  PhotoAppTests.m
//  PhotoAppTests
//
//  Created by bhuvan khanna on 16/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import "PhotoAppTests.h"

@implementation PhotoAppTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
     photoCTester=[[PhotoContestViewController alloc] initWithNibName:@"PhotoContestViewController" bundle:nil];
    loginCTester=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    signupCTester=[[SignupViewController alloc] initWithNibName:@"SignupViewController" bundle:nil];

}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
     [photoCTester release];
    [loginCTester release];
    [signupCTester release];
}
#if USE_APPLICATION_UNIT_TEST

- (void) testViewLoad {  // test1
    
    //check if view is loaded
    [photoCTester loadView]; //It is not strictly necessary to call loadView for this test as we access the view property which will call loadView if view is nil
    STAssertTrue([photoCTester isViewLoaded], @"View failed to load");
    
    [loginCTester loadView]; //It is not strictly necessary to call loadView for this test as we access the view property which will call loadView if view is nil
    STAssertTrue([loginCTester isViewLoaded], @"View failed to load");
    
}

-(void)testTakePicButton  // test2
{
    [photoCTester loadView];
    UIButton *btn_takepicture;
	object_getInstanceVariable(photoCTester, "takePictureButton", (void **)&btn_takepicture);
	STAssertNotNil(btn_takepicture, @"uibutton Camera not set on load");
    
    
  	NSArray *actions = [btn_takepicture
                        actionsForTarget:photoCTester
                        forControlEvent:UIControlEventTouchUpInside];
	
	STAssertEqualObjects([actions objectAtIndex:0], @"getCameraPicture:",
                         @"btn_takepicture button doesn't invoke getCameraPicture:");
    
    
    NSString *st=[[NSString alloc] init];
    st=btn_takepicture.titleLabel.text;
    NSString *str4 = @"Camera";
    STAssertEqualObjects(str4, st,  @"We expected %@, but it was %@",str4,st);
    
    [st release];
    
}

-(void)testGalleryPicButton  //test3
{
    [photoCTester loadView];
    UIButton *btn_Galpicture;
	object_getInstanceVariable(photoCTester, "GalleryButton", (void **)&btn_Galpicture);
	STAssertNotNil(btn_Galpicture, @"uibutton  not set on load");
    
    
  	NSArray *actions = [btn_Galpicture
                        actionsForTarget:photoCTester
                        forControlEvent:UIControlEventTouchUpInside];
	
	STAssertEqualObjects([actions objectAtIndex:0], @"getGalleryPicture",
                         @"btn_Galpicture button doesn't invoke GetGalleryPicture");
    
    
    NSString *st=[[NSString alloc] init];
    st=btn_Galpicture.titleLabel.text;
    NSString *str4 = @"Album";
    STAssertEqualObjects(str4, st,  @"We expected %@, but it was %@",str4,st);
    
    [st release];
    
}
-(void)testImageView   //test4
{
    [photoCTester loadView];
    UIImageView *showImage;
	object_getInstanceVariable(photoCTester, "imageView", (void **)&showImage);
	STAssertNotNil(showImage, @"uiImageView  not set on load");
}


- (void)testCheckbtnTakePictureClick   //test5
{
    [photoCTester loadView];
    
    [photoCTester getCameraPicture: photoCTester.takePictureButton];
    
    
}
- (void)testCheckbtnAlbumClick   //test6
{
    [photoCTester loadView];
    
    [photoCTester getGalleryPicture];
    
}
-(void)testeffctScrollView    //test7
{
    [photoCTester loadView];
    UIScrollView *effectscroll;
	object_getInstanceVariable(photoCTester, "effectscroll", (void **)&effectscroll);
	STAssertNotNil(effectscroll, @"uiScrollView  not set on load");
}
- (void)testCheckbtnAl   //test8
{
   // [photoCTester loadView];
    
    //[photoCTester RedEffect];
    
}

//------------------------------------------LoginPage testing----------------------------------
-(void)testLoginLabelTitle  //test9
{
    [loginCTester loadView];
    UILabel *lbl_title;
	object_getInstanceVariable(loginCTester, "loginTitle", (void **)&lbl_title);
	STAssertNotNil(lbl_title, @"uiLabel  not set on load");
    
    NSString *st=[[NSString alloc] init];
    st=lbl_title.text;
    NSString *str4 = @"Login";
    STAssertEqualObjects(str4, st,  @"We expected %@, but it was %@",str4,st);
    
    [st release];

}
-(void)testUnmaeText  //test10
{
    [loginCTester loadView];
    UITextField *txt_username;
	object_getInstanceVariable(loginCTester, "txt_uname", (void **)&txt_username);
	STAssertNotNil(txt_username, @"uiTextField  not set on load");
    
    
    NSString *st=[[NSString alloc] init];
    st=txt_username.placeholder;
    NSString *str4 = @"Email";
    STAssertEqualObjects(str4, st,  @"We expected %@, but it was %@",str4,st);
    
    [st release];
    
}
-(void)testPasswordText  //test11
{
    [loginCTester loadView];
    UITextField *txt_password;
	object_getInstanceVariable(loginCTester, "txt_pwd", (void **)&txt_password);
	STAssertNotNil(txt_password, @"uiTextField  not set on load");
    
    
    NSString *st=[[NSString alloc] init];
    st=txt_password.placeholder;
    NSString *str4 = @"Password";
    STAssertEqualObjects(str4, st,  @"We expected %@, but it was %@",str4,st);
    
    [st release];
    
}
-(void)testLoginButton  //test12
{
    [loginCTester loadView];
    UIButton *btn_login;
	object_getInstanceVariable(loginCTester, "btn_login", (void **)&btn_login);
	STAssertNotNil(btn_login, @"uibutton  not set on load");
    
    
  	NSArray *actions = [btn_login
                        actionsForTarget:loginCTester
                        forControlEvent:UIControlEventTouchUpInside];
	
	STAssertEqualObjects([actions objectAtIndex:0], @"getLogin:",
                         @"btn_login button doesn't invoke getLogin");
    
    
    NSString *st=[[NSString alloc] init];
    st=btn_login.titleLabel.text;
    NSString *str4 = @"Login";
    STAssertEqualObjects(str4, st,  @"We expected %@, but it was %@",str4,st);
    
    [st release];
    
}
-(void)testSignUpButton  //test13
{
    [loginCTester loadView];
    UIButton *btn_signUp;
	object_getInstanceVariable(loginCTester, "btn_signup", (void **)&btn_signUp);
	STAssertNotNil(btn_signUp, @"uibutton  not set on load");
    
    
  	NSArray *actions = [btn_signUp
                        actionsForTarget:loginCTester
                        forControlEvent:UIControlEventTouchUpInside];
	
	STAssertEqualObjects([actions objectAtIndex:0], @"getSignUp:",
                         @"btn_signup button doesn't invoke getSignUp");
    
    
    NSString *st=[[NSString alloc] init];
    st=btn_signUp.titleLabel.text;
    NSString *str4 = @"Sign up";
    STAssertEqualObjects(str4, st,  @"We expected %@, but it was %@",str4,st);
    
    [st release];
    
}

//------------------------------------------------------------------------------------------------
//------------------------------------------SignPage testing----------------------------------
-(void)testSignupLabelTitle  //test14
{
    [signupCTester loadView];
    UILabel *lbl_title;
	object_getInstanceVariable(signupCTester, "signupTitle", (void **)&lbl_title);
	STAssertNotNil(lbl_title, @"uiLabel  not set on load");
    
    NSString *st=[[NSString alloc] init];
    st=lbl_title.text;
    NSString *str4 = @"Sign up";
    STAssertEqualObjects(str4, st,  @"We expected %@, but it was %@",str4,st);
    
    [st release];
    
}
-(void)testnamaeText  //test15
{
    [signupCTester loadView];
    UITextField *txt_name;
	object_getInstanceVariable(signupCTester, "txt_name_signup", (void **)&txt_name);
	STAssertNotNil(txt_name, @"uiTextField  not set on load");
    
    
    NSString *st=[[NSString alloc] init];
    st=txt_name.placeholder;
    NSString *str4 = @"Name";
    STAssertEqualObjects(str4, st,  @"We expected %@, but it was %@",str4,st);
    
    [st release];
    
}
-(void)testEmailText  //test16
{
    [signupCTester loadView];
    UITextField *txt_email;
	object_getInstanceVariable(signupCTester, "txt_email_signup", (void **)&txt_email);
	STAssertNotNil(txt_email, @"uiTextField  not set on load");
    
    
    NSString *st=[[NSString alloc] init];
    st=txt_email.placeholder;
    NSString *str4 = @"Email";
    STAssertEqualObjects(str4, st,  @"We expected %@, but it was %@",str4,st);
    
    [st release];
    
}
-(void)testsignUpLoginButton  //test17
{
    [signupCTester loadView];
    UIButton *btn_login;
	object_getInstanceVariable(signupCTester, "btn_login_signup", (void **)&btn_login);
	STAssertNotNil(btn_login, @"uibutton  not set on load");
    
    
  	NSArray *actions = [btn_login
                        actionsForTarget:signupCTester
                        forControlEvent:UIControlEventTouchUpInside];
	
	STAssertEqualObjects([actions objectAtIndex:0], @"getLogin_signup:",
                         @"btn_login button doesn't invoke getLogin");
    
    
    NSString *st=[[NSString alloc] init];
    st=btn_login.titleLabel.text;
    NSString *str4 = @"Login";
    STAssertEqualObjects(str4, st,  @"We expected %@, but it was %@",str4,st);
    
    [st release];
    
}
-(void)testSignupSignUpButton  //test18
{
    [signupCTester loadView];
    UIButton *btn_signUp;
	object_getInstanceVariable(signupCTester, "btn_signup_signup", (void **)&btn_signUp);
	STAssertNotNil(btn_signUp, @"uibutton  not set on load");
    
    
  	NSArray *actions = [btn_signUp
                        actionsForTarget:signupCTester
                        forControlEvent:UIControlEventTouchUpInside];
	
	STAssertEqualObjects([actions objectAtIndex:0], @"getSignUp_signup:",
                         @"btn_signup button doesn't invoke getSignUp");
    
    
    NSString *st=[[NSString alloc] init];
    st=btn_signUp.titleLabel.text;
    NSString *str4 = @"Sign up";
    STAssertEqualObjects(str4, st,  @"We expected %@, but it was %@",str4,st);
    
    [st release];
    
}
-(void)testSignupAlreadyRegLabel  //test19
{
    [signupCTester loadView];
    UILabel *lbl_title;
	object_getInstanceVariable(signupCTester, "signupAlreadyReg", (void **)&lbl_title);
	STAssertNotNil(lbl_title, @"uiLabel  not set on load");
    
    NSString *st=[[NSString alloc] init];
    st=lbl_title.text;
    NSString *str4 = @"Already registered?";
    STAssertEqualObjects(str4, st,  @"We expected %@, but it was %@",str4,st);
    
    [st release];
    
}

//------------------------------------------------------------------------------------------------

#else

- (void)testExample  //test8
{
    // STFail(@"Unit tests are not implemented yet in PhotoContestTests");
   // assertThat([photoCTester.takePictureButton actionsForTarget:photoCTester forControlEvent:UIControlEventTouchUpInside], onlyContains(@"getCameraPicture", nil));
}

#endif




@end
