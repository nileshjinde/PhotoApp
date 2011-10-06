//
//  PhotoContestViewController.m
//  PhotoContest
//
//  Created by bhuvan khanna on 14/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import "PhotoContestViewController.h"



@implementation PhotoContestViewController

@synthesize loginViewController,cameraViewController;

@synthesize scroll_top,scroll_mid,scroll_bottom;
@synthesize view1_top,view2_top,view3_top,btn_top_camera;
@synthesize view1_mid,view2_mid,view3_mid,view1_bot,view2_bot,view3_bot,lbl_all_photos;

//@synthesize albumViewController;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
      
    appstatus=[[Appstatus alloc]init];
    authCode=[appstatus getAuthCode];
   
    
    //if(authCode)
      //  NSLog(@"Home AuthCode = %@",authCode);
    if (NO == [appstatus isAppOnline]) {
        [self ShowAlertMsg:@"No internet connectivity!" withArg2:@"Network"];
    }
   
   /* if([appstatus isAppRegistered] == NO)
    {
         NSLog(@"You are not registered!");
        NSLog(@"loadLoginView");
        [self ShowAlertMsg:@"You are not registered!" withArg2:@"Login"];
        
        loginViewController = [[LoginViewController alloc] init];
        // [self clearView];
        [self.view addSubview:loginViewController.view];

    }
    else
    {
        NSLog(@"You are registered");
        [self ShowAlertMsg:@"You are registered!" withArg2:@"Login"];
        
    
       
    }*/
    
    [self initialize_scrolls];
    [self loadLibrary];
    
    
    
     [super viewDidLoad];
    
    
    
}
-(void)loadLibrary
{
  //  btn_top_camera.backgroundColor=[UIColor blueColor];
    
   // assets= [[NSMutableArray alloc] init];
    
    
    bIsReadDone=NO;
    
    void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result != NULL) {
            //   NSLog(@"See Asset: %@", result);
            [assets addObject:result];
            
        }
    };
    
    void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) =  ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [group enumerateAssetsUsingBlock:assetEnumerator];
        }
        
        if(bIsReadDone == NO)
        {
            NSLog(@"Count photo_gl: %u", [assets count]);
            [self setImages];
            bIsReadDone=YES;
            NSString *strlbl=[NSString stringWithFormat:@"%d Photos for todays contest", [assets count]];

            lbl_all_photos.text=strlbl;
            
        }
        
    };
    
    
    
    assets = [[NSMutableArray alloc] init];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    //[library enumerateGroupsWithTypes:ALAssetsGroupAlbum
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:assetGroupEnumerator
                         failureBlock: ^(NSError *error) {
                             NSLog(@"Failure");
                         }];
    
 
    
}
-(void)initialize_scrolls
{
     //----------------scroll1----------------------------
    scroll_top.scrollEnabled = YES;
    scroll_top.pagingEnabled = YES;
    scroll_top.directionalLockEnabled = YES;
    scroll_top.showsVerticalScrollIndicator = NO;
    scroll_top.showsHorizontalScrollIndicator = NO;
    scroll_top.delegate =self ;
    // scroll1.backgroundColor = [UIColor blueColor];
    scroll_top.autoresizesSubviews = YES;
    
    view1_top = [[UIImageView alloc] init];
    [scroll_top addSubview:view1_top];
    
    view2_top = [[UIImageView alloc] init];
    [scroll_top addSubview:view2_top];
    
    view3_top = [[UIImageView alloc] init];
    [scroll_top addSubview:view3_top];

    view1_topInd=0;
    view2_topInd=1;
    view3_topInd=2;
    
    //----------------scroll2----------------------------
    scroll_mid.scrollEnabled = YES;
    scroll_mid.pagingEnabled = YES;
    scroll_mid.directionalLockEnabled = YES;
    scroll_mid.showsVerticalScrollIndicator = NO;
    scroll_mid.showsHorizontalScrollIndicator = NO;
    scroll_mid.delegate =self ;
    // scroll1.backgroundColor = [UIColor blueColor];
    scroll_mid.autoresizesSubviews = YES;
    
    view1_mid = [[UIImageView alloc] init];
    [scroll_mid addSubview:view1_mid];
    
    view2_mid = [[UIImageView alloc] init];
    [scroll_mid addSubview:view2_mid];
    
    view3_mid = [[UIImageView alloc] init];
    [scroll_mid addSubview:view3_mid];
    
    view1_midInd=0;
    view2_midInd=1;
    view3_midInd=2;
    
     //----------------scroll3----------------------------
    scroll_bottom.scrollEnabled = YES;
    scroll_bottom.pagingEnabled = YES;
    scroll_bottom.directionalLockEnabled = YES;
    scroll_bottom.showsVerticalScrollIndicator = NO;
    scroll_bottom.showsHorizontalScrollIndicator = NO;
    scroll_bottom.delegate =self ;
    // scroll1.backgroundColor = [UIColor blueColor];
    scroll_bottom.autoresizesSubviews = YES;
    
    view1_bot = [[UIImageView alloc] init];
    [scroll_bottom addSubview:view1_bot];
    
    view2_bot = [[UIImageView alloc] init];
    [scroll_bottom addSubview:view2_bot];
    
    view3_bot = [[UIImageView alloc] init];
    [scroll_bottom addSubview:view3_bot];
    
    view1_botInd=0;
    view2_botInd=1;
    view3_botInd=2;
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


- (void)viewDidUnload
{
    //[originalImage release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)getCameraPicture:(id)sender
{
    /*cameraViewController=[[CameraViewController alloc]init];
    NSLog(@"loadcameraView");
    //[self clearView];
    [self.view addSubview:cameraViewController.view];
    //[self.view insertSubview:cameraViewController.view atIndex:1];*/

    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsImageEditing = YES;
    // picker.sourceType = (sender == takePictureButton) ?    UIImagePickerControllerSourceTypeCamera :UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } 
    else
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    
    // picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController: picker animated:YES];
    [picker release];
    NSLog(@"InCamera");


   
}


-(void) clearView {
    if (cameraViewController.view.superview) {
        [cameraViewController.view removeFromSuperview];
    }
     else 
     {
       //[albumViewController.view removeFromSuperview];
     }
}
-(IBAction)getGalleryPicture
{
       
    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc]init];
        picker.delegate = self;
        
          picker.allowsImageEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentModalViewController:picker animated:YES];
        [picker release];
        NSLog(@"InAlbum");
    }
    
      

}
-(void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingImage : (UIImage *)image
                 editingInfo:(NSDictionary *)editingInfo
{
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
        
      
        [picker dismissModalViewControllerAnimated:YES];
               
       // albumViewController=[[AlbumViewController alloc]init];
        //[albumViewController setImage:image];
          // [self.view addSubview:albumViewController.view];

        NSLog(@"loadalbumView");

      
         //[self.view insertSubview:albumViewController.view atIndex:0];
        
        cameraViewController=[[CameraViewController alloc]init];
        [cameraViewController setImage:image withArg2:YES];
        
        [self.view addSubview:cameraViewController.view];
       // [self.view insertSubview:cameraViewController.view atIndex:2];
        
    }
    else {
        // Access the uncropped image from info dictionary
      //  UIImage *image1 = [editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        // Save image
       // UIImageWriteToSavedPhotosAlbum(image1, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
       
        [picker dismissModalViewControllerAnimated:YES];
        
        cameraViewController=[[CameraViewController alloc]init];
        [cameraViewController setImage:image withArg2:NO];
        
        NSLog(@"loadCameraView");
          [self.view addSubview:cameraViewController.view];
        //[self.view insertSubview:albumViewController.view atIndex:0];
        
    }
    // [effectscroll setHidden:FALSE];
    //[self dismissModalViewControllerAnimated:YES];
    
}


