//
//  IONavigationController.m
//  iOrder
//
//  Created by 易无解 on 4/9/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IONavigationController.h"

@interface IONavigationController ()<UINavigationControllerDelegate>

@end

@implementation IONavigationController

#pragma mark - YWJNavigationController

+ (void)initialize {
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}
//
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    //    设置代理
    self.delegate = self;
}

//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//

//#pragma mark - Navigation Controller
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //    获取主窗口的rootViewController, 即tabBarController
    UITabBarController *tabBarC = (UITabBarController *)IOKeyWindow.rootViewController;
    
    //    移除系统的tabBarButton
    for (UIView *tabBarButton in tabBarC.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
    if (viewController != self.viewControllers[0]) {
        if ([_navigationDelegate respondsToSelector:@selector(navigationControllerWillDisappear:isHidden:)]) {
            [_navigationDelegate navigationControllerWillDisappear:self isHidden:YES];
        }
    } else {
        if ([_navigationDelegate respondsToSelector:@selector(navigationControllerWillDisappear:isHidden:)]) {
            [_navigationDelegate navigationControllerWillDisappear:self isHidden:NO];
        }
    }
}

@end
