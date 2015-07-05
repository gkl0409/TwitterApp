//
//  ComposeViewController.m
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/5.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import "ComposeViewController.h"
#import <UIImageView+AFNetworking.h>
#import "TwitterClient.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameLabel setText:self.user.name];
    [self.screenNameLabel setText: [NSString stringWithFormat:@"@%@",self.user.screenName]];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    [self.composeTextView becomeFirstResponder];
}
- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTweet:(id)sender {

    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [self.composeTextView.text stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] > 0) {
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"status": self.composeTextView.text}];
        if (self.inReplyToStatusId != nil) {
            [param setObject:self.inReplyToStatusId forKey:@"in_reply_to_status_id"];
        }
        [[TwitterClient sharedInstance] POST:@"1.1/statuses/update.json" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.delegate composeViewController:self composedTweet:[[Tweet alloc] initWithDictionary:responseObject]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tweet" message: @"Success!"delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alertView show];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"statuses update fail :%@", [error localizedDescription]);
        }];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Input" message: @"Empty or Only Spaces ?" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
