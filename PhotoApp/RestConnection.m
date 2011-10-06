//
//  RestConnection.m
//  RestConnection
//
//  Created by Logan Cautrell on 10/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RestConnection.h"

@interface RestConnection (private)

- (void)startRequest:(NSURLRequest *)request;
- (void)clearUrlConnection;

@end


@implementation RestConnection

@synthesize delegate, baseURLString, request, response;

#pragma mark Accessor Methods

- (NSData *)data
{
	return [[responseData copy] autorelease];
}

- (NSString *)stringData
{
	return [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
}

#pragma mark Setup and Teardown Methods

- (id)initWithBaseURL:(NSString *)baseURL
{
	self = [super init];
	if (self != nil)
	{
		delegate = nil;
		self.baseURLString = baseURL;
		request = nil;
		response = nil;
		urlConnection = nil;
		responseData = nil;
	}
	
	return self;	
}

- (id)init
{
	return [self initWithBaseURL:@""];
}

- (void) dealloc
{
	self.baseURLString = nil;
	[request release];
	[response release];
	[urlConnection release];
	[responseData release];
	
	[super dealloc];
}


#pragma mark Public Methods

- (void)performRequestGET:(NSURLRequest *)aRequest
{	
	NSMutableURLRequest *mutableRequest = [aRequest mutableCopy];
	
	// Add the base URL as necessary.
	if ([[[mutableRequest URL] absoluteString] rangeOfString:baseURLString].location == NSNotFound)
	{
		NSURL *url = [NSURL URLWithString:[[mutableRequest URL] absoluteString] 
							relativeToURL:[NSURL URLWithString:baseURLString]];
		[mutableRequest setURL:url];
	}
	
	if ([mutableRequest valueForHTTPHeaderField:@"Content-Type"] == nil)
		[mutableRequest setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	if ([mutableRequest valueForHTTPHeaderField:@"Accept"] == nil)
		[mutableRequest setValue:@"application/json" forHTTPHeaderField:@"accept"];
   
	[self startRequest:mutableRequest];
	
	[mutableRequest release];
}
- (void)performRequestPOST:(NSURLRequest *)aRequest:(NSString *)postData
{	
	NSMutableURLRequest *mutableRequest = [aRequest mutableCopy];
	
	// Add the base URL as necessary.
	if ([[[mutableRequest URL] absoluteString] rangeOfString:baseURLString].location == NSNotFound)
	{
		NSURL *url = [NSURL URLWithString:[[mutableRequest URL] absoluteString] 
							relativeToURL:[NSURL URLWithString:baseURLString]];
		[mutableRequest setURL:url];
	}
	
	if ([mutableRequest valueForHTTPHeaderField:@"Content-Type"] == nil)
		[mutableRequest setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	if ([mutableRequest valueForHTTPHeaderField:@"Accept"] == nil)
		[mutableRequest setValue:@"application/json" forHTTPHeaderField:@"accept"];
    
    
    //--------------------------------------------------------------------------------------
    
   // NSString *postData = [[NSString alloc] initWithFormat:@"email=nilesh@weboniselab.com&password=nilesh"];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSLog(@"post:%@",postData);  
    
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [mutableRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [mutableRequest setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //-----------------------------------------------------------------------------------------
    
	[self startRequest:mutableRequest];
	
	[mutableRequest release];
}



#pragma mark Private Methods

- (void)startRequest:(NSURLRequest *)aRequest
{
	if (delegate != nil)
		[delegate willSendRequest:aRequest];
	
	// Clear any previous data and setup to collect the response and response data.
	[request release];
	request = [aRequest retain];
	[responseData release];
	responseData = [NSMutableData new];
	[response release];
	response = nil;
	
	// Load the URL.
	urlConnection = [[NSURLConnection connectionWithRequest:request
												   delegate:self] retain];
}	

- (void)clearUrlConnection
{
	if (urlConnection != nil)
	{
		[urlConnection release];
		urlConnection = nil;
	}

	if (delegate != nil)
		[delegate finishedReceivingData:self.data];
}

@end


@implementation RestConnection (NSURLConnectionDelegate)

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)aRequest redirectResponse:(NSURLResponse *)aResponse;
{
	NSLog(@"In connection: willSendRequest: %@ redirectResponse: %@", aRequest, aResponse);
	return aRequest;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
{
	NSLog(@"In connection: didReceiveAuthenticationChallenge: %@", challenge);
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
{
	NSLog(@"In connection: didCancelAuthenticationChallenge: %@", challenge);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse;
{
	NSLog(@"connection: didReceiveResponse: %@, %lld", [aResponse URL], [aResponse expectedContentLength]);
	response = [aResponse retain];
	
	if (delegate != nil)
		[delegate didReceiveResponse:response];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)newData;
{
	NSLog(@"In connection: didReceiveData:");
	[responseData appendData:newData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
{
	NSLog(@"In connectionDidFinishLoading:");
	[self clearUrlConnection];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
{
	NSLog(@"In connection: didFailWithError: %@", error);
	[self clearUrlConnection];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse;
{
	NSLog(@"connection: willCacheResponse:");
	return nil;
}


@end









