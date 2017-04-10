//
//  UtilityTest.m
//  tribalScale2
//
//  Created by Piyush Singh on 4/9/17.
//  Copyright © 2017 Piyush Singh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Utility.h"

@interface UtilityTest : XCTestCase

@end

@implementation UtilityTest

- (void)setUp {
    [super setUp];
    
}

-(void)testSUTParsesJSONProperly {
    
    id results = nil;
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"testJSONData" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *jsonError = nil;
    results = [Utility parseData:jsonData andError:&jsonError];
    
    XCTAssertNil(jsonError);
    XCTAssertNotNil(results);

}

-(void)testSUTCreatesCorrectURLRequest {
    NSString *testString = @"https://randomuser.me/api/?results=100";
    NSURLRequest *request = [Utility requestWithURL:testString];
    
    XCTAssertNotNil(request);
    XCTAssertNotNil(request.URL);
    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


@end
