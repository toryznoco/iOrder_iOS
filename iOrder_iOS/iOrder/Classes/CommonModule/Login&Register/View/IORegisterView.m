//
//  IORegisterView.m
//  iOrder
//
//  Created by 易无解 on 8/17/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IORegisterView.h"

@interface IORegisterView ()

@property (nonatomic, weak) UIImageView *backgroundImg;
@property (nonatomic, weak) UIImageView *appIconImg;
@property (nonatomic, weak) UIImageView *appNameImg;
@property (nonatomic, weak) IORegisterTextField *phoneNumber;
@property (nonatomic, weak) IORegisterTextField *password;
@property (nonatomic, weak) UITextField *verificationCode;
@property (nonatomic, weak) UIButton *getCodeBtn;
@property (nonatomic, weak) UIButton *registerBtn;

@end

@implementation IORegisterView

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupAllChildView];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - custom

- (void)setupAllChildView {//添加所有子控件
    //    1、背景图片
    UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroud"]];
    [self addSubview:backgroundImg];
    _backgroundImg = backgroundImg;
    
    //    2、图标
    UIImageView *appIconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [self addSubview:appIconImg];
    _appIconImg = appIconImg;
    
    //    3、图标文字
    UIImageView *appNameImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i order"]];
    [self addSubview:appNameImg];
    _appNameImg = appNameImg;
    
    //    4、用户名输入框
    IORegisterTextField *phoneNumber = [[IORegisterTextField alloc] init];
    phoneNumber.background = [UIImage imageNamed:@"phone number_backgroud_frame"];
    phoneNumber.placeholder = @"phone number";
    [phoneNumber setValue:IORGBColor(111, 95, 97, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textLabelChanged) name:UITextFieldTextDidChangeNotification object:phoneNumber];
    [self addSubview:phoneNumber];
    _phoneNumber = phoneNumber;
    
    //    5、密码输入框
    IORegisterTextField *password = [[IORegisterTextField alloc] init];
    password.background = [UIImage imageNamed:@"password_backgroud_frame"];
    password.placeholder = @"password";
    [password setSecureTextEntry:YES];
    [password setValue:IORGBColor(111, 95, 97, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textLabelChanged) name:UITextFieldTextDidChangeNotification object:password];
    [self addSubview:password];
    _password = password;
    
    //    6、验证码输入框
    UITextField *verificationCode = [[UITextField alloc] init];
    verificationCode.background = [UIImage imageNamed:@"Verificationcode_backgroud_frame"];
    verificationCode.placeholder = @"Verification code";
//    verificationCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [verificationCode setValue:IORGBColor(111, 95, 97, 1) forKeyPath:@"_placeholderLabel.textColor"];
//    [verificationCode setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    [self addSubview:verificationCode];
    _verificationCode = verificationCode;
    
    //    7、获取验证码按钮
    UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getCodeBtn setBackgroundImage:[UIImage imageNamed:@"getcode_background_frame"] forState:UIControlStateNormal];
    [getCodeBtn setTitle:@"get code" forState:UIControlStateNormal];
    [self addSubview:getCodeBtn];
    _getCodeBtn = getCodeBtn;
    
    //    8、注册按钮
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.enabled = NO;
    [registerBtn setTitle:@"Sign in" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnDidPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerBtn];
    _registerBtn = registerBtn;
}

- (void)textLabelChanged {
    self.registerBtn.enabled = (self.phoneNumber.text.length != 0 && self.password.text.length != 0);
}

- (void)loginBtnDidPressed:(UIButton *)btn {
    NSLog(@"login....");
}

- (void)registerBtnDidPressed:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(registerView:registerBtnDidPressed:)]) {
        [self.delegate registerView:self registerBtnDidPressed:btn];
    }
}

- (void)helpBtnDidPressed:(UIButton *)btn {
    NSLog(@"help....");
}

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.backgroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
    }];
    
    [self.appIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(65);
        make.centerX.equalTo(self);
        make.width.equalTo(@99);
        make.height.equalTo(@102);
    }];
    
    [self.appNameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appIconImg.mas_bottom).offset(20);
        make.centerX.equalTo(self);
        make.width.equalTo(@80);
        make.height.equalTo(@18);
    }];
    
    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(278);
        make.centerX.equalTo(self);
        make.width.equalTo(@300);
        make.height.equalTo(@44);
    }];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNumber.mas_bottom).offset(30);
        make.centerX.equalTo(self);
        make.width.equalTo(@300);
        make.height.equalTo(@44);
    }];
    
    [self.verificationCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.password.mas_bottom).offset(25);
        make.left.equalTo(self.password.mas_left);
        make.width.equalTo(@130);
        make.height.equalTo(@43);
    }];
    
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.password.mas_bottom).offset(25);
        make.right.equalTo(self.password.mas_right);
        make.width.equalTo(@130);
        make.height.equalTo(@43);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verificationCode.mas_bottom).offset(25);
        make.centerX.equalTo(self);
        make.width.equalTo(@80);
        make.height.equalTo(@22);
    }];
    
    [super updateConstraints];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


#pragma mark - implementation IORegisterTextField

@implementation IORegisterTextField

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17, 0)];//设置文字距左边框的位置
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return self;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {//控制placeholder的位置
    return CGRectMake(17, 0, 270, 44);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {//控制光标的位置
    return CGRectMake(17, 0, 270, 44);
}

@end
