//
//  TimeLineViewController.h
//  
//
//  Created by kaden Chiang on 2015/7/4.
//
//

#import <UIKit/UIKit.h>
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "TweetViewController.h"
#import "ComposeViewController.h"

@interface TimeLineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TweetCellDelegate, TweetViewControllerDelegate, ComposeViewControllerDelegate>
@property (strong, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) UIRefreshControl *refreshControl;

@end
