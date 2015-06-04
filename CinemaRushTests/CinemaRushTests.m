//
//  CinemaRushTests.m
//  CinemaRushTests
//
//  Created by Admin on 25.05.15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FilmsProvider.h"
#import "AppDelegate.h"

@interface CinemaRushTests : XCTestCase

@end

@implementation CinemaRushTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    XCTAssertEqualObjects([NSValue valueWithCGRect:[UIScreen mainScreen].bounds],[NSValue valueWithCGRect:app.window.frame]);
}

- (void)testSingletons
{
    FilmsProvider *provider1 = [FilmsProvider sharedProvider];
    FilmsProvider *provider2 = [FilmsProvider sharedProvider];
    
    XCTAssertEqual(provider1, provider2);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
