//
//  APIManagerTests.m
//  tribalScale2
//
//  Created by Piyush Singh on 4/9/17.
//  Copyright © 2017 Piyush Singh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APIManager.h"
#import "OHHTTPStubs/OHHTTPStubs.h"
#import "OHHTTPStubs/OHPathHelpers.h"
#import "UserEntity.h"
@interface APIManager (Test)
@property(nonatomic,strong)NSURLSession *urlSession;
@end

@interface APIManagerTests : XCTestCase
@end

@implementation APIManagerTests

- (void)setUp {
    [super setUp];
}

-(void)testSUTInitialziedProperly {
    XCTAssertNotNil([APIManager sharedInstance]);
}
-(void)testSUTisConfiguredWithHTTPHeders {
    
    NSURLSessionConfiguration *config = [[[APIManager sharedInstance] urlSession] configuration];
    NSDictionary *additionalHTTPHeaders = config.HTTPAdditionalHeaders;
    
    XCTAssert([[additionalHTTPHeaders valueForKey:@"Content-Type"] isEqualToString:@"application/json"]);
    XCTAssert([[additionalHTTPHeaders valueForKey:@"Accept"]  isEqualToString:@"application/json"]);

}

-(void)testAPIManagerGETMethodReturnsCorrectEntities {
    
    // Let us stub all outgoing requests through OHHTTPStub, so there is not internet dependency
    //Set-up
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:@"https://randomuser.me/api/?results=100"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        // Stub it with our "testData" stub file (which is in same bundle as self)
        NSString* fixture = OHPathForFile(@"testJSONData.json", self.class);
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"GET"];
    
    //Test
    
    [[APIManager sharedInstance] getDataWithPath:@"https://randomuser.me/api/?results=100" andBlock:^(NSArray *result, BOOL success, NSError *error) {
        
        XCTAssertEqual(result.count, 99);
        XCTAssertNil(error);
        XCTAssertTrue(success);
        XCTAssertTrue([result.firstObject isKindOfClass:[UserEntity class]]);
        [expectation fulfill];
        
    } jsonClass:[UserEntity class]];
    
    [self waitForExpectationsWithTimeout:3.0 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
    
}

-(void)testAPIManagerGETImageisWorkingCorrectly {

    //Lets stub out image-fetching, so there is not internet dependency
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:@"https://randomuser.me/api/portraits/thumb/women/78.jpg"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        // Stub it with our "testData" stub file (which is in same bundle as self)
        NSString* fixture = OHPathForFile(@"userpic.jpg", self.class);
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                statusCode:200 headers:@{}];
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"GETImage"];
    
    [[APIManager sharedInstance] getImageWithURL:@"https://randomuser.me/api/portraits/thumb/women/78.jpg" andBlock:^(UIImage *image, NSError *error) {
        
        XCTAssertNotNil(image);
        XCTAssertNil(error);
        [expectation fulfill];

    }];
    [self waitForExpectationsWithTimeout:4.0 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    [super tearDown];
}


@end
