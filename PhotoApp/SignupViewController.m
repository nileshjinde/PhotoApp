//
//  SignupViewController.m
//  PhotoApp
//
//  Created by bhuvan khanna on 19/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import "SignupViewController.h"
#import "RestConnection.h"
#import "JSON.h"


@implementation SignupViewController

@synthesize btn_login_signup,btn_signup_signup,txt_email_signup,txt_compId_signup,txt_name_signup;
@synthesize loginviewcontroller,photoView_fromSignup,signupTitle,signupAlreadyReg;

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
   
    
    // Do any additional setup after loading the view from its nib.
    restConnection = [RestConnection new];
   // restConnection.baseURLString = @"http://photoappapi.weboapps.com";
     restConnection.baseURLString = @"http://192.168.1.114";
   restConnection.delegate = self;
    activityIndicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    
    [activityIndicator setCenter:CGPointMake(width/2.0, height/2.0)];
    [self.view addSubview:activityIndicator];
    
    appstatus=[[Appstatus alloc]init];
    authCode=[appstatus getAuthCode];
    NSLog(@"AuthCode = %@",authCode);

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
    if(theTextField == txt_name_signup) {
        [txt_name_signup resignFirstResponder];
    }
    else if(theTextField == txt_compId_signup) {
        [txt_compId_signup resignFirstResponder];
    }
    else if(theTextField == txt_email_signup) {
        [txt_email_signup resignFirstResponder];
    }
    
    return YES;
}

-(IBAction)getLogin_signup:(id)sender
{
    loginviewcontroller = [[LoginViewController alloc] init];
    // [self clearView];
    [self.view addSubview:loginviewcontroller.view];
}
-(IBAction)getSignUp_signup:(id)sender
{
    NSString *name=txt_name_signup.text;
   // NSLog(@"Uname =%@",name);
     NSString *Email=txt_email_signup.text;
     NSString *Name=txt_name_signup.text;
     NSString *CompId=txt_compId_signup.text;
    
     NSLog(@"Uname =%@ %@ %@",name,Email,CompId);
  
    
    //---------------------for get request------------------------------------------------------------------------//
	//NSString *urlString = [NSString stringWithFormat:@"/users/forgot_password?email=nilesh@weboniselab.com&phone=9764901169"];
    //[restConnection performRequestGET:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    //------------------------------------------------------------------------------------------------------------------
    
    //---------------------------------------------------for post request-------------------------------------------------------
    
    NSString *urlString = [NSString stringWithFormat:@"/participants/add"];
      
      //----------------------------------------------------------------------------------------------------------------------
    
    //----------------------------------------------------------------------------------------------------------
    // Store incoming data into a string
    NSString *jsonString = [NSString stringWithString:@"{\"Participant\":{\"name\":\"Nilesh jinde\",\"email\":\"nilesh@weboniselab.com\"},\"Company\":{\"id\":\"4e76ffb4-5db0-4503-bd39-17e9adcb569b\"}}"];
    
   // NSString *jsonString = [NSString stringWithString:@"{\"Participant\":[{\"name\":\"Nilesh jinde\"},{\"email\":\"nilesh@weboniselab.com\"}],\"Company\":{\"id\":\"4e76ffb4-5db0-4503-bd39-17e9adcb569b\"}}"];

    
    // Create a dictionary from the JSON string
    NSDictionary *dictionary = [jsonString JSONValue];
    
   NSLog(@"Dictionary value for \"Company\" is \"%@\"", [dictionary objectForKey:@"Company"]); 
    
    NSString *postData = [NSString stringWithFormat:@"json=%@", [dictionary JSONRepresentation], nil];
    
   // NSString *postData = [dictionary JSONRepresentation];  
    
    [restConnection performRequestPOST:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] : postData];
    //------------------------------------------------------------------------------------------------------------------

    
}
- (void)dealloc {
	[restConnection release];
    [super dealloc];
}

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
	//NSLog(@"Dictionary value for \"user\" is \"%@\"", [dictionary objectForKey:@"user"]);
    
    
    if([[dictionary objectForKey:@"success"] isEqualToString:@"200"] )
    {
         
                    
                    authCode=[dictionary objectForKey:@"access_code"];
                    NSLog(@"SignUp AuthCode = %@",authCode);
                   
        // [appstatus setAuthCode:authCode];
                    [self ShowAlertMsg:@"SignUp Successful" withArg2:@"Signup"];
                    
                  /*  photoView_fromSignup = [[PhotoContestViewController alloc] init];
                    // [self clearView];
                    [self.view addSubview:photoView_fromSignup.view];*/

              
    }
    if([[dictionary objectForKey:@"user"] isEqualToString:@"exists"] )
    {
        if([[dictionary objectForKey:@"status"] isEqualToString:@"duplicate"] )
        {
            [self ShowAlertMsg:@"User Exists!" withArg2:@"Signup"];
        }
    }
    else
    {
        [self ShowAlertMsg:@"SignUp Faild!" withArg2:@"Signup"];
    }
    
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

@end
