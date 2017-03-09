//
//  IOProfileMyCollectController.m
//  iOrder
//
//  Created by 易无解 on 8/29/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IOProfileMyCollectController.h"

#import "IOProfileMyCollectView.h"

@interface IOProfileMyCollectController ()

@end

@implementation IOProfileMyCollectController

#pragma mark - privace

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupAllChildView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    //去除导航栏下方的横线 透明
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBGI_2"] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage imageNamed:@"navigationBGI_1"]];
}

#pragma mark - public

#pragma mark - custom

- (void)setupAllChildView {
    IOProfileMyCollectView *collectView = [[IOProfileMyCollectView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:collectView];
}

@end
