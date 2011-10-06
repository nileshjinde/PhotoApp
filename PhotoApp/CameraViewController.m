//
//  CameraViewController.m
//  PhotoApp
//
//  Created by bhuvan khanna on 22/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import "CameraViewController.h"

@implementation CameraViewController
@synthesize uploadButton,retakeButton,imageView,effectscroll,image;
@synthesize brightnessButton,slider,cropButton,shareButton,albumButton;

@synthesize fbViewController;


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
    imageView.image=image;
    
    NSArray * thumbs_images = [[NSArray alloc] initWithObjects:@"gray.jpg",@"sepia.jpg",@"negative.jpg",@"org.jpg",@"blur.jpg",@"green.jpg",@"blue.jpg",@"red.jpg",nil];
    
    // Do any additional setup after loading the view from its nib.
    
    //-----------Adding effects scrollView------
    effectscroll.scrollEnabled = YES;
    effectscroll.pagingEnabled = YES;
    effectscroll.directionalLockEnabled = YES;
    effectscroll.showsVerticalScrollIndicator = NO;
    effectscroll.showsHorizontalScrollIndicator = NO;
    effectscroll.delegate =self ;
    // effectscroll.backgroundColor = [UIColor blueColor];
    effectscroll.autoresizesSubviews = YES;
    
    // [effectscroll setHidden:true];
    
    for(int i = 0; i <8; ++i) {
        
      //  UIImage *thumb = [thumbs_images objectAtIndex:0];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        
        button.frame = CGRectMake(i*78, 0, 75, 40);       // 300 44
        
        [button setImage:[UIImage imageNamed:[thumbs_images objectAtIndex:i]] forState:UIControlStateNormal];
        
       // [button setImage:thumb forState:UIControlStateNormal];
        
        [button addTarget:self 
                   action:@selector(buttonClicked:) 
         forControlEvents:UIControlEventTouchUpInside];
        button.tag = i; 
        
        
        switch (i) {
            case RED:
                [button setTitle:@"Red" forState:UIControlStateNormal];
                break;
            case BLUE:
                [button setTitle:@"Blue" forState:UIControlStateNormal];
                break;
            case GREEN:
                [button setTitle:@"Green" forState:UIControlStateNormal];
                break;
            case GRAY:
                [button setTitle:@"Gray" forState:UIControlStateNormal];           
                break;
            case SEPIA:
                [button setTitle:@"Sepia" forState:UIControlStateNormal];
                break;
            case NEGATIVE:
                [button setTitle:@"Negative" forState:UIControlStateNormal];
                break;
            case ORIGINAL:
                [button setTitle:@"Original" forState:UIControlStateNormal];
                break;
            case BLUR:
                [button setTitle:@"Blur" forState:UIControlStateNormal];
                break;
        }
        
        
        [effectscroll addSubview:button];
        
        
        
    }
    [thumbs_images release];
    [effectscroll setContentSize:CGSizeMake(600,44)];	
    
    
    //------------slider-----
    // slider=[[UISlider alloc] initWithFrame:CGRectMake(50, 300, 200, 30)];
    
    //[slider setMinimumValue:-255];
    //[slider setMaximumValue:255];
    //[slider setValue:50];
    
    [slider setMinimumValue:-100];
    [slider setMaximumValue:100];
    [slider setValue:0];
    
    
    
    
    if (blocalIsFromAlbum == YES) {
       
        [retakeButton setHidden:YES];
        
       
    }
    
    
    
    [slider setHidden:YES];
    //[brightnessButton setHidden:YES];
    //------------------------------
    
   // [super viewDidLoad];
    
    //---------------------------------------------
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
- (void) scrollViewDidScroll:(UIScrollView *) scrollView
{	
	//[self update];
    // NSLog(@"scrollViewDidScroll");
}
-(void)setImage:(UIImage *)imgCaptured withArg2:(BOOL)bIsFromAlbum
{
    image=imgCaptured;
    blocalIsFromAlbum=bIsFromAlbum;
    
}

