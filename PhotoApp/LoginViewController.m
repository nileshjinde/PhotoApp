//
//  LoginViewController.m
//  PhotoApp
//
//  Created by bhuvan khanna on 19/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

@synthesize btn_login,btn_signup,txt_uname,txt_pwd,signupviewcontroller;
@synthesize photoViewC_fromLogin;
@synthesize loginTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    appstatus=[[Appstatus alloc]init];
    
        //-------------------//-----------------
        restConnection = [RestConnection new];
        restConnection.baseURLString = @"http://mobishare.weboapps.com";
        restConnection.delegate = self;
        activityIndicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        CGFloat width=[UIScreen mainScreen].bounds.size.width;
        CGFloat height=[UIScreen mainScreen].bounds.size.height;
        
        [activityIndicator setCenter:CGPointMake(width/2.0, height/2.0)];
        [self.view addSubview:activityIndicator];
    
    if (NO == [appstatus isAppOnline]) {
        [self ShowAlertMsg:@"No internet connectivity!" withArg2:@"Network"];
    }
   
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if(theTextField == txt_uname) {
        [txt_uname resignFirstResponder];
    }
    else if(theTextField == txt_pwd) {
        [txt_pwd resignFirstResponder];
    }
    return YES;
}
-(IBAction)getLogin:(id)sender
{
    NSString *Email=txt_uname.text;
    NSString *pwd=txt_pwd.text;
    
    
    //---------------------for get request------------------------------------------------------------------------//
	//NSString *urlString = [NSString stringWithFormat:@"/users/forgot_password?email=nilesh@weboniselab.com&phone=9764901169"];
    //[restConnection performRequestGET:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    //------------------------------------------------------------------------------------------------------------------
    
    //---------------------------------------------------for post request-------------------------------------------------------
    
    NSString *urlString = [NSString stringWithFormat:@"/users/login"];
    // NSString *postData = [[NSString alloc] initWithFormat:@"email=nilesh@weboniselab.com&password=nilesh"];
    
    NSString *postData = [[NSString alloc] initWithFormat:@"email=%@&password=%@",Email,pwd];
    
    [restConnection performRequestPOST:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] : postData];
    //----------------------------------------------------------------------------------------------------------------------
    
}
-(IBAction)getSignUp:(id)sender
{
    signupviewcontroller = [[SignupViewController alloc] init];
   // [self clearView];
        [self.view addSubview:signupviewcontroller.view];
        
}
-(void)ShowAlertMsg:(NSString*)Msg withArg2:(NSString *)Title
{
    UIAlertView *alert;
    
    alert = [[UIAlertView alloc] initWithTitle:Title
                                       message:Msg 
                                      delegate:self cancelButtonTitle:@"Ok" 
                             otherButtonTitles:nil];
    
    [alert show];
    [alert release];
    
    
}
- (void)dealloc {
	[restConnection release];
    [super dealloc];
}

//-----Rest Methods-------
- (void)willSendRequest:(NSURLRequest *)request
{
	[activityIndicator startAnimating];
}

- (void)didReceiveResponse:(NSURLResponse *)response
{
	NSLog(@"didReceiveResponse: %@", response);
}

- (void)finishedReceivingData:(NSData *)data
{
	NSLog(@"finishedReceivingData: %@", [restConnection stringData]);
	[activityIndicator stopAnimating];
	//textView.text = [restConnection stringData];
    
    NSString *jsonString = [restConnection stringData];
    NSDictionary *dictionary = [jsonString JSONValue];
    
    BOOL isDiff = [dictionary objectForKey:@"success"];
    
    @try
    {
    if(isDiff)
    {
                authCode=[dictionary objectForKey:@"auth_code"];
                NSLog(@"Login AuthCode = %@",authCode);
                [appstatus setAuthCode:authCode];
                [self ShowAlertMsg:@"Login Successful" withArg2:@"Login"];
                
                photoViewC_fromLogin = [[PhotoContestViewController alloc] init];
                // [self clearView];
                [self.view addSubview:photoViewC_fromLogin.view];
                
    }
    else
    {
        [self ShowAlertMsg:@"Login Faild!" withArg2:@"Login"];
    }
    }
    @catch(NSException *ex)
    {
        NSLog(@"Exception ****");
        [self ShowAlertMsg:@"Login Faild!" withArg2:@"Login"];
    }
    
}

//--------------------------------------------
@end
