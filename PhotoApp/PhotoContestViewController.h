//
//  PhotoContestViewController.h
//  PhotoContest
//
//  Created by bhuvan khanna on 14/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "Appstatus.h"
#import "AlbumViewController.h"
#import "CameraViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@class LoginViewController;
@class AlbumViewController;
@class CameraViewController;



@interface PhotoContestViewController : UIViewController
< UIImagePickerControllerDelegate , UINavigationControllerDelegate>
{
   
    IBOutlet LoginViewController *loginViewController;
   // IBOutlet AlbumViewController *albumViewController;
    IBOutlet CameraViewController *cameraViewController;
    
      
    Appstatus *appstatus;
    NSString *authCode;
    
    
    IBOutlet UIScrollView *scroll_top;
    IBOutlet UIScrollView *scroll_mid;
    IBOutlet UIScrollView *scroll_bottom;
    
    IBOutlet UIImageView *view1_top;
    IBOutlet UIImageView *view2_top;
    IBOutlet UIImageView *view3_top;
    
    IBOutlet UIImageView *view1_mid;
    IBOutlet UIImageView *view2_mid;
    IBOutlet UIImageView *view3_mid;
    
    IBOutlet UIImageView *view1_bot;
    IBOutlet UIImageView *view2_bot;
    IBOutlet UIImageView *view3_bot;
    
    int view1_topInd;
    int view2_topInd;
    int view3_topInd;
    
    int view1_midInd;
    int view2_midInd;
    int view3_midInd;
    
    int view1_botInd;
    int view2_botInd;
    int view3_botInd;


    NSMutableArray * assets;
   
    
    BOOL bIsReadDone;
    
    IBOutlet UIButton *btn_top_camera;
    
    IBOutlet UILabel *lbl_all_photos;
    
}

@property(nonatomic,retain) LoginViewController *loginViewController;
//@property(nonatomic,retain) AlbumViewController *albumViewController;
@property(nonatomic,retain) CameraViewController *cameraViewController;

@property (retain, nonatomic) UIScrollView *scroll_top;
@property (retain, nonatomic) UIScrollView *scroll_mid;
@property (retain, nonatomic) UIScrollView *scroll_bottom;

@property (retain, nonatomic) UIImageView *view1_top;
@property (retain, nonatomic) UIImageView *view2_top;
@property (retain, nonatomic) UIImageView *view3_top;

@property (retain, nonatomic) UIImageView *view1_mid;
@property (retain, nonatomic) UIImageView *view2_mid;
@property (retain, nonatomic) UIImageView *view3_mid;

@property (retain, nonatomic) UIImageView *view1_bot;
@property (retain, nonatomic) UIImageView *view2_bot;
@property (retain, nonatomic) UIImageView *view3_bot;


@property (retain, nonatomic) UIButton *btn_top_camera;
@property (retain, nonatomic) UILabel *lbl_all_photos;

-(IBAction)getCameraPicture:(id)sender;
-(IBAction)getGalleryPicture;
-(void)clearView;
-(void)ShowAlertMsg:(NSString*)Msg withArg2:(NSString*)Title;

-(void)initialize_scrolls;

- (void) update_top;
- (void) update_mid;
- (void) update_bot;

- (void) setImages;
-(void)loadLibrary;

@end