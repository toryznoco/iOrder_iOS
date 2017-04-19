//
//  IOShoppingCartAnimator.h
//  iOrder
//
//  Created by 易无解 on 13/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ShoppingCartAnimatorBlock)(BOOL presented);

@interface IOShoppingCartAnimator : NSObject<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

/** 是否弹出 */
@property (nonatomic, assign) BOOL isPresented;

/** 弹出框的frame */
@property (nonatomic, assign) CGRect presentedFrame;

@property (nonatomic, strong) ShoppingCartAnimatorBlock callBack;

- (instancetype)initWithCallBack:(ShoppingCartAnimatorBlock)callBack;

@end
