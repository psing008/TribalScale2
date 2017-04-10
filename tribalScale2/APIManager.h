//
//  APIManager.h
//  tribalScale2
//
//  Created by Piyush Singh on 4/9/17.
//  Copyright © 2017 Piyush Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIkit.h"
@interface APIManager : NSObject
+(APIManager *)sharedInstance;

-(void)getDataWithPath:(NSString *)urlPath andBlock:(void (^)(NSArray * , BOOL, NSError* ))completionBlock jsonClass:(Class)JSONbaseClass;

-(void)getImageWithURL:(NSString *)imageURL andBlock:(void (^)(UIImage *,NSError *))completionBlock;
@end
