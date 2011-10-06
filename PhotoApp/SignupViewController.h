//
//  SignupViewController.h
//  PhotoApp
//
//  Created by bhuvan khanna on 19/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import "LoginViewController.h"

#import "RestConnectionDelegate.h"
#import "Appstatus.h"
#import "PhotoContestViewController.h"



@class LoginViewController;
@class RestConnection;
@class PhotoContestViewController;

@interface SignupViewController : UIViewController
{
    IBOutlet UIButton *btn_login_signup;
    IBOutlet UIButton *btn_signup_signup;
    
    IBOutlet UITextField *txt_name_signup;
    IBOutlet UITextField *txt_email_signup;
    IBOutlet UITextField *txt_compId_signup; 
    
    IBOutlet LoginViewController *loginviewcontroller;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet PhotoContestViewController *photoView_fromSignup;
    IBOutlet UILabel *signupTitle;
     IBOutlet UILabel *signupAlreadyReg;
    
@private 
	RestConnection *restConnection;
     Appstatus *appstatus;
    NSString *authCode;
    
}

@property(nonatomic,retain) UIButton *btn_login_signup;
@property(nonatomic,retain) UIButton *btn_signup_signup;

@property(nonatomic,retain) UITextField *txt_name_signup;
@property(nonatomic,retain) UITextField *txt_compId_signup;
@property(nonatomic,retain) UITextField *txt_email_signup;

@property(nonatomic,retain) LoginViewController *loginviewcontroller;
@property(nonatomic,retain) PhotoContestViewController *photoView_fromSignup;
@property(nonatomic,retain) UILabel *signupTitle;
@property(nonatomic,retain) UILabel *signupAlreadyReg;

-(IBAction)getLogin_signup:(id)sender;
-(IBAction)getSignUp_signup:(id)sender;
-(void)ShowAlertMsg:(NSString*)Msg withArg2:(NSString*)Title;


@end
