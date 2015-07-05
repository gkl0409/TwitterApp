//
//  User.m
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/4.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithDictionary: (NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.tagline = dictionary[@"description"];
    }
    return self;
}

@end
