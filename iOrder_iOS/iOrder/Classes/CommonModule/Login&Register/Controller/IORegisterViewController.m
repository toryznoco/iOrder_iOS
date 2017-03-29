//
//  IORegisterViewController.m
//  iOrder
//
//  Created by 易无解 on 8/17/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IORegisterViewController.h"
#import "IOInputTextField.h"
#import "IORegisterManager.h"
#import "IORegisterResult.h"
#import "MBProgressHUD+YWJ.h"

@interface IORegisterViewController ()

/** 背景图片 */
@property (nonatomic, weak) UIImageView *backgroundImg;

/** APP图标 */
@property (nonatomic, weak) UIImageView *appIconImg;

/** APP名称图标 */
@property (nonatomic, weak) UIImageView *appNameImg;

/** 手机号码 */
@property (nonatomic, weak) IOInputTextField *phoneNumber;

/** 密码 */
@property (nonatomic, weak) IOInputTextField *password;

/** 验证码 */
@property (nonatomic, weak) UITextField *verificationCode;

/** 获取验证码按钮 */
@property (nonatomic, weak) UIButton *getCodeBtn;

/** 注册按钮 */
@property (nonatomic, weak) UIButton *registerBtn;

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
    
//    1.添加子控件
    [self setupAllSubView];
    
//    2.设置约束
    [self setupConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 设置界面相关
- (void)setupAllSubView {//添加所有子控件
    //    1、背景图片
    UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroud"]];
    [self.view addSubview:backgroundImg];
    _backgroundImg = backgroundImg;
    
    //    2、图标
    UIImageView *appIconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:appIconImg];
    _appIconImg = appIconImg;
    
    //    3、图标文字
    UIImageView *appNameImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i order"]];
    [self.view addSubview:appNameImg];
    _appNameImg = appNameImg;
    
    //    4、用户名输入框
    IOInputTextField *phoneNumber = [[IOInputTextField alloc] init];
    phoneNumber.background = [UIImage imageNamed:@"phone number_backgroud_frame"];
    phoneNumber.placeholder = @"phone number";
    [phoneNumber setValue:IORGBColor(111, 95, 97, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textLabelChanged) name:UITextFieldTextDidChangeNotification object:phoneNumber];
    [self.view addSubview:phoneNumber];
    _phoneNumber = phoneNumber;
    
    //    5、密码输入框
    IOInputTextField *password = [[IOInputTextField alloc] init];
    password.background = [UIImage imageNamed:@"password_backgroud_frame"];
    password.placeholder = @"password";
    [password setSecureTextEntry:YES];
    [password setValue:IORGBColor(111, 95, 97, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textLabelChanged) name:UITextFieldTextDidChangeNotification object:password];
    [self.view addSubview:password];
    _password = password;
    
    //    6、验证码输入框
    UITextField *verificationCode = [[UITextField alloc] init];
    verificationCode.background = [UIImage imageNamed:@"Verificationcode_backgroud_frame"];
    verificationCode.placeholder = @"Verification code";
    //    verificationCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [verificationCode setValue:IORGBColor(111, 95, 97, 1) forKeyPath:@"_placeholderLabel.textColor"];
    //    [verificationCode setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:verificationCode];
    _verificationCode = verificationCode;
    
    //    7、获取验证码按钮
    UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getCodeBtn setBackgroundImage:[UIImage imageNamed:@"getcode_background_frame"] forState:UIControlStateNormal];
    [getCodeBtn setTitle:@"get code" forState:UIControlStateNormal];
    [self.view addSubview:getCodeBtn];
    _getCodeBtn = getCodeBtn;
    
    //    8、注册按钮
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.enabled = NO;
    [registerBtn setTitle:@"Sign in" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    _registerBtn = registerBtn;
}

#pragma mark - 约束相关
- (void)setupConstraints {
    //    1、背景图片
    [self.backgroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(@0);
    }];
    //    2、图标
    [self.appIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(65);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(99);
        make.height.mas_equalTo(102);
    }];
    
    //    3、图标文字
    [self.appNameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.appIconImg.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(18);
    }];
    
    //    4、用户名输入框
    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(278);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(44);
    }];
    
    //    5、密码输入框
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneNumber.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(44);
    }];
    
    //    6、验证码输入框
    [self.verificationCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.password.mas_bottom).offset(25);
        make.left.mas_equalTo(self.password.mas_left);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(43);
    }];
    
    //    7、获取验证码按钮
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.password.mas_bottom).offset(25);
        make.right.mas_equalTo(self.password.mas_right);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(43);
    }];
    
    //    8、注册按钮
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verificationCode.mas_bottom).offset(25);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(22);
    }];
}
#pragma mark - 事件监听函数

- (void)textLabelChanged {
    self.registerBtn.enabled = (self.phoneNumber.text.length != 0 && self.password.text.length != 0);
}

- (void)registerBtnDidPressed:(UIButton *)btn {
    NSLog(@"register....");
    //1.创建json参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"mobile"] = self.phoneNumber.text;
    param[@"password"] = self.password.text;
    
    //2.发送注册请求
    [IORegisterManager registerWithParam:param success:^(IORegisterResult * _Nullable result) {
        NSLog(@"%d %ld %@", result.result, result.code, result.message);
        if (result.code == 2000) {
            [MBProgressHUD showSuccess:result.message];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showError:result.message];
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)helpBtnDidPressed:(UIButton *)btn {
    NSLog(@"help....");
}

@end
