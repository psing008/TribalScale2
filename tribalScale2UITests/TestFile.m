//
//  TestFile.m
//  tribalScale2
//
//  Created by Piyush Singh on 4/9/17.
//  Copyright © 2017 Piyush Singh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OHHTTPStubs/OHHTTPStubs.h"
#import "OHHTTPStubs/OHPathHelpers.h"

@interface TestFile : XCTestCase{
    XCUIApplication *app;
}

@end

@implementation TestFile

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
     app = [[XCUIApplication alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// W
-(void)testApp {
    //Check if Table exists and loaded cells
    XCUIElement *userTableList = app.tables[@"userTableView"];
    XCTAssert([userTableList exists]);
    sleep(3);
    XCTAssertNotNil(userTableList.cells);
    XCTAssertEqual(userTableList.cells.count, 100);
    
    // Go to DetailPage
    [app.tables.cells.allElementsBoundByIndex[0] tap];
    //Check if elememts exist
    XCTAssert([app.images[@"userImage"] exists]);
    XCTAssert([[app.staticTexts[@"userNameLabel"] label] length] > 0 && [app.staticTexts[@"userNameLabel"] exists] );
    
    //Go Back
    [[[[app.navigationBars[@"UserDetailView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    XCTAssertEqual(userTableList.cells.count, 100);
    
    //Make sure UserTableList exists, else something went wrong
    XCTAssert([userTableList exists]);

}


//{
//    NSUInteger line = __LINE__;
//    NSString *file = [NSString stringWithUTF8String:__FILE__];
//    NSPredicate *existsPredicate = [NSPredicate predicateWithFormat:@"exists == true"];
//    
//    [self expectationForPredicate:existsPredicate evaluatedWithObject:element handler:nil];
//    
//    [self waitForExpectationsWithTimeout:timeout handler:^(NSError * _Nullable error) {
//        if (error != nil) {
//            NSString *message = [NSString stringWithFormat:@"Failed to find %@ after %f seconds",element,timeout];
//            [self recordFailureWithDescription:message inFile:file atLine:line expected:YES];
//        }
//    }];
//}
@end