-(void)retakePicture
{
   // [slider setHidden:NO];
    //[brightnessButton setHidden:NO];
     brightnessButton.enabled=YES;
    
   
    
    if (blocalIsFromAlbum == YES) {
        
        [retakeButton setHidden:YES];
                 
    }

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
    NSLog(@"InRetakeCamera");

    
}
-(void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingImage : (UIImage *)image1
                 editingInfo:(NSDictionary *)editingInfo
{
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
        
        
        [picker dismissModalViewControllerAnimated:YES];
        
        imageView.image=image1;       
           image=image1;
        
        
    }
    else {
        // Access the uncropped image from info dictionary
      //  UIImage *image2 = [editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        // Save image
       // UIImageWriteToSavedPhotosAlbum(image1, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
        [picker dismissModalViewControllerAnimated:YES];
        
         imageView.image=image1;    
           image=image1;
        
    }
    // [effectscroll setHidden:FALSE];
    [self dismissModalViewControllerAnimated:YES];
        
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


-(void)uploadPhoto
{
    
}
- (IBAction)buttonClicked:(id)sender {
	UIButton *button = (UIButton *)sender;
	//self.selectedImage = [_images objectAtIndex:button.tag];
    // NSLog(@"Button id = %u",button.tag);
    NSInteger iTag=button.tag;
    
    [image retain];
    
    CGImageRef cgImage=[image CGImage];
    UIImage *copyImage=[[UIImage alloc] initWithCGImage:cgImage];
    
    [slider setHidden:YES];
    //[brightnessButton setHidden:YES];
    
     UIImage *buttonImage = [UIImage imageNamed:@"PC_brightness_over.png"];
    //[brightnessButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
   
    brightnessButton.enabled=NO;
       
    switch (iTag) {
        case RED:
            [self RedEffect:copyImage];
            break;
        case BLUE:
            [self BluEffect:copyImage];
            break;
        case GREEN:
            [self GreenEffect:copyImage];
            break;
        case GRAY:
            [self GrayEffect:copyImage];
            break;
        case SEPIA:
            [self SepiaEffect:copyImage];
            break;
        case NEGATIVE:
            [self NegativeEffect:copyImage];
            break;
        case ORIGINAL:
            [self OriginalEffect:copyImage];
            break;
        case BLUR:
            [self BlurEffect:copyImage];
            break;
        default:
            break;
    }
    [copyImage release];	
    
  
}
//-----------------Effects----------------------------------------
-(void)RedEffect:(UIImage *)imgCaptured
{
    
    CGImageRef sourceImage = imgCaptured.CGImage;
    
    CFDataRef theData;
    theData = CGDataProviderCopyData(CGImageGetDataProvider(sourceImage));
    
    UInt8 *pixelData = (UInt8 *) CFDataGetBytePtr(theData);
    
    int dataLength = CFDataGetLength(theData);
    
    int red = 1;
    int green = 0;
    int blue = 2;
    
    int iVal=128;
    
    for (int index = 0; index < dataLength; index += 4) {
        if (pixelData[index + green] - iVal > 0) {
            pixelData[index + red] = pixelData[index + green] - iVal;
            pixelData[index + blue] = pixelData[index + green] - iVal;
        } else {
            pixelData[index + red] = 0;
            pixelData[index + blue] = 0;
        }
    }
    
    CGContextRef context;
    context = CGBitmapContextCreate(pixelData,
                                    CGImageGetWidth(sourceImage),
                                    CGImageGetHeight(sourceImage),
                                    8,
                                    CGImageGetBytesPerRow(sourceImage),
                                    CGImageGetColorSpace(sourceImage),
                                    kCGImageAlphaPremultipliedLast);
    
    
    
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newCGImage];
    
    CGContextRelease(context);
    CFRelease(theData);
    CGImageRelease(newCGImage);
    
    
    imageView.image = newImage;
    
    //[image release];
    
}

