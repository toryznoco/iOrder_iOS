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

#import <AudioToolbox/AudioToolbox.h>

extern BOOL isInRegion;

//  尺寸
#define kIOTopMargin 10
#define kIOFooterViewHeight 60

@interface IOSingInViewController () <FSCalendarDelegate, FSCalendarDataSource>

@property (nonatomic, weak) UIView *signInHeaderView;
@property (nonatomic, weak) FSCalendar *calendarView;
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
    
    //  设置外观
    calendarView.appearance.titleTodayColor = [UIColor redColor];
    calendarView.appearance.todayColor = nil;
    calendarView.appearance.selectionColor = [UIColor greenColor];
    calendarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:calendarView];
    self.calendarView = calendarView;
    
    //  设置选中日
    NSDate *yesterday = [self.calendarView yesterdayOfDate:self.calendarView.today];
    [self.calendarView selectDate:yesterday];
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
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date {
    return NO;
}

#pragma mark - 摇一摇方法
//  摇动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //  震动效果
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    if (event.subtype == UIEventSubtypeMotionShake) {
        NSString *message = nil;
        //  判断是否在区域
        if (isInRegion) { //  在区域
            //  判断是否已经被选中
            for (NSDate *date in self.calendarView.selectedDates) {
                if (date == self.calendarView.today) {
                    message = @"今天已经签过到了，明天继续加油噢！^_^";
                    break;
                }
            }
            //  没有在已选中找到，就签到
            if (message == nil) {
                message = @"签到成功！^_^";
                [self.calendarView selectDate:self.calendarView.today];
            }
        } else {    //  不在区域
            message = @"当前未处在签到区域。";
        }
        
        //  显示提示
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

@end
