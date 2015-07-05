//
//  TweetDetail2Cell.h
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/5.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetDetail2Cell;
@protocol TweetDetail2CellDelegate<NSObject>
- (void)tweetDetail2Cell:(TweetDetail2Cell *)cell didUpdateTweet:(Tweet *)tweet;
@end

@interface TweetDetail2Cell : UITableViewCell

@property (weak, nonatomic) id<TweetDetail2CellDelegate> delegate;
@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@property (weak, nonatomic) IBOutlet UIButton *retweetBtn;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;

- (void)setWithTweet:(Tweet *) tweet;

@end
