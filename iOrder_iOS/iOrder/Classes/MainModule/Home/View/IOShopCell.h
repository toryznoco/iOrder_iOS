//
//  IOShopCell.h
//  iOrder
//
//  Created by 易无解 on 5/3/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IODish, IOShopRightCell;


#pragma mark - interface IOShopMenuCell
@protocol IOShopRightCellDelegate <NSObject>

- (void)shopRightCell:(IOShopRightCell *)shopRightCell dishPrice:(float)dishPrice clickedBtn:(UIButton *)btn;

@end

@interface IOShopRightCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) IODish *dish;

@property (nonatomic, weak) id<IOShopRightCellDelegate> delegate;

@end


#pragma mark - interface IOShopOptionCell
@interface IOShopLeftCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *category;

@end
