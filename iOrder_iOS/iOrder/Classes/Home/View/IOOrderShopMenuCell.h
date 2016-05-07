//
//  IOOrderShopMenuCell.h
//  iOrder
//
//  Created by 易无解 on 5/3/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IODish, IOOrderShopMenuCell;

@protocol IOOrderShopMenuCellDelegate <NSObject>

- (void)orderShopMenuCell:(IOOrderShopMenuCell *)shopMenuCell dishPrice:(NSString *)dishPrice clickedBtn:(UIButton *)btn;

@end

@interface IOOrderShopMenuCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) IODish *dish;

@property (nonatomic, weak) id<IOOrderShopMenuCellDelegate> delegate;

@end
