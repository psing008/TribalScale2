//
//  UserTableDelegateTests.m
//  tribalScale2
//
//  Created by Piyush Singh on 4/9/17.
//  Copyright © 2017 Piyush Singh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserTableDataDelegate.h"
#import "UserEntity.h"



@interface UserTableDelegateTests : XCTestCase
@property(nonatomic,strong)UserTableDataDelegate *sut;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation UserTableDelegateTests

- (void)setUp {
    [super setUp];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.sut = [[UserTableDataDelegate alloc]initWithTableView:self.tableView];
    self.data = [NSMutableArray new];
}

-(void)testSUTInitializedWithTable {
    XCTAssertNotNil(self.sut.tableView);
    XCTAssert(self.sut.tableView.dataSource == self.sut);
    XCTAssert(self.sut.tableView.delegate == self.sut);
    
}

-(void)testSUTShowsCorrectNumberofRows {
    // load data
    for (int i = 0; i < 5; i++) {
        UserEntity *user = [[UserEntity alloc]init];
        [self.data addObject:user];
    }
    self.sut.dataList = self.data;
    [self.sut reloadData];
    
    //Test
    
   XCTAssertEqual(5,[self.sut.tableView numberOfRowsInSection:0]);
    
}

-(void)testSUTDisplaysCorrectDataForCell {
    
    UserEntity *entity = [[UserEntity alloc]init];
    [self.data addObject:entity];
    entity.firstName = @"Adam"; entity.lastname = @"Silver"; entity.imageURL = @"imageURL";
    self.sut.dataList = self.data;
    [self.sut reloadData];
    
    UITableViewCell *cell = [self.sut.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    //Test
    XCTAssertNotNil(cell);
    XCTAssert([cell.textLabel.text isEqualToString:@"Adam Silver"]);
    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.sut.tableView.dataSource = nil;
    self.sut.tableView.delegate = nil;
    self.sut = nil;
    [super tearDown];
}


@end
