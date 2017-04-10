//
//  UserDetailViewController.m
//  tribalScale2
//
//  Created by Piyush Singh on 4/9/17.
//  Copyright © 2017 Piyush Singh. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserEntity.h"
#import "UserListPageController.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userImage.accessibilityLabel = @"userImage";
    self.userNameLabel.accessibilityLabel = @"userNameLabel";
    [self populateView];
}

-(void)populateView {
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@",self.userEntity.firstName, self.userEntity.lastname];
    [UserListPageController getUserImage:self.userEntity.largeImageURL block:^(UIImage *image, NSError *error) {
        self.userImage.image = image;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(void)dealloc{
    
}


@end
