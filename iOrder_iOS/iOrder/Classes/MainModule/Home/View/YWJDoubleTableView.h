//
//  YWJDoubleTableView.h
//  iOrder
//
//  Created by 易无解 on 5/17/16.
//  Copyright © 2016 normcore. All rights reserved.
//  创建一个两边都有TableView的View

#import <UIKit/UIKit.h>
@class IOShopLeftCell;
@class IOShopRightCell;

@protocol YWJDoubleTableViewDelegate <NSObject>

- (void)doubleTableView:(UIView *)doubleTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)doubleTableView:(UIView *)doubleTableView dishPrice:(float)dishPrice clickedBtn:(UIButton *)btn;

@end

@interface YWJDoubleTableView : UIView

@property (nonatomic, weak) UITableView *leftTableView;
@property (nonatomic, weak) UITableView *rightTableView;

@property (nonatomic, strong) NSMutableArray *dishInfos;

@property (nonatomic, weak) id<YWJDoubleTableViewDelegate> delegate;

@end
