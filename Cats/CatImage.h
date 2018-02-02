//
//  CatImage.h
//  Cats
//
//  Created by Aaron Chong on 2/1/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIkit/UIKit.h"

@interface CatImage : NSObject

@property (strong, nonatomic) NSNumber *farmID;
@property (strong, nonatomic) NSString *serverID;
@property (strong, nonatomic) NSString *idNumber;
@property (strong, nonatomic) NSString *secretID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL* url;
@property (strong, nonatomic) UIImage *catUIImage;

- (instancetype) initWithFarmID:(NSNumber *)farmID serverID:(NSString *)serverID idNumber:(NSString *)idNumber secretID:(NSString *)secretID title:(NSString *)title;

- (void) createCatImageURL;


@end
