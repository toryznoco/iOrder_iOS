//
//  IOSingInViewController.m
//  iOrder
//
//  Created by Tory on 16/5/18.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import "IOSingInViewController.h"
#import "IOSignInHeaderView.h"
#import "FSCalendar.h"
#import "IOSignInFooterView.h"

//  尺寸
#define kIOTopMargin 10
#define kIOFooterViewHeight 60

//  颜色
#define kIOBackgroundColor [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0]

@interface IOSingInViewController () <FSCalendarDelegate, FSCalendarDataSource>

@property (nonatomic, weak) UIView *signInHeaderView;
@property (nonatomic, weak) UIView *calendarView;
@property (nonatomic, weak) UIView *signInFooterView;

@end

@implementation IOSingInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kIOBackgroundColor;
    
    [self initHeaderView];
    [self initCalendarView];
    [self initFooterView];
    
    //  检测摇一摇
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
}

- (void)initHeaderView {
    IOSignInHeaderView *signInHeaderView = [[IOSignInHeaderView alloc] initWithFrame:CGRectMake(0, kIONavigationBarHeight, IOScreenWidth, (IOScreenHeight-kIONavigationBarHeight-kIOFooterViewHeight-kIOTopMargin)*0.5)];
    [self.view addSubview:signInHeaderView];
    _signInHeaderView = signInHeaderView;
}

- (void)initCalendarView {
    FSCalendar *calendarView = [[FSCalendar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_signInHeaderView.frame)+kIOTopMargin, IOScreenWidth, (IOScreenHeight-kIONavigationBarHeight-kIOFooterViewHeight-kIOTopMargin)*0.5)];
    calendarView.dataSource = self;
    calendarView.delegate = self;
    calendarView.allowsMultipleSelection = YES;
    calendarView.appearance.titleTodayColor = [UIColor redColor];
    calendarView.appearance.todayColor = nil;
    calendarView.appearance.selectionColor = [UIColor greenColor];
    
    calendarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:calendarView];
    self.calendarView = calendarView;
}

- (void)initFooterView {
    IOSignInFooterView *signInFooterView = [[IOSignInFooterView alloc] initWithFrame:CGRectMake(0, IOScreenHeight-kIOFooterViewHeight, IOScreenWidth, kIOFooterViewHeight)];
    [self.view addSubview:signInFooterView];
    _signInFooterView = signInFooterView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FSCalendarDelegate


#pragma mark - 摇一摇方法
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //  摇动结束
    if (event.subtype == UIEventSubtypeMotionShake) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"签到成功^_^" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
}

@end
