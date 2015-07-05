//
//  TweetController.m
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/5.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import "TweetViewController.h"
#import <UIImageView+AFNetworking.h>

@interface TweetViewController ()

@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tweetDetail2Cell:(TweetDetail2Cell *)cell didUpdateTweet:(Tweet *)tweet
{
    self.tweet = tweet;
    [self.delegate tweetViewController:self didUpdateTweet:self.tweet];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier: [NSString stringWithFormat: @"TweetCell%ld", indexPath.row]
                             forIndexPath:indexPath
                             ];
    if (indexPath.row == 0) {
        TweetDetail0Cell *tweetDetail0Cell = (TweetDetail0Cell *)cell;
        [tweetDetail0Cell setWithTweet:self.tweet];
    } else if (indexPath.row == 1) {
        TweetDetail1Cell *tweetDetail1Cell = (TweetDetail1Cell *)cell;
        [tweetDetail1Cell setWithTweet:self.tweet];
    
    } else if (indexPath.row == 2) {
        TweetDetail2Cell *tweetDetail2Cell = (TweetDetail2Cell *)cell;
        [tweetDetail2Cell setWithTweet:self.tweet];
        tweetDetail2Cell.delegate = self;

    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 3) return 1024.0f;
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 3) return 1024.0f;
    return UITableViewAutomaticDimension;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
