//
//  Utility.h
//  tribalScale2
//
//  Created by Piyush Singh on 4/9/17.
//  Copyright © 2017 Piyush Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject
+(id)parseData:(NSData *)data andError:(NSError * __autoreleasing *)error;
+(NSURLRequest*)requestWithURL:(NSString *)urlString;
@end
