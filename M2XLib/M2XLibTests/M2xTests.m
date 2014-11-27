//
//  M2xTests.m
//  M2XLib
//
//  Created by Luis Floreani on 11/5/14.
//  Copyright (c) 2014 citrusbyte.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "CBBM2xClient.h"
#import "CBBKeysClient.h"

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
    CBBM2xClient *client = [[CBBM2xClient alloc] initWithApiKey:nil];
    
    __block BOOL failed = NO;
    [client getWithPath:@"/mypath" andParameters:@{@"param1": @"1", @"param2": @"2"} apiKey:client.apiKey completionHandler:^(CBBResponse *response) {
        if (response.error) {
            XCTAssertTrue(response.error);
            XCTAssertEqual(response.error.code, CBBM2xNoApiKey);
            failed = YES;
        } else {
            XCTFail(@"can't be here");
        }
    }];

    XCTAssertTrue(failed);
}

- (void)testGet {
    CBBM2xClient *client = [[CBBM2xClient alloc] initWithApiKey:@"1234"];
    
    XCTAssertTrue(client.apiUrl);
    NSURLRequest *request = [client getWithPath:@"/mypath" andParameters:@{@"param1": @"1", @"param2": @"2", @"param3": @3} apiKey:client.apiKey completionHandler:nil];
    
    XCTAssertNotNil(request.URL.host);
    XCTAssertEqualObjects(request.HTTPMethod, @"GET");
    XCTAssertEqualObjects([[NSURL URLWithString:client.apiUrl] host], request.URL.host);
    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"X-M2X-KEY"], client.apiKey);
    XCTAssertTrue([request.allHTTPHeaderFields[@"User-Agent"] rangeOfString:@"M2X-iOS"].location != NSNotFound);
    
    XCTAssertEqualObjects(@"/v2/mypath", request.URL.path);
    XCTAssertTrue([request.URL.query rangeOfString:@"param1=1"].location != NSNotFound);
    XCTAssertTrue([request.URL.query rangeOfString:@"param2=2"].location != NSNotFound);
    XCTAssertTrue([request.URL.query rangeOfString:@"param3=3"].location != NSNotFound);
}

- (void)testDelete {
    CBBM2xClient *client = [[CBBM2xClient alloc] initWithApiKey:@"1234"];
    
    XCTAssertTrue(client.apiUrl);
    NSURLRequest *request = [client deleteWithPath:@"/mypath" andParameters:@{@"param1": @"1", @"param2": @"2"} apiKey:client.apiKey completionHandler:nil];
    
    XCTAssertNotNil(request.URL.host);
    XCTAssertEqualObjects(request.HTTPMethod, @"DELETE");
    XCTAssertEqualObjects([[NSURL URLWithString:client.apiUrl] host], request.URL.host);
    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"X-M2X-KEY"], client.apiKey);
    XCTAssertTrue([request.allHTTPHeaderFields[@"User-Agent"] rangeOfString:@"M2X-iOS"].location != NSNotFound);
    
    XCTAssertEqualObjects(@"/v2/mypath", request.URL.path);
    XCTAssertTrue([request.URL.query rangeOfString:@"param1=1"].location != NSNotFound);
    XCTAssertTrue([request.URL.query rangeOfString:@"param2=2"].location != NSNotFound);
}

- (void)testPost {
    CBBM2xClient *client = [[CBBM2xClient alloc] initWithApiKey:@"1234"];
    client.apiKey = @"1234";
    
    XCTAssertTrue(client.apiUrl);
    NSURLRequest *request = [client postWithPath:@"/mypath" andParameters:@{@"param1": @"1", @"param2": @"2"} apiKey:client.apiKey completionHandler:nil];
    
    XCTAssertNotNil(request.URL.host);
    XCTAssertEqualObjects(request.HTTPMethod, @"POST");
    XCTAssertEqualObjects([[NSURL URLWithString:client.apiUrl] host], request.URL.host);
    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"X-M2X-KEY"], client.apiKey);
    XCTAssertTrue([request.allHTTPHeaderFields[@"User-Agent"] rangeOfString:@"M2X-iOS"].location != NSNotFound);

    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"Content-Type"], @"application/json");

    XCTAssertEqualObjects(@"/v2/mypath", request.URL.path);
    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    XCTAssertTrue([body rangeOfString:@"\"param1\":\"1\""].location != NSNotFound);
    XCTAssertTrue([body rangeOfString:@"\"param2\":\"2\""].location != NSNotFound);
}

