//
//  GettingStartedTests.m
//  GettingStartedTests
//
//  Created by Moch Xiao on 11/18/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CHXTextEditConfigure.h"

@interface GettingStartedTests : XCTestCase

@end

@implementation GettingStartedTests

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
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testTextConfigure {
//	CHXTextEditConfigure *configure = [[CHXTextEditConfigure alloc] init];
//	configure.countingLabel =
}

@end
