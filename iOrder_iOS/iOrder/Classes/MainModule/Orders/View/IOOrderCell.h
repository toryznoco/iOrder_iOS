//
//  IOOrderCell.h
//  iOrder
//
//  Created by Tory on 24/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IOOrder;

@interface IOOrderCell : UITableViewCell

/** 数据模型  */
@property (nonatomic, strong) IOOrder *order;

@end
