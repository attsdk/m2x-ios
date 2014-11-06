//
//  M2xTests.m
//  M2XLib
//
//  Created by Luis Floreani on 11/5/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CBBM2x.h"

@interface M2xTests : XCTestCase

@end

@implementation M2xTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMissingKey {
    CBBM2x *client = [CBBM2x shared];
    client.apiKey = nil;
    
    __block BOOL failed = NO;
    [client getWithPath:@"/mypath" andParameters:@{@"param1": @"1", @"param2": @"2"} apiKey:client.apiKey completionHandler:^(id object, NSURLResponse *response, NSError *error) {
        if (error) {
            XCTAssertTrue(error);
            XCTAssertEqual(error.code, CBBM2xNoApiKey);
            failed = YES;
        } else {
            XCTFail(@"can't be here");
        }
    }];

    XCTAssertTrue(failed);
}

- (void)testGet {
    CBBM2x *client = [CBBM2x shared];
    client.apiKey = @"1234";
    
    XCTAssertTrue(client.apiUrl);
    NSURLRequest *request = [client getWithPath:@"/mypath" andParameters:@{@"param1": @"1", @"param2": @"2"} apiKey:client.apiKey completionHandler:nil];
    
    XCTAssertNotNil(request.URL.host);
    XCTAssertEqualObjects(request.HTTPMethod, @"GET");
    XCTAssertEqualObjects([[NSURL URLWithString:client.apiUrl] host], request.URL.host);
    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"X-M2X-KEY"], client.apiKey);
    XCTAssertTrue([request.allHTTPHeaderFields[@"User-Agent"] rangeOfString:@"M2X/"].location != NSNotFound);
    
    XCTAssertEqualObjects(@"/v2/mypath", request.URL.path);
    XCTAssertTrue([request.URL.query rangeOfString:@"param1=1"].location != NSNotFound);
    XCTAssertTrue([request.URL.query rangeOfString:@"param2=2"].location != NSNotFound);
}

- (void)testDelete {
    CBBM2x *client = [CBBM2x shared];
    client.apiKey = @"1234";
    
    XCTAssertTrue(client.apiUrl);
    NSURLRequest *request = [client deleteWithPath:@"/mypath" andParameters:@{@"param1": @"1", @"param2": @"2"} apiKey:client.apiKey completionHandler:nil];
    
    XCTAssertNotNil(request.URL.host);
    XCTAssertEqualObjects(request.HTTPMethod, @"DELETE");
    XCTAssertEqualObjects([[NSURL URLWithString:client.apiUrl] host], request.URL.host);
    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"X-M2X-KEY"], client.apiKey);
    XCTAssertTrue([request.allHTTPHeaderFields[@"User-Agent"] rangeOfString:@"M2X/"].location != NSNotFound);
    
    XCTAssertEqualObjects(@"/v2/mypath", request.URL.path);
    XCTAssertTrue([request.URL.query rangeOfString:@"param1=1"].location != NSNotFound);
    XCTAssertTrue([request.URL.query rangeOfString:@"param2=2"].location != NSNotFound);
}

- (void)testPost {
    CBBM2x *client = [CBBM2x shared];
    client.apiKey = @"1234";
    
    XCTAssertTrue(client.apiUrl);
    NSURLRequest *request = [client postWithPath:@"/mypath" andParameters:@{@"param1": @"1", @"param2": @"2"} apiKey:client.apiKey completionHandler:nil];
    
    XCTAssertNotNil(request.URL.host);
    XCTAssertEqualObjects(request.HTTPMethod, @"POST");
    XCTAssertEqualObjects([[NSURL URLWithString:client.apiUrl] host], request.URL.host);
    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"X-M2X-KEY"], client.apiKey);
    XCTAssertTrue([request.allHTTPHeaderFields[@"User-Agent"] rangeOfString:@"M2X/"].location != NSNotFound);

    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"Content-Type"], @"application/json");

    XCTAssertEqualObjects(@"/v2/mypath", request.URL.path);
    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    XCTAssertTrue([body rangeOfString:@"\"param1\":\"1\""].location != NSNotFound);
    XCTAssertTrue([body rangeOfString:@"\"param2\":\"2\""].location != NSNotFound);
}

- (void)testPut {
    CBBM2x *client = [CBBM2x shared];
    client.apiKey = @"1234";
    
    XCTAssertTrue(client.apiUrl);
    NSURLRequest *request = [client putWithPath:@"/mypath" andParameters:@{@"param1": @"1", @"param2": @"2"} apiKey:client.apiKey completionHandler:nil];
    
    XCTAssertNotNil(request.URL.host);
    XCTAssertEqualObjects(request.HTTPMethod, @"PUT");
    XCTAssertEqualObjects([[NSURL URLWithString:client.apiUrl] host], request.URL.host);
    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"X-M2X-KEY"], client.apiKey);
    XCTAssertTrue([request.allHTTPHeaderFields[@"User-Agent"] rangeOfString:@"M2X/"].location != NSNotFound);
    
    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"Content-Type"], @"application/json");
    
    XCTAssertEqualObjects(@"/v2/mypath", request.URL.path);
    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    XCTAssertTrue([body rangeOfString:@"\"param1\":\"1\""].location != NSNotFound);
    XCTAssertTrue([body rangeOfString:@"\"param2\":\"2\""].location != NSNotFound);
}

@end
