//
//  ComposeViewController.h
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/5.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Tweet.h"

@class ComposeViewController;
@protocol ComposeViewControllerDelegate <NSObject>

- (void)composeViewController: (ComposeViewController *)viewController composedTweet: (Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) id<ComposeViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *composeTextView;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *inReplyToStatusId;

@end
