/*
 *  RestConnectionDelegate.h
 *  RestConnection
 *
 *  Created by Logan Cautrell on 10/4/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

@protocol RestConnectionDelegate

- (void)willSendRequest:(NSURLRequest *)request;
- (void)didReceiveResponse:(NSURLResponse *)response;
- (void)finishedReceivingData:(NSData *)data;

@end