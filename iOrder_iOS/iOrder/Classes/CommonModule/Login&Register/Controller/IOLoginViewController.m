//
//  IOLoginViewController.m
//  iOrder
//
//  Created by 易无解 on 8/17/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IOLoginViewController.h"

#import "IOTabBarController.h"
#import "IOGlobalManager.h"
#import "IORegisterViewController.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+YWJ.h"
#import "IOInputTextField.h"
#import "IOLoginManager.h"
#import "IOLoginParam.h"
#import "IOLoginResult.h"
#import "IOAccountTool.h"

@interface IOLoginViewController ()

/** 背景图片 */
@property (nonatomic, weak) UIImageView *backgroundImg;

/** APP图标 */
@property (nonatomic, weak) UIImageView *appIconImg;

/** APP名称图标 */
@property (nonatomic, weak) UIImageView *appNameImg;

/** 用户名 */
@property (nonatomic, weak) IOInputTextField *userName;

/** 密码 */
@property (nonatomic, weak) IOInputTextField *password;

/** 登录按钮 */
@property (nonatomic, weak) UIButton *loginBtn;

/** 注册按钮 */
@property (nonatomic, weak) UIButton *registerBtn;

/** 分割线 */
@property (nonatomic, weak) UIView *partingLine;

/** 帮助按钮 */
@property (nonatomic, weak) UIButton *helpBtn;

@end

@implementation IOLoginViewController

#pragma mark - 系统回调函数

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
    IOInputTextField *userName = [[IOInputTextField alloc] init];
    userName.background = [UIImage imageNamed:@"usename_bar"];
    userName.placeholder = @"username";
    [userName setValue:IORGBColor(111, 95, 97, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textLabelChanged) name:UITextFieldTextDidChangeNotification object:userName];
    [self.view addSubview:userName];
    _userName = userName;
    
//    5、密码输入框
    IOInputTextField *password = [[IOInputTextField alloc] init];
    password.background = [UIImage imageNamed:@"password_bar"];
    password.placeholder = @"password";
    [password setSecureTextEntry:YES];
    [password setValue:IORGBColor(111, 95, 97, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textLabelChanged) name:UITextFieldTextDidChangeNotification object:password];
    [self.view addSubview:password];
    _password = password;
    
//    6、登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bar"]];
    [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    loginBtn.enabled = NO;
    [loginBtn addTarget:self action:@selector(loginBtnDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    _loginBtn = loginBtn;
    
//    7、注册按钮
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"Sign in" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    _registerBtn = registerBtn;
    
//    8、分割线
    UIView *partingLine = [[UIView alloc] init];
    partingLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:partingLine];
    _partingLine = partingLine;
    
//    9、帮助按钮
    UIButton *helpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [helpBtn setTitle:@"Help" forState:UIControlStateNormal];
    [helpBtn addTarget:self action:@selector(helpBtnDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:helpBtn];
    _helpBtn = helpBtn;
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
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(278);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(44);
    }];
    
//    5、密码输入框
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userName.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(44);
    }];
    
//    6、登录按钮
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.password.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(44);
    }];
    
//    7、注册按钮
    [self.partingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-40);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(22);
    }];
    
//    8、分割线
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.partingLine.mas_centerY);
        make.right.mas_equalTo(self.partingLine.mas_left).offset(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(22);
    }];
    
//    9、帮助按钮
    [self.helpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.partingLine.mas_centerY);
        make.left.mas_equalTo(self.partingLine.mas_right).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(22);
    }];
}

- (void)setupNavigationView {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}

#pragma mark - 事件监听函数

- (void)textLabelChanged {
    self.loginBtn.enabled = (self.userName.text.length != 0 && self.password.text.length != 0);
}

- (void)loginBtnDidPressed:(UIButton *)btn {
    // 先开始转菊花
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Change the background view style and color.
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    
    // Set the label text.
    hud.label.text = NSLocalizedString(@"Logining...", @"HUD loading title");
    
    IOLoginParam *param = [[IOLoginParam alloc] init];
    param.account = self.userName.text;
    param.password = self.password.text;
    
    [IOLoginManager loginWithParam:param success:^(IOLoginResult * _Nullable result) {
        IOLog(@"%@", result);
        if (result.result == YES) {
            // 登录成功
            // 保存accessToken及过期时间，refreshToken及过期时间
            [IOAccountTool saveAccessToken:result.accessToken validTime:result.accessTokenTTL];
            [IOAccountTool saveRefreshToken:result.refreshToken validTime:result.refreshTokenTTL];
            
            // 通知主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                // 隐藏菊花
                [hud hideAnimated:YES];
                    [IOGlobalManager enterHome];
            });
        } else {
            // 登录失败
            dispatch_async(dispatch_get_main_queue(), ^{
                // Set the custom view mode to show any view.
                hud.mode = MBProgressHUDModeCustomView;
                // Set an image view with a checkmark.
                UIImage *image = [[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                hud.customView = [[UIImageView alloc] initWithImage:image];
                // Looks a bit nicer if we make it square.
                hud.square = YES;
                // Optional label text.
                hud.label.text = NSLocalizedString(@"Login Failed", @"HUD failed title");
                
                [hud hideAnimated:YES afterDelay:1.5];
            });
        }
    } failure:^(NSError * _Nonnull error) {
        // 登录失败
        dispatch_async(dispatch_get_main_queue(), ^{
            // Set the custom view mode to show any view.
            hud.mode = MBProgressHUDModeCustomView;
            // Set an image view with a checkmark.
            UIImage *image = [[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            hud.customView = [[UIImageView alloc] initWithImage:image];
            // Looks a bit nicer if we make it square.
            hud.square = YES;
            // Optional label text.
            hud.label.text = NSLocalizedString(error.localizedDescription, @"HUD failed title");
            
            [hud hideAnimated:YES afterDelay:1.5];
        });
    }];
}

- (void)registerBtnDidPressed:(UIButton *)btn {
    IORegisterViewController *registerVc = [[IORegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
}

- (void)helpBtnDidPressed:(UIButton *)btn {
    NSLog(@"help....");
}

@end
