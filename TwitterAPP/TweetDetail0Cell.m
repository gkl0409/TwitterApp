//
//  TweetDetail0Cell.m
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/5.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import "TweetDetail0Cell.h"
#import <UIImageView+AFNetworking.h>

@implementation TweetDetail0Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setWithTweet:(Tweet *) tweet
{
    if (tweet != nil) {
        self.tweet = tweet;
        [self.profileImageView.layer setCornerRadius:3.0f];
        [self.profileImageView setClipsToBounds: YES];
        [self.publishTimeLabel setText:[self getPublishDateString:self.tweet.createdAt]];
        
        if ([self.tweet retweetUser] != nil) {
            [self.reTweetLabel setHidden:NO];
            [self.reTweetLabel setText:[NSString stringWithFormat:@"%@ retweeted", [self.tweet.user name]]];
            
            for (NSLayoutConstraint *constraint in [self.reTweetImageView constraints]) {
                if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                    constraint.constant = 16;
                }
            }
            [self.profileImageView
             setImageWithURL:[NSURL URLWithString:[self.tweet.retweetUser profileImageUrl]]
             ];
            [self.nameLabel setText:[self.tweet.retweetUser name]];
            [self.screenNameLabel setText:[NSString stringWithFormat:@"@%@", [self.tweet.retweetUser screenName]]];
            [self.tweetTextLabel setText:self.tweet.text];
            
        } else {
            [self.reTweetLabel setHidden:YES];
            
            for (NSLayoutConstraint *constraint in [self.reTweetImageView constraints]) {
                if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                    constraint.constant = 0;
                }
            }
            
            [self.profileImageView
             setImageWithURL:[NSURL URLWithString:[self.tweet.user profileImageUrl]]
             ];
            [self.nameLabel setText:[self.tweet.user name]];
            [self.screenNameLabel setText:[NSString stringWithFormat:@"@%@", [self.tweet.user screenName]]];
            [self.tweetTextLabel setText:self.tweet.text];
        }
    }
}

- (NSString *)getPublishDateString:(NSDate *) publishDate
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"M/d/yyyy hh:mm:ss a";
    return [formater stringFromDate:publishDate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
