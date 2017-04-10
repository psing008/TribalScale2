//
//  UserDetailViewController.h
//  tribalScale2
//
//  Created by Piyush Singh on 4/9/17.
//  Copyright © 2017 Piyush Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserEntity;
@interface UserDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property(weak,nonatomic)UserEntity *userEntity;
@end
