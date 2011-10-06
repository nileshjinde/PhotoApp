//
//  Appstatus.m
//  PhotoApp
//
//  Created by bhuvan khanna on 19/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import "Appstatus.h"
@implementation Appstatus

- (id)init
{
    self = [super init];
    if (self) {
           
    }
    
    return self;
}
-(NSString*)getPath{

    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [documentPath objectAtIndex:0];
    return documentFolder;
}

-(BOOL)isAppOnline
{
  /*  if([NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]]!=NULL)
    {
        NSLog(@"Net Connected");
        return YES;
    }
    else
    {
        NSLog(@"Net not Connected");
        return NO;
    }*/
    
    return YES;
    
    
}
-(NSString*)readAuthCode
{
    path = [[self getPath] stringByAppendingPathComponent:@"photoAppSettings.plist"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    auth_code=[dict valueForKey:@"auth_code"];
    NSLog(@"Mobile auth_code %@",auth_code);
    
    return auth_code;
}

-(void)saveAuthCode:(NSString*)authKey
{
        
    //the below variable is an instance of the NSString class and is declared inteh .h file 
    path = [[self getPath] stringByAppendingPathComponent:@"photoAppSettings.plist"];
    
    NSString *bundleFile = [[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"];
    
    
    //copy the file from the bundle to the doc directory 
    [[NSFileManager defaultManager]copyItemAtPath:bundleFile toPath:path error:nil];
    
    NSMutableDictionary *addData = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    //adding the new objects to the plist
    [addData setObject:authKey forKey:@"auth_code"];
    
    //finally saving the changes made to the file
    [addData writeToFile:path atomically:YES];  

}
-(BOOL)isAppRegistered
{
    if(auth_code == NULL)
    {
        return NO;
    }
    return YES;
}
-(NSString*)getAuthCode
{
    auth_code=[self readAuthCode];
    
    return auth_code;
}
-(void)setAuthCode:(NSString*)authKey
{
    auth_code=authKey;
    [self saveAuthCode:authKey];
}
-(void)removeAuthCode
{
    
}
- (void)dealloc {
	
    [super dealloc];

}
@end
