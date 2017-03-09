//
//  IORegisterViewController.m
//  iOrder
//
//  Created by 易无解 on 8/17/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IORegisterViewController.h"

#import "IORegisterView.h"

@interface IORegisterViewController ()<IORegisterViewDelegate>

@end

@implementation IORegisterViewController

#pragma mark - privacy

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
//    去除导航栏下方的横线 透明
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - custom

- (void)refreshView {//刷新view
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupAllChildView];
}

- (void)setupAllChildView {//添加所有子视图
    IORegisterView *registerView = [[IORegisterView alloc] initWithFrame:self.view.frame];
    registerView.delegate = self;
    [self.view addSubview:registerView];
}

#pragma mark - IORegisterViewDelegate

- (void)registerView:(IORegisterView *)registerView registerBtnDidPressed:(UIButton *)regitserBtn {
    [self.navigationController popViewControllerAnimated:YES];
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
