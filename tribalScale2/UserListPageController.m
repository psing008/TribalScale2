//
//  UserListPageController.m
//  Test
//
//  Created by Piyush Singh on 12/8/16.
//  Copyright © 2016 Piyush Singh. All rights reserved.
//

#import "UserListPageController.h"
#import "APIManager.h"
#import "UserEntity.h"

static NSString * const userListURLString = @"https://randomuser.me/api/?results=100";
@implementation UserListPageController

+(void)getUserListDataWithBlock:(void (^)(NSArray *, BOOL, NSError *))completionBlock {
    
    [[APIManager sharedInstance] getDataWithPath:userListURLString andBlock:^(NSArray *results, BOOL sucess, NSError *error) {
        completionBlock(results,sucess,error);
    } jsonClass:[UserEntity class]];
}

+(void)getUserImage:(NSString *)imageURL block:(void (^)(UIImage *, NSError *))completionBlock{
    
    [[APIManager sharedInstance] getImageWithURL:imageURL andBlock:^(UIImage *image, NSError *error) {
        completionBlock(image,error);
    }];
}
@end
