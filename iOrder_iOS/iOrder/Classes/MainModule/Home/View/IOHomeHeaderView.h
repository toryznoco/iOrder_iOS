//
//  IOHomeView.h
//  iOrder
//
//  Created by 易无解 on 5/17/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - interface IOHomeHeaderView
@interface IOHomeHeaderView : UIView

@end


#pragma mark - interface IOScrollView
@interface IOScrollView : UIView

@property (nonatomic, strong) NSArray *images;

@end


#pragma mark - interface IOSpecialView
@interface IOSpecialView : UIView

@property (nonatomic, strong) NSArray *datas;

@end
