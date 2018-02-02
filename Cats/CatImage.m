//
//  CatImage.m
//  Cats
//
//  Created by Aaron Chong on 2/1/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

#import "CatImage.h"

@implementation CatImage

- (instancetype)initWithFarmID:(NSNumber *)farmID serverID:(NSString *)serverID idNumber:(NSString *)idNumber secretID:(NSString *)secretID title:(NSString *)title {
    
    self = [super init];
    if (self) {
        
        _farmID = farmID;
        _serverID = serverID;
        _idNumber = idNumber;
        _secretID = secretID;
        _title = title;
        _catUIImage = [[UIImage alloc] init];
    }
    return self;
}

- (void) createCatImageURL {
    
    NSString *catURL = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", self.farmID, self.serverID, self.idNumber, self.secretID];
    self.url = [NSURL URLWithString:catURL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:self.url completionHandler:^(NSURL * _Nullable location,   NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSData *catImageData = [[NSData alloc] initWithContentsOfURL:self.url];
        
        self.catUIImage = [[UIImage alloc] initWithData:catImageData];
        
    }];
    
    [downloadTask resume];
}


@end
