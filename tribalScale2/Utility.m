//
//  Utility.m
//  tribalScale2
//
//  Created by Piyush Singh on 4/9/17.
//  Copyright © 2017 Piyush Singh. All rights reserved.
//

#import "Utility.h"

@implementation Utility
+(id)parseData:(NSData *)data andError:(NSError * __autoreleasing *)error {
    
    NSError *jsonError;
    id results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
    
    if (jsonError) {
        *error = [NSError errorWithDomain:@"JSONFail" code:1000 userInfo:nil];
    }
    
    return results;
    
}
+(NSURLRequest *)requestWithURL:(NSString *)urlString{
    
    NSString *escapedString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if (escapedString == nil) {
        return nil;
    }
    NSURL *url = [NSURL URLWithString:escapedString];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    return request;
}
@end
