//
//  UserListViewControllerTest.m
//  tribalScale2
//
//  Created by Piyush Singh on 4/9/17.
//  Copyright © 2017 Piyush Singh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserListViewController.h"
#import "UserTableDataDelegate.h"

@interface UserListViewController (Test)
-(void)initializeView;
@property(nonatomic,strong)UserTableDataDelegate *dataSource;
@property(nonatomic,strong)NSArray *userListData;
@end

@interface UserListViewControllerTest : XCTestCase
@property(nonatomic,strong)UserListViewController *sut;
@end

@implementation UserListViewControllerTest

- (void)setUp {
    [super setUp];
    
    self.sut = [[UserListViewController alloc]init];
    [self.sut initializeView];
    
}

-(void)testDataSourcDelegateIset {
    XCTAssertNotNil(self.sut.dataSource);
    XCTAssertNotNil(self.sut.tableView);
    XCTAssertNotNil(self.sut.userListData);
}

-(void)testUserDataListIsSetProperly {
    NSArray *data = @[@"1",@"2",@"3"];
    [self.sut setUserListData:data];
    
    XCTAssertEqual(data, self.sut.userListData);
    //Make sure DataSource's data is set and correct
    XCTAssertNotNil(self.sut.dataSource.dataList);
    XCTAssertEqual(self.sut.dataSource.dataList.count, 3);
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

@end
