//
//  TweetDetail1Cell.m
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/5.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import "TweetDetail1Cell.h"

@implementation TweetDetail1Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setWithTweet:(Tweet *) tweet
{
    self.retweetsCountLabel.text = [NSString stringWithFormat:@"%ld", tweet.retweetCount];
    self.favoritesCountLabel.text = [NSString stringWithFormat:@"%ld", tweet.favouritesCount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
