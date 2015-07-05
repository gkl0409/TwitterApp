//
//  TimeLineViewController.m
//  
//
//  Created by kaden Chiang on 2015/7/4.
//
//

#import "TimeLineViewController.h"
#import <UIImageView+AFNetworking.h>

@interface TimeLineViewController ()

@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) NSIndexPath *seletedIndexPath;

@end

@implementation TimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.refreshControl addTarget:self action:@selector(callTimeLineApi) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)callTimeLineApi {
    [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.tweets = [NSMutableArray arrayWithArray:[Tweet tweetsWithArray:responseObject]];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"faill to load timeline: %@", [error localizedDescription]);
    }];
}

- (IBAction)onLogin:(id)sender {
    if (self.user == nil) {
        [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
            if (user != nil) {
                self.user = user;
                [self.navigationItem.leftBarButtonItem setTitle:@"Log Out"];
                [self callTimeLineApi];
            } else {
                NSLog(@"Fail to get request token: %@", [error localizedDescription]);
            }
        }];
    } else {
        self.user = nil;
        self.tweets = nil;
        [self.navigationItem.leftBarButtonItem setTitle:@"Log In"];
        [self.tableView reloadData];
    }
    
}

- (IBAction)onNew:(id)sender
{
    NSLog(@"%@", self.user);
    if (self.user == nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Login" message: @"please login first!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
    } else {
        // sender replyTweetId
        [self performSegueWithIdentifier:@"segueCompose" sender:nil];
    }
}

- (void)tweetCell:(TweetCell *)cell replyTweetId:(NSString *)tweetId
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self performSegueWithIdentifier:@"segueCompose" sender:indexPath];
}

- (void)tweetCell:(TweetCell *)cell didUpdateTweet:(Tweet *)tweet
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tweets replaceObjectAtIndex:indexPath.row withObject:tweet];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tweetViewController:(TweetViewController *)viewController didUpdateTweet:(Tweet *)tweet
{
    [self.tweets replaceObjectAtIndex:self.seletedIndexPath.row withObject:tweet];
    [self.tableView reloadRowsAtIndexPaths:@[self.seletedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)composeViewController:(ComposeViewController *)viewController composedTweet:(Tweet *)tweet
{
    [self.tweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.delegate = self;
    [cell setWithTweet: self.tweets[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.seletedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"segueTweet" sender:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    if ([[segue identifier] isEqualToString:@"segueTweet"]) {
        TweetViewController *vc = (TweetViewController *)[segue destinationViewController];
        vc.delegate = self;
        
        vc.tweet = self.tweets[indexPath.row];
    } else if ([[segue identifier] isEqualToString:@"segueCompose"]) {
        UINavigationController *nvc = (UINavigationController *)[segue destinationViewController];
        ComposeViewController *vc = (ComposeViewController *)nvc.viewControllers[0];
        vc.delegate = self;
        vc.user = self.user;
        vc.inReplyToStatusId = [self.tweets[indexPath.row] tweetId];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
