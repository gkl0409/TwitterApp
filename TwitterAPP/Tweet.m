//
//  Tweet.m
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/4.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary: (NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.tweetId = dictionary[@"id_str"];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        formater.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formater dateFromString:createdAtString];
        self.retweetCount = [dictionary[@"retweet_count"] integerValue];
        self.favouritesCount = [dictionary[@"favorite_count"] integerValue];
        
        if (dictionary[@"retweeted_status"] != nil) {
            NSDictionary *retweeted = dictionary[@"retweeted_status"];
            self.retweetUser = [[User alloc] initWithDictionary:retweeted[@"user"]];
            createdAtString = retweeted[@"created_at"];
            self.retweetCreatedAt = [formater dateFromString:createdAtString];
            self.retweetText = retweeted[@"text"];
        }
    }
    return self;
}

+ (NSArray *)tweetsWithArray: (NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [tweets addObject: [[Tweet alloc] initWithDictionary:dic]];
    }
    return tweets;
}

@end