-(void)viewWillAppear:(BOOL)animated
{
     NSLog(@"loadalbumViewAfter");
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert;
    
    // Unable to save the image  
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                           message:@"Unable to save image to Photo Album." 
                                          delegate:self cancelButtonTitle:@"Ok" 
                                 otherButtonTitles:nil];
    else // All is well
        alert = [[UIAlertView alloc] initWithTitle:@"Success" 
                                           message:@"Image saved to Photo Album." 
                                          delegate:self cancelButtonTitle:@"Ok" 
                                 otherButtonTitles:nil];
    [alert show];
    [alert release];
    
}


-(void)dealloc
{
    [appstatus release];
    [loginViewController release];
    [cameraViewController release];
  //  [albumViewController release];
    

    [assets release];
    
    [view1_top release];
    [view2_top release];
    [view3_top release];
    
    [view1_mid release];
    [view2_mid release];
    [view3_mid release];
    
    [view1_bot release];
    [view2_bot release];
    [view3_bot release];
    [super dealloc];
}
//----------------------------------------------------------
- (void) updateCount {
    NSLog(@"Count photo: %u", [assets count]);
    
}
- (void) scrollViewDidScroll:(UIScrollView *) scrollView
{	
    if (scrollView == scroll_top) {
        [self update_top];
    }
    else if (scrollView == scroll_mid) {
        [self update_mid];
    }
    else if (scrollView == scroll_bottom) {
        [self update_bot];
    }
    // NSLog(@"scrollViewDidScroll");
}
- (void) setImages
{
    
    NSLog(@"HiHello %u",[assets count]);
    
	    
    view1_top.frame = CGRectMake(0, 0, 105, 100);  // x y width height 320 100
    view2_top.frame = CGRectMake(107, 0, 105, 100);
    view3_top.frame = CGRectMake(214, 0, 105, 100);
    
    view1_mid.frame = CGRectMake(0, 0, 105, 100);  // x y width height 320 100
    view2_mid.frame = CGRectMake(107, 0, 105, 100);
    view3_mid.frame = CGRectMake(214, 0, 105, 100);

    view1_bot.frame = CGRectMake(0, 0, 105, 100);  // x y width height 320 100
    view2_bot.frame = CGRectMake(107, 0, 105, 100);
    view3_bot.frame = CGRectMake(214, 0, 105, 100);

    
  	ALAsset *asset1 = [assets objectAtIndex:0];
    ALAsset *asset2 = [assets objectAtIndex:1];
    ALAsset *asset3 = [assets objectAtIndex:2];
    
    
	view1_top.image = [UIImage imageWithCGImage:[asset1 thumbnail]];
	view2_top.image = [UIImage imageWithCGImage:[asset2 thumbnail]];
    view3_top.image = [UIImage imageWithCGImage:[asset3 thumbnail]];
    
    view1_mid.image = [UIImage imageWithCGImage:[asset1 thumbnail]];
	view2_mid.image = [UIImage imageWithCGImage:[asset2 thumbnail]];
    view3_mid.image = [UIImage imageWithCGImage:[asset3 thumbnail]];
    
    view1_bot.image = [UIImage imageWithCGImage:[asset1 thumbnail]];
	view2_bot.image = [UIImage imageWithCGImage:[asset2 thumbnail]];
    view3_bot.image = [UIImage imageWithCGImage:[asset3 thumbnail]];
	
	
    scroll_top.contentSize = CGSizeMake(([assets count]*107)+([assets count]-1), 100);
    scroll_mid.contentSize = CGSizeMake(([assets count]*107)+([assets count]-1), 100);
    scroll_bottom.contentSize = CGSizeMake(([assets count]*107)+([assets count]-1), 100);
}
- (void) update_top
{
    CGFloat pageWidth = 105;
    
	float currPos = scroll_top.contentOffset.x;
	
	int selectedPage = roundf(currPos / pageWidth);
	
	//float truePosition = selectedPage*pageWidth;
	
	int zone = selectedPage % 3;
	
	//BOOL view1Active = zone == 0;
    
    UIImageView *nextView,*nextToNextView,*curView;
    
    if(zone == 0) // 0
    {
        curView=view1_top;
        nextView=view2_top;
        nextToNextView=view3_top;
    }
    else if(zone == 1) // 1
    {
        curView=view2_top;
        nextView=view3_top;
        nextToNextView=view1_top;
    }
    else // 2
    {
        curView=view3_top;
        nextView=view1_top;
        nextToNextView=view2_top;
    }
	
	//UIImageView *nextView = view1Active ? view2 : view1;
	
	//int nextpage = truePosition > currPos ? selectedPage-1 : selectedPage+1;
    int nextpage=selectedPage+1;
    int nextTonextpage=nextpage+1;
	
	if(selectedPage >= 0 && nextTonextpage < [assets count])
	{
        //  if( ((zone == 0) && (nextpage == view1Index)) || ((zone == 1) && (nextpage == view2Index)) || ((zone==2) && (nextpage==view3Index)) )
        //    return;
        
        curView.frame = CGRectMake(selectedPage*107, 0, 105, 100);
        nextView.frame = CGRectMake(nextpage*107, 0, 105, 100);
        nextToNextView.frame = CGRectMake(nextTonextpage*107, 0, 105, 100);
        
        ALAsset *asset_im_cur = [assets objectAtIndex:selectedPage];  
        ALAsset *asset_im1 = [assets objectAtIndex:nextpage];
        ALAsset *asset_im2 = [assets objectAtIndex:nextTonextpage];
        
        curView.image = [UIImage imageWithCGImage:[asset_im_cur thumbnail]];
        nextView.image = [UIImage imageWithCGImage:[asset_im1 thumbnail]];
        nextToNextView.image = [UIImage imageWithCGImage:[asset_im2 thumbnail]];
        
        if(zone == 0) // 0
        {
            view1_topInd=nextpage;
            view2_topInd=nextTonextpage;
            view3_topInd=nextTonextpage+1;
        }
        else if(zone == 1) // 1
        {
            view2_topInd=nextpage;
            view3_topInd=nextTonextpage;
            view1_topInd=nextTonextpage+1;       
        }
        else // 2
        {
            view3_topInd=nextpage;
            view1_topInd=nextTonextpage;
            view2_topInd=nextTonextpage+1;
        }
		
	}
}
- (void) update_mid
{
    CGFloat pageWidth = 105;
    
	float currPos = scroll_mid.contentOffset.x;
	
	int selectedPage = roundf(currPos / pageWidth);
	
	//float truePosition = selectedPage*pageWidth;
	
	int zone = selectedPage % 3;
	
	//BOOL view1Active = zone == 0;
    
    UIImageView *nextView,*nextToNextView,*curView;
    
    if(zone == 0) // 0
    {
        curView=view1_mid;
        nextView=view2_mid;
        nextToNextView=view3_mid;
    }
    else if(zone == 1) // 1
    {
        curView=view2_mid;
        nextView=view3_mid;
        nextToNextView=view1_mid;
    }
    else // 2
    {
        curView=view3_mid;
        nextView=view1_mid;
        nextToNextView=view2_mid;
    }
	
	//UIImageView *nextView = view1Active ? view2 : view1;
	
	//int nextpage = truePosition > currPos ? selectedPage-1 : selectedPage+1;
    int nextpage=selectedPage+1;
    int nextTonextpage=nextpage+1;
	
	if(selectedPage >= 0 && nextTonextpage < [assets count])
	{
        //  if( ((zone == 0) && (nextpage == view1Index)) || ((zone == 1) && (nextpage == view2Index)) || ((zone==2) && (nextpage==view3Index)) )
        //    return;
        
        curView.frame = CGRectMake(selectedPage*107, 0, 105, 100);
        nextView.frame = CGRectMake(nextpage*107, 0, 105, 100);
        nextToNextView.frame = CGRectMake(nextTonextpage*107, 0, 105, 100);
        
        ALAsset *asset_im_cur = [assets objectAtIndex:selectedPage];  
        ALAsset *asset_im1 = [assets objectAtIndex:nextpage];
        ALAsset *asset_im2 = [assets objectAtIndex:nextTonextpage];
        
        curView.image = [UIImage imageWithCGImage:[asset_im_cur thumbnail]];
        nextView.image = [UIImage imageWithCGImage:[asset_im1 thumbnail]];
        nextToNextView.image = [UIImage imageWithCGImage:[asset_im2 thumbnail]];
        
        if(zone == 0) // 0
        {
            view1_midInd=nextpage;
            view2_midInd=nextTonextpage;
            view3_midInd=nextTonextpage+1;
        }
        else if(zone == 1) // 1
        {
            view2_midInd=nextpage;
            view3_midInd=nextTonextpage;
            view1_midInd=nextTonextpage+1;       
        }
        else // 2
        {
            view3_midInd=nextpage;
            view1_midInd=nextTonextpage;
            view2_midInd=nextTonextpage+1;
        }
		
	}
}

