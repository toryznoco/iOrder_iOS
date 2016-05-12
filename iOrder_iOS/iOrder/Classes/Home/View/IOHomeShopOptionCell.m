//
//  IOHomeShopOptionCell.m
//  iOrder
//
//  Created by 易无解 on 5/3/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOHomeShopOptionCell.h"

@implementation IOHomeShopOptionCell

#pragma mark - privacy

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupAllChidView];
    }
    return self;
}

#pragma mark - public

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"optionCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    return cell;
}

- (void)setCategory:(NSString *)category{
    _category = category;
    
    self.textLabel.text = category;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.textColor = YWJRGBColor(88, 88, 88, 1);
    self.textLabel.numberOfLines = 0;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - custom methods

- (void)setupAllChidView{
    UIView *selectedBgView = [[UIView alloc] initWithFrame:self.frame];
    selectedBgView.backgroundColor = YWJRGBColor(217, 217, 217, 0.5);
    self.selectedBackgroundView = selectedBgView;
    
    UIView *liner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 51)];
    liner.backgroundColor = [UIColor orangeColor];
    [selectedBgView addSubview:liner];
}

@end