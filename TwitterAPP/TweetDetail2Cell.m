//
//  TweetDetail2Cell.m
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/5.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import "TweetDetail2Cell.h"
#import "TwitterClient.h"

@implementation TweetDetail2Cell

- (void)awakeFromNib {

}

- (IBAction)onReply:(id)sender {

}

- (IBAction)onRetweet:(id)sender
{
    NSString *retweetUrlString = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", self.tweet.tweetId];
    [[TwitterClient sharedInstance] POST:retweetUrlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate tweetDetail2Cell:self didUpdateTweet:[[Tweet alloc] initWithDictionary:responseObject]];        
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
        [self.delegate tweetDetail2Cell:self didUpdateTweet:[[Tweet alloc] initWithDictionary:responseObject]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"onFavorite: %@ fail", favoritesUrlString);
    }];
}

- (void)setWithTweet:(Tweet *) tweet
{
    if (tweet != nil) {
        self.tweet = tweet;
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
