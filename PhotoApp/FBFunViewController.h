//
//  FBFunViewController.h
//  FBFun
//
//  Created by Ray Wenderlich on 7/13/10.
//  Copyright Ray Wenderlich 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FBFunViewController : UIViewController{
    
    UIImageView *_imageView;

     UIImage *image;
    IBOutlet UITextField *txt_caption;  
    
   
    UINavigationBar *navBar;

}



@property (retain) IBOutlet UIImageView *imageView;
@property(nonatomic,retain) UITextField *txt_caption;

@property (retain) IBOutlet UINavigationBar *navBar;

-(void)setImage:(UIImage *)imgCaptured;

-(IBAction)goBack:(id)sender;

-(void)sharePhotoOnFB;



@end

