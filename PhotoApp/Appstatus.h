//
//  Appstatus.h
//  PhotoApp
//
//  Created by bhuvan khanna on 19/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Appstatus : NSObject
{
    NSString *path;
    NSString *auth_code;
}


-(BOOL)isAppRegistered;
-(NSString*)getAuthCode;
-(BOOL)isAppOnline;
-(NSString*)readAuthCode;
-(void)saveAuthCode:(NSString*)authKey;
-(void)setAuthCode:(NSString*)authKey;
-(void)removeAuthCode;
-(NSString*)getPath;

@end
