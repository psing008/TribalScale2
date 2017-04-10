//
//  APIManager.m
//  tribalScale2
//
//  Created by Piyush Singh on 4/9/17.
//  Copyright © 2017 Piyush Singh. All rights reserved.
//

#import "APIManager.h"
#import "JSONBaseClass.h"
#import "Utility.h"
static APIManager *_sharedInstance;

@interface APIManager()
@property(nonatomic,strong)NSURLSession *urlSession;

@end

@implementation APIManager

+(APIManager *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[APIManager alloc]init];
    });
    return _sharedInstance;
}

-(instancetype)init {
    if (self == [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSDictionary *headers = @{@"Accept":@"application/json",@"Content-Type":@"application/json"};
        config.HTTPAdditionalHeaders = headers;
        _urlSession = [NSURLSession sessionWithConfiguration:config];
        
    }
    return self;
    
}

-(void)getDataWithPath:(NSString *)urlPath andBlock:(void (^)(NSArray *, BOOL, NSError *))completionBlock jsonClass:(Class)JSONbaseClass {
    
    if (!completionBlock) {
        return;
    }
    NSURLRequest *request = [Utility requestWithURL:urlPath];
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            completionBlock(nil,NO,error);
            return;
        }
        
        NSError *jsonError;
        id  results  = [Utility parseData:data andError:&error];
        if (jsonError) {
            completionBlock(nil,NO,jsonError);
            return;
        }
        NSMutableArray *userDataEntityList = [NSMutableArray new];
        NSArray *resultsDict = [results valueForKey:@"results"];
        
        for(NSDictionary *user in resultsDict) {
            JSONBaseClass *userEntity = [[JSONbaseClass alloc] initWithDictionary:user];
            [userDataEntityList addObject:userEntity];
        }
        completionBlock([NSArray arrayWithArray:userDataEntityList],YES,nil);
    }];
    
    [dataTask resume];

}
-(void)getImageWithURL:(NSString *)imageURL andBlock:(void (^)(UIImage *,NSError *))completionBlock {
    
    NSURLSessionTask *downloadImageTask = [self.urlSession dataTaskWithURL:[NSURL URLWithString:imageURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //Check for block, if empty, process will crash
        if (!completionBlock) {
            return;
        }
        if (error) {
            completionBlock(nil,error);
            return;
        }
        
        NSError *imageError;
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                completionBlock(image,nil);
            }else{
                //image parsing failed
                imageError = [NSError errorWithDomain:@"ImageParsingFail" code:999 userInfo:nil];
                completionBlock(nil,imageError);
            }
        }
    }];
    [downloadImageTask resume];
}

@end
