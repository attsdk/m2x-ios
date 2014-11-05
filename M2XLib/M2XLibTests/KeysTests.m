//
//  KeysTests.m
//  M2XLib
//
//  Created by Luis Floreani on 11/4/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CBBKeysClient.h"

@interface KeysTests : XCTestCase

@end

@implementation KeysTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUseApiKeyWhenFeedKeyIsUnavailable {
    [CBBM2x shared].apiKey = @"apiKey";
    
    CBBKeysClient *client = [CBBKeysClient new];
    client.feedKey = nil;
    
    NSURLRequest *request = [client listKeysWithParameters:nil success:nil failure:nil];
    
    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"X-M2X-KEY"], @"apiKey");
}

- (void)testUseFeedKeyWhenAvailable {
    [CBBM2x shared].apiKey = @"apiKey";
    
    CBBKeysClient *client = [CBBKeysClient new];
    client.feedKey = @"feedKey";
    
    NSURLRequest *request = [client listKeysWithParameters:nil success:nil failure:nil];

    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"X-M2X-KEY"], @"feedKey");
}

- (void)testKeysListing {
    CBBKeysClient *client = [CBBKeysClient new];
    client.feedKey = @"1234";
    
    NSURLRequest *req = [client listKeysWithParameters:@{@"limit": @"10", @"q": @"bla"} success:nil failure:nil];
    
    XCTAssertEqualObjects(req.URL.path, @"/v1/keys");
    XCTAssertTrue([req.URL.query rangeOfString:@"limit=10"].location != NSNotFound);
    XCTAssertTrue([req.URL.query rangeOfString:@"q=bla"].location != NSNotFound);
}

@end