-(void)BluEffect:(UIImage *)imgCaptured
{
    //  [originalImage retain];
    CGImageRef sourceImage = imgCaptured.CGImage;
    
    CFDataRef theData;
    theData = CGDataProviderCopyData(CGImageGetDataProvider(sourceImage));
    
    UInt8 *pixelData = (UInt8 *) CFDataGetBytePtr(theData);
    
    int dataLength = CFDataGetLength(theData);
    
    int red = 0;
    int green = 2;
    int blue = 1;
    
    for (int index = 0; index < dataLength; index += 4) {
        if (pixelData[index + green] - 128 > 0) {
            pixelData[index + red] = pixelData[index + green] - 128;
            pixelData[index + blue] = pixelData[index + green] - 128;
        } else {
            pixelData[index + red] = 0;
            pixelData[index + blue] = 0;
        }
    }
    
    CGContextRef context;
    context = CGBitmapContextCreate(pixelData,
                                    CGImageGetWidth(sourceImage),
                                    CGImageGetHeight(sourceImage),
                                    8,
                                    CGImageGetBytesPerRow(sourceImage),
                                    CGImageGetColorSpace(sourceImage),
                                    kCGImageAlphaPremultipliedLast);
    
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newCGImage];
    
    CGContextRelease(context);
    CFRelease(theData);
    CGImageRelease(newCGImage);
    
    imageView.image = newImage;
  //  [image release];
}
-(void)GreenEffect:(UIImage *)imgCaptured
{
    CGImageRef sourceImage = imgCaptured.CGImage;
    
    CFDataRef theData;
    theData = CGDataProviderCopyData(CGImageGetDataProvider(sourceImage));
    
    UInt8 *pixelData = (UInt8 *) CFDataGetBytePtr(theData);
    
    int dataLength = CFDataGetLength(theData);
    
    int red = 2;
    int green = 1;
    int blue = 0;
    
    for (int index = 0; index < dataLength; index += 4) {
        if (pixelData[index + green] - 128 > 0) {
            pixelData[index + red] = pixelData[index + green] - 128;
            pixelData[index + blue] = pixelData[index + green] - 128;
        } else {
            pixelData[index + red] = 0;
            pixelData[index + blue] = 0;
        }
    }
    
    CGContextRef context;
    context = CGBitmapContextCreate(pixelData,
                                    CGImageGetWidth(sourceImage),
                                    CGImageGetHeight(sourceImage),
                                    8,
                                    CGImageGetBytesPerRow(sourceImage),
                                    CGImageGetColorSpace(sourceImage),
                                    kCGImageAlphaPremultipliedLast);
    
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newCGImage];
    
    CGContextRelease(context);
    CFRelease(theData);
    CGImageRelease(newCGImage);
    
    imageView.image = newImage;
    
  //  [image release];
    
}
-(void)SepiaEffect:(UIImage *)imgCaptured
{
    CGImageRef orgImage = imgCaptured.CGImage;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL,
                                                       CGImageGetWidth(orgImage),
                                                       CGImageGetHeight(orgImage ),
                                                       8,
                                                       CGImageGetWidth(orgImage )*4,
                                                       colorSpace,
                                                       kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(bitmapContext, CGRectMake(0, 0, CGBitmapContextGetWidth(bitmapContext), CGBitmapContextGetHeight(bitmapContext)), orgImage );
    UInt8 *data = CGBitmapContextGetData(bitmapContext);
    int numComponents = 4;
    int bytesInContext = CGBitmapContextGetHeight(bitmapContext) * CGBitmapContextGetBytesPerRow(bitmapContext);
    
    int redIn, greenIn, blueIn, redOut, greenOut, blueOut;
    
    for (int i = 0; i < bytesInContext; i += numComponents) {
        
        redIn = data[i];
        greenIn = data[i+1];
        blueIn = data[i+2];
        
        redOut = (int)(redIn * .393) + (greenIn *.769) + (blueIn * .189);
        greenOut = (int)(redIn * .349) + (greenIn *.686) + (blueIn * .168);
        blueOut = (int)(redIn * .272) + (greenIn *.534) + (blueIn * .131);		
        
        if (redOut>255) redOut = 255;
        if (blueOut>255) blueOut = 255;
        if (greenOut>255) greenOut = 255;
        
        data[i] = (redOut);
        data[i+1] = (greenOut);
        data[i+2] = (blueOut);
    }
    
    CGImageRef outImage = CGBitmapContextCreateImage(bitmapContext);
    UIImage *uiImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    imageView.image=uiImage;
    
   // [image release];
    
}
-(void)GrayEffect:(UIImage *)imgCaptured
{
    CGContextRef ctx; 
    CGImageRef imageRef = imgCaptured.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
												 bitsPerComponent, bytesPerRow, colorSpace,
												 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
	
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
	
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * 0) + 0 * bytesPerPixel;
    for (int ii = 0 ; ii < width * height ; ++ii)
    {
        // Get color values to construct a UIColor
        //		  CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
        //        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        //        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        //        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
		
		int outputColor = (rawData[byteIndex] + rawData[byteIndex+1] + rawData[byteIndex+2]) / 3;
		
		rawData[byteIndex] = (char) (outputColor);
		rawData[byteIndex+1] = (char) (outputColor);
		rawData[byteIndex+2] = (char) (outputColor);
		
        byteIndex += 4;
    }
	
	ctx = CGBitmapContextCreate(rawData,  
								CGImageGetWidth( imageRef ),  
								CGImageGetHeight( imageRef ),  
								8,  
								CGImageGetBytesPerRow( imageRef ),  
								CGImageGetColorSpace( imageRef ),  
								kCGImageAlphaPremultipliedLast ); 
	
	imageRef = CGBitmapContextCreateImage (ctx);  
	UIImage* rawImage = [UIImage imageWithCGImage:imageRef];  
	
	CGContextRelease(ctx);  
	
	imageView.image=rawImage;
	
	free(rawData);
   // [image release];
}
-(void)NegativeEffect:(UIImage *)imgCaptured
{
    UIImage *img=imgCaptured;
    UIGraphicsBeginImageContext(img.size);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeDifference);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(),[UIColor whiteColor].CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, img.size.width, img.size.height));
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageView.image=img;
   // [image release];
    
}
-(void)OriginalEffect:(UIImage *)imgCaptured
{
    imageView.image=imgCaptured;
    
   // [slider setHidden:NO];
    //[brightnessButton setHidden:NO];
     brightnessButton.enabled=YES;
}
-(void)BlurEffect:(UIImage *)imgCaptured
{
    UIImage *img=imgCaptured;
    
    CGRect             bnds = CGRectZero;
    UIImage*           copy = nil;
    CGContextRef       ctxt = nil;
    CGImageRef         imag = img.CGImage;
    CGRect             rect = CGRectZero;
    CGAffineTransform  tran = CGAffineTransformIdentity;
    int                indx = 0;
    
    rect.size.width  = CGImageGetWidth(imag);
    rect.size.height = CGImageGetHeight(imag);
    
    bnds = rect;
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    // Cut out a sample out the image
    //  CGRect fillRect = CGRectMake(point.x - 10, point.y - 10, 20, 20);
    CGRect fillRect = CGRectMake(0, 0,img.size.width,img.size.height);
    
    CGImageRef sampleImageRef = CGImageCreateWithImageInRect(img.CGImage, fillRect);
    
    // Flip the image right side up & draw
    CGContextSaveGState(ctxt);
    
    CGContextScaleCTM(ctxt, 1.0, -1.0);
    CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
    CGContextConcatCTM(ctxt, tran);
    
    //CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, imag);
    
    // Restore the context so that the coordinate system is restored
    // CGContextRestoreGState(ctxt);
    
    // Cut out a sample image and redraw it over the source rect
    // several times, shifting the opacity and the positioning slightly
    // to produce a blurred effect
    for (indx = 0; indx < 5; indx++) {
        CGRect myRect = CGRectOffset(fillRect, 0.5 * indx, 0.5 * indx);
        CGContextSetAlpha(ctxt, 0.2 * indx);
        CGContextScaleCTM(ctxt, 1.0, -1.0);
        CGContextDrawImage(ctxt, myRect, sampleImageRef);
    }
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    imageView.image=copy;
    
   // [image release];
    
}
-(IBAction)brightness
{
    [slider setHidden:NO];
    NSLog(@"InBrightness");
}
-(void)sliderDidSlide:(id)sender{
    [image retain];
	[self doImageStuff:slider.value];
}

