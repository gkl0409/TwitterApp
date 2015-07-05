//
//  TwitterClient.m
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/4.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"vHYm7sh9fdp0AMVF2PMPncWXv";
NSString * const kTwitterConsumerSecret = @"llsAliLeRDEtRwly4SGg9ynVa2OoANV7MylroAwlHrsiEj0QuE";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);
@end


@implementation TwitterClient

+(TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    
    return instance;
}

- (void)loginWithCompletion: (void (^)(User *user, NSError *error)) completion
{
    self.loginCompletion = completion;

    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"kdnTwitterApp://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"request token %@", requestToken.token);
        NSURL *authURL = [NSURL URLWithString: [NSString stringWithFormat: @"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];
        
    } failure:^(NSError *error) {
        self.loginCompletion(nil, error);
    }];

}

- (void)openUrl:(NSURL *)url
{
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken: [BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"got access token %@", accessToken.token);
        [self.requestSerializer saveAccessToken:accessToken];
        
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            User *user = [[User alloc] initWithDictionary:responseObject];
            NSLog(@"current user: %@", user.name);
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"fail to get current user");
        }];
    } failure:^(NSError *error) {
        NSLog(@"fial to get access token %@", error.localizedDescription);
        self.loginCompletion(nil, error);
    }];

}

@end
