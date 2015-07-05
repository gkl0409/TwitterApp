//
//  TweetCell.m
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/4.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import "TweetCell.h"
#import <UIImageView+AFNetworking.h>
#import "TwitterClient.h"

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)onReply:(id)sender
{
    [self.delegate tweetCell:self replyTweetId:self.tweet.tweetId];
}

- (IBAction)onRetweet:(id)sender
{
    NSString *retweetUrlString = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", self.tweet.tweetId];
    [[TwitterClient sharedInstance] POST:retweetUrlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate tweetCell:self didUpdateTweet: [[Tweet alloc] initWithDictionary:responseObject]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"onRetweet: %@ fail", retweetUrlString);
    }];
}

- (IBAction)onFavorite:(id)sender
{
    NSString *favoritesUrlString;
    if (self.tweet.favorited) {
        favoritesUrlString = [NSString stringWithFormat:@"1.1/favorites/destroy.json?id=%@", self.tweet.tweetId];
    } else {
        favoritesUrlString = [NSString stringWithFormat:@"1.1/favorites/create.json?id=%@", self.tweet.tweetId];
    }
    [[TwitterClient sharedInstance] POST:favoritesUrlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate tweetCell:self didUpdateTweet: [[Tweet alloc] initWithDictionary:responseObject]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"onFavorite: %@ fail", favoritesUrlString);
    }];
}

- (void)setWithTweet:(Tweet *) tweet
{
    if (tweet != nil) {
        self.tweet = tweet;
        [self.profileImageView.layer setCornerRadius:3.0f];
        [self.profileImageView setClipsToBounds: YES];
        [self.publishTimeLabel setText:[self getDateIntervalString:self.tweet.createdAt]];

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
        
        [self.replyBtn setImage:[UIImage imageNamed:@"reply_hover"] forState:UIControlStateHighlighted];
        [self.retweetBtn setImage:[UIImage imageNamed:@"retweet_hover"] forState:UIControlStateHighlighted];
        [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite_hover"] forState:UIControlStateHighlighted];
        if (self.tweet.favorited) {
            [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite_on"] forState:UIControlStateNormal];
        } else {
            [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
        }
    }
}

- (NSString *)getDateIntervalString:(NSDate *) compareDate
{
    NSTimeInterval diff = [[NSDate date] timeIntervalSinceDate:compareDate];
    
    if (diff > 86400.0f) {
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        formater.dateFormat = @"MM/dd/yyyy";
        return [formater stringFromDate:compareDate];
    } else if (diff > 3600.0f) {
        return [NSString stringWithFormat:@"%ldh", (long)diff/3600];
    } else if (diff > 60.0f) {
        return [NSString stringWithFormat:@"%ldm", (long)diff/60];
    } else {
        return @"Just Now";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
