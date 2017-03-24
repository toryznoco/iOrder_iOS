//
//  IORegisterViewController.m
//  iOrder
//
//  Created by 易无解 on 8/17/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IORegisterViewController.h"

#import "IORegisterView.h"

#import "IORegisterManager.h"
#import "IORegisterParam.h"

@interface IORegisterViewController ()<IORegisterViewDelegate>

/** 注册视图 */
@property (nonatomic, weak) IORegisterView *registerView;

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
    _registerView = registerView;
}

#pragma mark - Private
- (void)doRegister {
//    [IORegisterManager registerWithParam:]
}

#pragma mark - IORegisterViewDelegate

- (void)registerView:(IORegisterView *)registerView registerBtnDidPressed:(UIButton *)regitserBtn {
//    [self.navigationController popViewControllerAnimated:YES];
    
    // 处理注册
//    IORegisterParam *param = [IORegisterParam paramWith];
    [self doRegister];
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
