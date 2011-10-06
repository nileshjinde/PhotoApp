//
//  FBFunViewController.m
//  FBFun
//
//  Created by Ray Wenderlich on 7/13/10.
//  Copyright Ray Wenderlich 2010. All rights reserved.
//

#import "FBFunViewController.h"

#import "SHK.h"
#import "SHKActionSheet.h"


@implementation FBFunViewController

@synthesize imageView = _imageView;
@synthesize txt_caption=_txt_caption;

@synthesize navBar=_navBar;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
		self.toolbarItems = [NSArray arrayWithObjects:
							 [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
							 [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sharePhotoOnFB)] autorelease],
							 [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
							 nil
							 ];
	}
	
	return self;
}

#pragma mark Main

-(void)setImage:(UIImage *)imgCaptured
{
    image=imgCaptured;
   
}

- (void)dealloc {
    
    self.imageView = nil;
    
    self.navBar=nil;
    [super dealloc];
}

- (void)viewDidLoad
{
  _imageView.image=image;
     [_txt_caption becomeFirstResponder];
}


- (void)sharePhotoOnFB
{
    
    
    NSString *str=_txt_caption.text;
    
    if([str length] == 0)
    {
        str=@"PhotoApp";
    }
    
   // NSLog(@"hjhgj %@",str);
    
    
    
    SHKItem *item = [SHKItem image:_imageView.image title:str];
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    
    
	
	[actionSheet showFromToolbar:_navBar];
}

-(IBAction)goBack:(id)sender
{
    [self.view removeFromSuperview];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if(theTextField == _txt_caption) {
        [_txt_caption resignFirstResponder];
        [self sharePhotoOnFB];
        }
    return YES;
}


@end
