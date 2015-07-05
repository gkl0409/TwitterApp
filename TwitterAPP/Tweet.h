//
//  Tweet.h
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/4.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *tweetId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSDate *retweetCreatedAt;
@property (nonatomic, strong) User *retweetUser;
@property (nonatomic, strong) NSString *retweetText;
@property (nonatomic, assign) NSInteger retweetCount;
@property (nonatomic, assign) NSInteger favouritesCount;


- (id)initWithDictionary: (NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray: (NSArray *)array;

@end
