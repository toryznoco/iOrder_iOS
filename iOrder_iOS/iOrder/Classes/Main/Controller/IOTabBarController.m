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

@interface IOTabBarController ()<IONavigationControllerDelegate>

@end

@implementation IOTabBarController

#pragma mark - privacy
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

#pragma mark - Custom Methods

- (void)setupViewControllers{
    //点餐
    UIViewController *order = [[IOOrderViewController alloc] init];
    IONavigationController *orderNav = [[IONavigationController alloc] initWithRootViewController:order];
    orderNav.navigationDelegate = self;
    
    //已点菜单
    UIViewController *ordered = [[IOOrderedViewController alloc] init];
    IONavigationController *orderedNav = [[IONavigationController alloc] initWithRootViewController:ordered];
    orderedNav.navigationDelegate = self;
    
    //我的
    UIViewController *profile = [[IOProfileViewController alloc] init];
    IONavigationController *profileNav = [[IONavigationController alloc] initWithRootViewController:profile];
    profileNav.navigationDelegate = self;
    
    //iBeacon
//    UIViewController *iBeacon = [[IOIBeaconViewController alloc] init];
//    UIViewController *iBeaconNav = [[IONavigationController alloc] initWithRootViewController:iBeacon];
    
    [self setViewControllers:@[orderNav, orderedNav, profileNav]];
    [self customizeTabBarForController:self];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController{
    NSArray *tabBarItemImages = @[@"tabbar_home", @"tabbar_order", @"tabbar_profile"];
    NSArray *tabBarItemTitles = @[@"点餐", @"已点菜单", @"我的"];
    
    RDVTabBar *tabBar = [tabBarController tabBar];
    
    [tabBar setFrame:CGRectMake(CGRectGetMinX(tabBar.frame), CGRectGetMinY(tabBar.frame), CGRectGetWidth(tabBar.frame), CGRectGetHeight(tabBar.frame))];
    
    NSUInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
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
    selTitleAttr[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    item.selectedTitleAttributes = selTitleAttr;
    NSMutableDictionary *unselTitleAttr = [NSMutableDictionary dictionary];
    unselTitleAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    unselTitleAttr[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    item.unselectedTitleAttributes = unselTitleAttr;
}

- (void)orderVcWillDisappear:(IOOrderViewController *)orderVc{
    [self setHidesBottomBarWhenPushed:YES];
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

#pragma mark - navigationcontroller delegate

- (void)navigationControllerWillDisappear:(IONavigationController *)navigationVc isHidden:(BOOL)hidden{
    [self setTabBarHidden:hidden animated:YES];
}

@end