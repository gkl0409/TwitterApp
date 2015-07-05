//
//  TwitterClient.h
//  TwitterAPP
//
//  Created by kaden Chiang on 2015/7/4.
//  Copyright (c) 2015年 kaden Chiang. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+(TwitterClient *)sharedInstance;

- (void)loginWithCompletion: (void (^)(User *user, NSError *error)) completion;

- (void)openUrl:(NSURL *)url;


@end
