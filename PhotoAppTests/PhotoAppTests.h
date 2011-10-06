//
//  PhotoAppTests.h
//  PhotoAppTests
//
//  Created by bhuvan khanna on 16/09/11.
//  Copyright 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "PhotoContestViewController.h"
#import "LoginViewController.h"
#import "SignupViewController.h"


#define USE_APPLICATION_UNIT_TEST 1


@interface PhotoAppTests : SenTestCase
{
      PhotoContestViewController* photoCTester;
      LoginViewController* loginCTester;
    SignupViewController *signupCTester;
}
@end

