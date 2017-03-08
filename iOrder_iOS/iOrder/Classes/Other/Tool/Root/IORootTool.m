//
//  IORootTool.m
//  iOrder
//
//  Created by Tory on 08/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IORootTool.h"

@implementation IORootTool

+ (void)changeRootViewControllerTo:(UIViewController *)vc {
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

@end
