//
//  IOShoppingCartAnimator.m
//  iOrder
//
//  Created by 易无解 on 13/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOShoppingCartAnimator.h"

#import "IOPresentationController.h"

@interface IOShoppingCartAnimator ()

@end

@implementation IOShoppingCartAnimator

#pragma mark - 系统回调函数

- (instancetype)init {
    if (self = [super init]) {
        _isPresented = NO;
    }
    
    return self;
}

#pragma mark - 外部属性

- (instancetype)initWithCallBack:(ShoppingCartAnimatorBlock)callBack {
    if (self = [self init]) {
        self.callBack = callBack;
    }
    
    return self;
}

- (void)setPresentedFrame:(CGRect)presentedFrame {
    _presentedFrame = presentedFrame;
}

#pragma mark - UIViewControllerTransitioningDelegate

/** 改变弹出View的尺寸 */
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    IOPresentationController *presentationVc = [[IOPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentationVc.presentedFrame = self.presentedFrame;
    return presentationVc;
}

/** 自定义弹出的动画 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresented = YES;
    self.callBack(self.isPresented);
    return self;
}

/** 自定义消失的动画 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresented = NO;
    self.callBack(self.isPresented);
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

/** 动画执行的时间 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

/** 获取‘转场上下文’：通过转场上下文获取弹出的View和消失的View */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.isPresented == YES ? [self animationForpresentedView:transitionContext] : [self animationForDismissedView:transitionContext];
}

/** 自定义弹出动画 */
- (void)animationForpresentedView:(id<UIViewControllerContextTransitioning>)transitionContext {
//    1.获取弹出的View
    UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
//    2.将弹出的View添加到containerView中
    [transitionContext.containerView addSubview:presentedView];
    
//    3.执行动画
    presentedView.transform = CGAffineTransformMakeScale(1.0, 0.0);
    presentedView.layer.anchorPoint = CGPointMake(0.5, 1);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        presentedView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
//        告诉上下文已完成转场动画
        [transitionContext completeTransition:YES];
    }];
}

/** 自定义消失动画 */
- (void)animationForDismissedView:(id<UIViewControllerContextTransitioning>)transitionContext {
//    1.获取消失的View
    UIView *dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
//    2.执行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        dismissView.transform = CGAffineTransformMakeScale(1.0, 0.000001);
    } completion:^(BOOL finished) {
        [dismissView removeFromSuperview];
//        告诉上下文已完成转场动画
        [transitionContext completeTransition:YES];
    }];
}

@end
