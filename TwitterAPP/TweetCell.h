//
//  TweetCell.h
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/4.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetCell;
@protocol TweetCellDelegate<NSObject>
- (void)tweetCell:(TweetCell *)cell didUpdateTweet:(Tweet *)tweet;
- (void)tweetCell:(TweetCell *)cell replyTweetId:(NSString *)tweetId;
@end

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) id<TweetCellDelegate> delegate;
@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *reTweetImageView;
@property (weak, nonatomic) IBOutlet UILabel *reTweetLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@property (weak, nonatomic) IBOutlet UIButton *retweetBtn;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;

- (void)setWithTweet:(Tweet *) tweet;

@end
