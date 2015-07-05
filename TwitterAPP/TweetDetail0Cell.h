//
//  TweetDetail0Cell.h
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/5.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetDetail0Cell : UITableViewCell

@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *reTweetImageView;
@property (weak, nonatomic) IBOutlet UILabel *reTweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;

- (void)setWithTweet:(Tweet *) tweet;

@end