- (void)testPut {
    CBBM2xClient *client = [[CBBM2xClient alloc] initWithApiKey:@"1234"];
    client.apiKey = @"1234";
    
    XCTAssertTrue(client.apiUrl);
    NSURLRequest *request = [client putWithPath:@"/mypath" andParameters:@{@"param1": @"1", @"param2": @"2"} apiKey:client.apiKey completionHandler:nil];
    
    XCTAssertNotNil(request.URL.host);
    XCTAssertEqualObjects(request.HTTPMethod, @"PUT");
    XCTAssertEqualObjects([[NSURL URLWithString:client.apiUrl] host], request.URL.host);
    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"X-M2X-KEY"], client.apiKey);
    XCTAssertTrue([request.allHTTPHeaderFields[@"User-Agent"] rangeOfString:@"M2X-iOS"].location != NSNotFound);
    
    XCTAssertEqualObjects(request.allHTTPHeaderFields[@"Content-Type"], @"application/json");
    
    XCTAssertEqualObjects(@"/v2/mypath", request.URL.path);
    NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    XCTAssertTrue([body rangeOfString:@"\"param1\":\"1\""].location != NSNotFound);
    XCTAssertTrue([body rangeOfString:@"\"param2\":\"2\""].location != NSNotFound);
}

- (void)testErrorOn400 {
    id sessionMock = OCMClassMock([NSURLSession class]);
    [[[sessionMock stub] andDo:^(NSInvocation *invocation) {
        void (^callback)(NSData *data, NSURLResponse *response, NSError *error);
        [invocation getArgument:&callback atIndex:3];
        
        NSData *data = [NSData dataWithContentsOfFile:@"{\"a\":\"b\"}"];
        NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:nil statusCode:404 HTTPVersion:@"1.1" headerFields:nil];
        
        callback(data, response, nil);
    }] dataTaskWithRequest:[OCMArg any] completionHandler:[OCMArg any]];
    
    CBBM2xClient *client = [[CBBM2xClient alloc] initWithApiKey:@"1234"];
    client.session = sessionMock;
    client.apiKey = @"1234";
    [client putWithPath:@"/mypath" andParameters:@{@"param1": @"1", @"param2": @"2"} apiKey:client.apiKey completionHandler:^(CBBResponse *response) {
        XCTAssertNotNil(response.error);
        XCTAssertEqual(response.error.code, CBBM2xRequestError);
    }];
}

- (void)testErrorOn500 {
    id sessionMock = OCMClassMock([NSURLSession class]);
    [[[sessionMock stub] andDo:^(NSInvocation *invocation) {
        void (^callback)(NSData *data, NSURLResponse *response, NSError *error);
        [invocation getArgument:&callback atIndex:3];
        
        NSData *data = [NSData dataWithContentsOfFile:@"{\"a\":\"b\"}"];
        NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:nil statusCode:500 HTTPVersion:@"1.1" headerFields:nil];
        
        callback(data, response, nil);
    }] dataTaskWithRequest:[OCMArg any] completionHandler:[OCMArg any]];
    
    CBBM2xClient *client = [[CBBM2xClient alloc] initWithApiKey:@"1234"];
    client.session = sessionMock;
    client.apiKey = @"1234";
    [client putWithPath:@"/mypath" andParameters:@{@"param1": @"1", @"param2": @"2"} apiKey:client.apiKey completionHandler:^(CBBResponse *response) {
        XCTAssertNotNil(response.error);
        XCTAssertEqual(response.error.code, CBBM2xRequestError);
    }];
}

@end
