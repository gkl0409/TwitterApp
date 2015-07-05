//
//  TweetController.h
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/5.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetDetail0Cell.h"
#import "TweetDetail1Cell.h"
#import "TweetDetail2Cell.h"

@class TweetViewController;

@protocol TweetViewControllerDelegate <NSObject>

- (void)tweetViewController: (TweetViewController *)viewController didUpdateTweet:(Tweet *)tweet;

@end

@interface TweetViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TweetDetail2CellDelegate>

@property (nonatomic, weak) id<TweetViewControllerDelegate> delegate;
@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