-(void)doImageStuff:(int)value{
    
	CGImageRef img=image.CGImage;
    
    
    
    
    CFDataRef dataref;
    dataref = CGDataProviderCopyData(CGImageGetDataProvider(img));
    
	//CFDataRef dataref=CopyImagePixels(img);
	UInt8 *data=(UInt8 *)CFDataGetBytePtr(dataref);
	int length=CFDataGetLength(dataref);
	for(int index=0;index<length;index+=4){
		// BRIGHTNESS
		for(int i=0;i<3;i++){
			if(data[index+i]+value<0){
				data[index+i]=0;
			}else{
				if(data[index+i]+value>255){
					data[index+i]=255;
				}else{
					data[index+i]+=value;
				}
			}
		}
        
		
	}
	size_t width=CGImageGetWidth(img);
	size_t height=CGImageGetHeight(img);
	size_t bitsPerComponent=CGImageGetBitsPerComponent(img);
	size_t bitsPerPixel=CGImageGetBitsPerPixel(img);
	size_t bytesPerRow=CGImageGetBytesPerRow(img);
	CGColorSpaceRef colorspace=CGImageGetColorSpace(img);
	CGBitmapInfo bitmapInfo=CGImageGetBitmapInfo(img);
	CFDataRef newData=CFDataCreate(NULL,data,length);
	CGDataProviderRef provider=CGDataProviderCreateWithCFData(newData);
	CGImageRef newImg=CGImageCreate(width,height,bitsPerComponent,bitsPerPixel,bytesPerRow,colorspace,bitmapInfo,provider,NULL,true,kCGRenderingIntentDefault);
	[imageView setImage:[UIImage imageWithCGImage:newImg]];
	CGImageRelease(newImg);
	CGDataProviderRelease(provider);
    free(data);
   
    
   // [image release];
	
}
-(IBAction)goBackToHome:(id)sender
{
    [self.view removeFromSuperview];
    
}
-(IBAction)cropAction:(id)sender
{
   // [self.view removeFromSuperview];
    
}
-(IBAction)shareAction:(id)sender
{
    fbViewController = [[FBFunViewController alloc] init];
    // [self clearView];
    [fbViewController setImage:imageView.image];
    [self.view addSubview:fbViewController.view];

    
}
-(void)dealloc
{
    [fbViewController release];
    [image release];
    [super dealloc];
}
@end
