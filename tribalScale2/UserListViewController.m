//
//  ViewController.m
//  tribalScale2
//
//  Created by Piyush Singh on 4/9/17.
//  Copyright © 2017 Piyush Singh. All rights reserved.
//

#import "UserListViewController.h"

#import "UserListPageController.h"
#import "UserTableDataDelegate.h"
#import "UserDetailViewController.h"

static NSString *const kUserDetailIdentifier= @"userDetailIdentifier";

@interface UserListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UserTableDataDelegate *dataSource;
@property(nonatomic,strong)NSArray *userListData;

@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeView];
}

-(void)initializeView {
    self.tableView.accessibilityLabel = @"userTableView";
    _userListData = [NSArray new];
    self.dataSource = [[UserTableDataDelegate alloc]initWithTableView:self.tableView];
    [self startLoadingUsers];
}

-(void)startLoadingUsers {
    __weak typeof (self) weakSelf = self;
    [UserListPageController getUserListDataWithBlock:^(NSArray *results, BOOL suces, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //to make sure self is retained throughout
            __typeof__(self) strongSelf = weakSelf;
            strongSelf.userListData = results;
        });
    }];
}
-(void)setUserListData:(NSArray *)userListData {
    _userListData = userListData;
    self.dataSource.dataList = self.userListData;
    [self.dataSource reloadData];
}
#pragma Seague Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kUserDetailIdentifier]) {
        UserDetailViewController *destination = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        UserEntity *entity = self.userListData[indexPath.row];
        [destination setValue:entity forKey:@"userEntity"];
    }
}
@end
