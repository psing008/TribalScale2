//
//  UserListPageController.h
//  Test
//
//  Created by Piyush Singh on 12/8/16.
//  Copyright © 2016 Piyush Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONBaseClass.h"
#import "UIKit/UIKit.h"

@interface UserListPageController : NSObject
+(void)getUserListDataWithBlock:(void (^)(NSArray *,BOOL, NSError *))completionBlock;
+(void)getUserImage:(NSString *)imageURL block:(void (^)(UIImage *,NSError *))completionBlock;
@end
