//
//  IOSingInViewController.m
//  iOrder
//
//  Created by Tory on 16/5/18.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import "IOSingInViewController.h"
#import "IOSignInHeaderView.h"

@interface IOSingInViewController ()

@property (nonatomic, weak) UIView *signInHeaderView;
@property (nonatomic, weak) UIView *calendarView;

@end

@implementation IOSingInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initHeaderView];
    
    //  检测摇一摇
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
}

- (void)initHeaderView {
    IOSignInHeaderView *signInHeaderView = [[IOSignInHeaderView alloc] initWithFrame:CGRectMake(0, 0, IOScreenWidth, 342)];
    [self.view addSubview:signInHeaderView];
    _signInHeaderView = signInHeaderView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//然后去实现那几个方法就可以了

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    //  检测到摇动
    NSLog(@"摇了");
    
}



- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //  摇动取消
    NSLog(@"摇动取消");
}



- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //  摇动结束
    if (event.subtype == UIEventSubtypeMotionShake) {
        NSLog(@"摇完了");
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"签到成功^_^" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
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
