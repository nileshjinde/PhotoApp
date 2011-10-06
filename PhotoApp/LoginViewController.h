//
//  LoginViewController.h
//  PhotoApp
//
//  Created by bhuvan khanna on 19/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import "SignupViewController.h"
#import "RestConnectionDelegate.h"
#import "Appstatus.h"
#import "PhotoContestViewController.h"

#import "RestConnection.h"
#import "JSON.h"



@class SignupViewController;
@class RestConnection;




@interface LoginViewController : UIViewController
{
    IBOutlet UIButton *btn_login;
    IBOutlet UIButton *btn_signup;
    IBOutlet UITextField *txt_uname;
    IBOutlet UITextField *txt_pwd;  
    IBOutlet SignupViewController *signupviewcontroller;
    IBOutlet PhotoContestViewController *photoViewC_fromLogin;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UILabel *loginTitle;
    
@private 
	RestConnection *restConnection;
    Appstatus *appstatus;
    NSString *authCode;
}
@property(nonatomic,retain) UIButton *btn_login;
@property(nonatomic,retain) UIButton *btn_signup;
@property(nonatomic,retain) UITextField *txt_uname;
@property(nonatomic,retain) UITextField *txt_pwd;
@property(nonatomic,retain) SignupViewController *signupviewcontroller;
@property(nonatomic,retain) PhotoContestViewController *photoViewC_fromLogin;
@property(nonatomic,retain) UILabel *loginTitle;

-(IBAction)getLogin:(id)sender;
-(IBAction)getSignUp:(id)sender;

-(void)ShowAlertMsg:(NSString*)Msg withArg2:(NSString*)Title;
@end
