//
//  IORootTool.h
//  iOrder
//
//  Created by Tory on 08/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IORootTool : NSObject

/**
 改变主窗口的根控制器

 @param vc 新的根控制器
 */
+ (void)changeRootViewControllerTo:(UIViewController *)vc;

@end