- (void) update_bot
{
    CGFloat pageWidth = 105;
    
	float currPos = scroll_bottom.contentOffset.x;
	
	int selectedPage = roundf(currPos / pageWidth);
	
	//float truePosition = selectedPage*pageWidth;
	
	int zone = selectedPage % 3;
	
	//BOOL view1Active = zone == 0;
    
    UIImageView *nextView,*nextToNextView,*curView;
    
    if(zone == 0) // 0
    {
        curView=view1_bot;
        nextView=view2_bot;
        nextToNextView=view3_bot;
    }
    else if(zone == 1) // 1
    {
        curView=view2_bot;
        nextView=view3_bot;
        nextToNextView=view1_bot;
    }
    else // 2
    {
        curView=view3_bot;
        nextView=view1_bot;
        nextToNextView=view2_bot;
    }
	
	//UIImageView *nextView = view1Active ? view2 : view1;
	
	//int nextpage = truePosition > currPos ? selectedPage-1 : selectedPage+1;
    int nextpage=selectedPage+1;
    int nextTonextpage=nextpage+1;
	
	if(selectedPage >= 0 && nextTonextpage < [assets count])
	{
        //  if( ((zone == 0) && (nextpage == view1Index)) || ((zone == 1) && (nextpage == view2Index)) || ((zone==2) && (nextpage==view3Index)) )
        //    return;
        
        curView.frame = CGRectMake(selectedPage*107, 0, 105, 100);
        nextView.frame = CGRectMake(nextpage*107, 0, 105, 100);
        nextToNextView.frame = CGRectMake(nextTonextpage*107, 0, 105, 100);
        
        ALAsset *asset_im_cur = [assets objectAtIndex:selectedPage];  
        ALAsset *asset_im1 = [assets objectAtIndex:nextpage];
        ALAsset *asset_im2 = [assets objectAtIndex:nextTonextpage];
        
        curView.image = [UIImage imageWithCGImage:[asset_im_cur thumbnail]];
        nextView.image = [UIImage imageWithCGImage:[asset_im1 thumbnail]];
        nextToNextView.image = [UIImage imageWithCGImage:[asset_im2 thumbnail]];
        
        if(zone == 0) // 0
        {
            view1_botInd=nextpage;
            view2_botInd=nextTonextpage;
            view3_botInd=nextTonextpage+1;
        }
        else if(zone == 1) // 1
        {
            view2_botInd=nextpage;
            view3_botInd=nextTonextpage;
            view1_botInd=nextTonextpage+1;       
        }
        else // 2
        {
            view3_botInd=nextpage;
            view1_botInd=nextTonextpage;
            view2_botInd=nextTonextpage+1;
        }
		
	}
}



@end
