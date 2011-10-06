//
//  AlbumViewController.h
//  PhotoApp
//
//  Created by bhuvan khanna on 22/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//

#define RED       0
#define BLUE      1
#define GREEN     2
#define GRAY      3
#define SEPIA     4
#define NEGATIVE  5
#define ORIGINAL  6
#define BLUR      7


@interface AlbumViewController : UIViewController
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
}

@property(nonatomic,retain) UIButton *retakeButton;
@property(nonatomic,retain) UIImageView *imageView;
@property(nonatomic,retain) UIButton *uploadButton;
@property(nonatomic,retain) UIScrollView *effectscroll;
@property(nonatomic,retain) UIImage *image;

@property(nonatomic,retain) UIButton *brightnessButton;
@property(nonatomic,retain) UISlider *slider;
@property(nonatomic,retain) UIButton *backButton;



-(void)setImage:(UIImage *)imgCaptured;
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

@end