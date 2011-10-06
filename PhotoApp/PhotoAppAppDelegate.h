//
//  PhotoAppAppDelegate.h
//  PhotoApp
//
//  Created by bhuvan khanna on 16/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoContestViewController;


@interface PhotoAppAppDelegate : NSObject <UIApplicationDelegate>


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PhotoContestViewController *viewController;

@end
