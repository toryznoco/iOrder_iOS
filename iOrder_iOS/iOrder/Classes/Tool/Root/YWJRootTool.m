//
//  YWJRootTool.m
//  iOrder
//
//  Created by 易无解 on 4/9/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJRootTool.h"

#import "YWJRootNavigationViewController.h"
#import "IONewFeatureViewController.h"
#import "IOLoginViewController.h"
#import "YWJVersionTool.h"

@implementation YWJRootTool

#pragma mark - self
+ (void)chooseRootViewController:(UIWindow *)window {
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
//    
//    NSString *lastVersion = [YWJVersionTool currentVersion];
//    
//    if ([currentVersion isEqualToString:lastVersion]) {
    IOLoginViewController *loginVc = [[IOLoginViewController alloc] init];
    YWJRootNavigationViewController *loginNav = [[YWJRootNavigationViewController alloc] initWithRootViewController:loginVc];
    window.rootViewController = loginNav;
//        window.rootViewController = [[IOTabBarController alloc] init];
//    }else{
//        window.rootViewController = [[IONewFeatureViewController alloc] init];
//        [YWJVersionTool saveVersion:currentVersion];
//    }
}

@end
