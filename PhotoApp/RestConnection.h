//
//  RestConnection.h
//  RestConnection
//
//  Created by Logan Cautrell on 10/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestConnectionDelegate.h"


@interface RestConnection : NSObject {

@private
	id<RestConnectionDelegate> delegate;
	NSString *baseURLString;
	NSURLRequest *request;
	NSURLResponse *response;
	
	NSURLConnection *urlConnection;
	NSMutableData *responseData;
}

@property (nonatomic, assign) id<RestConnectionDelegate> delegate;
@property (nonatomic, copy) NSString *baseURLString;

// The last request made.
@property (nonatomic, readonly) NSURLRequest *request;

// The last response eceived.
@property (nonatomic, readonly) NSURLResponse *response;

// Returns an immutable copy of the last data received.
@property (nonatomic, readonly) NSData *data;

// Returns an immutable string copy of the last data received.
@property (nonatomic, readonly) NSString *stringData;

// Designated Initializer
- (id)initWithBaseURL:(NSString *)baseURL;
- (void)performRequestGET:(NSURLRequest *)aRequest;
- (void)performRequestPOST:(NSURLRequest *)aRequest:(NSString*)postData;

@end
