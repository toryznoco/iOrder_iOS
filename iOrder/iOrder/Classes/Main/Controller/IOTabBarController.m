//
//  IOTabBarController.m
//  iOrder
//
//  Created by 易无解 on 4/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOTabBarController.h"

#import "RDVTabBarController.h"
#import "IOOrderViewController.h"
#import "IOOrderedViewController.h"
#import "IOProfileViewController.h"
#import "IOIBeaconViewController.h"
#import "IONavigationController.h"

#import "RDVTabBarItem.h"

@interface IOTabBarController ()

@end

@implementation IOTabBarController

#pragma mark - self
- (instancetype)init{
    if (self = [super init]) {
//        设置所有的子控制器
        [self setupViewControllers];
//        设置tabbar的富文本属性
        [self setupTabBarTitleAttri];
        [self customizeInterface];
    }
    return self;
}

- (void)setupViewControllers{
    //点餐
    UIViewController *order = [[IOOrderViewController alloc] init];
    UIViewController *orderNav = [[IONavigationController alloc] initWithRootViewController:order];
    
    //已点菜单
    UIViewController *ordered = [[IOOrderedViewController alloc] init];
    UIViewController *orderedNav = [[IONavigationController alloc] initWithRootViewController:ordered];
    
    //我的
    UIViewController *profile = [[IOProfileViewController alloc] init];
    UIViewController *profileNav = [[IONavigationController alloc] initWithRootViewController:profile];
    
    //iBeacon
    UIViewController *iBeacon = [[IOIBeaconViewController alloc] init];
    UIViewController *iBeaconNav = [[IONavigationController alloc] initWithRootViewController:iBeacon];
    
    [self setViewControllers:@[orderNav, orderedNav, profileNav, iBeaconNav]];
    [self customizeTabBarForController:self];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController{
    UIImage *finishiedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishiedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third", @"four"];
    NSArray *tabBarItemTitles = @[@"点餐", @"已点菜单", @"我的", @"iBeacon"];
    
    RDVTabBar *tabBar = [tabBarController tabBar];
    
    [tabBar setFrame:CGRectMake(CGRectGetMinX(tabBar.frame), CGRectGetMinY(tabBar.frame), CGRectGetWidth(tabBar.frame), CGRectGetHeight(tabBar.frame))];
    
    NSUInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishiedImage withUnselectedImage:unfinishiedImage];
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal", [tabBarItemImages objectAtIndex:index]]];
        
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
        
        index++;
    }
}

- (void)setupTabBarTitleAttri{
    RDVTabBarItem *item = [RDVTabBarItem appearanceWhenContainedInInstancesOfClasses:@[[super class]]];
    NSMutableDictionary *selTitleAttr = [NSMutableDictionary dictionary];
    selTitleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    item.selectedTitleAttributes = selTitleAttr;
    NSMutableDictionary *unselTitleAttr = [NSMutableDictionary dictionary];
    unselTitleAttr[NSForegroundColorAttributeName] = [UIColor blackColor];
    item.unselectedTitleAttributes = unselTitleAttr;
}

- (void)customizeInterface{
#warning comprehension later
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

@end