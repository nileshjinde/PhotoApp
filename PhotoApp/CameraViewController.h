//
//  CameraViewController.h
//  PhotoApp
//
//  Created by bhuvan khanna on 22/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//


#define RED       7
#define BLUE      6
#define GREEN     5
#define GRAY      0
#define SEPIA     1
#define NEGATIVE  2
#define ORIGINAL  3
#define BLUR      4

#import "FBFunViewController.h"

@class FBFunViewController;

@interface CameraViewController : UIViewController
< UIImagePickerControllerDelegate , UINavigationControllerDelegate>
{
    UIImage *image;
    IBOutlet UIButton *retakeButton;
    IBOutlet UIImageView *imageView;
    IBOutlet UIButton *uploadButton;
    IBOutlet UIScrollView *effectscroll;
    
    IBOutlet UIButton *brightnessButton;
    IBOutlet UISlider *slider;
    
    IBOutlet UIButton *backButton;
    
    BOOL blocalIsFromAlbum;
    
    IBOutlet UIButton *cropButton;
    IBOutlet UIButton *shareButton;
    IBOutlet UIButton *albumButton;
    
    
    IBOutlet FBFunViewController *fbViewController;

    
}

@property(nonatomic,retain) UIButton *retakeButton;
@property(nonatomic,retain) UIImageView *imageView;
@property(nonatomic,retain) UIButton *uploadButton;
@property(nonatomic,retain) UIScrollView *effectscroll;
@property(nonatomic,retain) UIImage *image;

@property(nonatomic,retain) UIButton *brightnessButton;
@property(nonatomic,retain) UISlider *slider;

@property(nonatomic,retain) UIButton *backButton;

@property(nonatomic,retain) UIButton *cropButton;
@property(nonatomic,retain) UIButton *shareButton;
@property(nonatomic,retain) UIButton *albumButton;

@property(nonatomic,retain) FBFunViewController *fbViewController;



-(void)setImage:(UIImage *)imgCaptured withArg2:(BOOL)bIsFromAlbum;
-(IBAction)retakePicture;
-(IBAction)uploadPhoto;

-(void)RedEffect:(UIImage *)imgCaptured;
-(void)BluEffect:(UIImage *)imgCaptured;
-(void)GreenEffect:(UIImage *)imgCaptured;
-(void)GrayEffect:(UIImage *)imgCaptured;
-(void)SepiaEffect:(UIImage *)imgCaptured;
-(void)NegativeEffect:(UIImage *)imgCaptured;
-(void)OriginalEffect:(UIImage *)imgCaptured;
-(void)BlurEffect:(UIImage *)imgCaptured;

-(IBAction)brightness;
-(IBAction)sliderDidSlide:(id)sender;
-(void)doImageStuff:(int)value;

-(IBAction)goBackToHome:(id)sender;
-(IBAction)cropAction:(id)sender;
-(IBAction)shareAction:(id)sender;


@end

    

