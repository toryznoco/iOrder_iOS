//
//  IOProfileMyCollectView.m
//  iOrder
//
//  Created by 易无解 on 8/29/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOProfileMyCollectView.h"

#pragma mark - implementation IOProfileMyCollectView

@interface IOProfileMyCollectView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation IOProfileMyCollectView

#pragma mark - privace

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupAllChildView];
    }
    
    return self;
}

#pragma mark - public

#pragma mark - custom

- (void)setupAllChildView {
//    1、设置头部内容
//    2、添加收藏菜品
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 20;
    layout.itemSize = CGSizeMake(98, 98);
    layout.sectionInset = UIEdgeInsetsMake(8, 20, 8, 20);
    layout.headerReferenceSize = CGSizeMake(self.width, 42);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = YWJRGBColor(241, 241, 241, 1);
    [collectionView registerClass:[IOProfileMyCollectViewCell class] forCellWithReuseIdentifier:@"profileCollectionCell"];
    [collectionView registerClass:[IOProfileMyCollectViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
    _collectionView = collectionView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IOProfileMyCollectViewCell *cell = [IOProfileMyCollectViewCell cellWithCollectionView:collectionView withIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *headerId = @"headerId";
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        IOProfileMyCollectViewHeader *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if(!headerView)
        {
            headerView = [[IOProfileMyCollectViewHeader alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        }
        
        return headerView;
    }
    
    return nil;
}


#pragma mark - UICollectionViewDelegate

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [super updateConstraints];
}

@end

#pragma mark - implementation IOProfileMyCollectViewHeader

@interface IOProfileMyCollectViewHeader ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIView *underLineView;

@end

@implementation IOProfileMyCollectViewHeader

#pragma mark - privace

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupAllChildView];
    }
    
    return self;
}

#pragma mark - public

#pragma mark - custom

- (void)setupAllChildView {
//    1、标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"我的收藏";
    titleLabel.textColor = YWJRGBColor(139, 139, 139, 1);
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
//    2、下划线
    UIView *underLineView = [[UIView alloc] init];
    underLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:underLineView];
    _underLineView = underLineView;
}

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
        make.width.equalTo(@70);
        make.height.equalTo(@20);
    }];
    
    [self.underLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.right.equalTo(self.titleLabel);
        make.height.equalTo(@2);
    }];
    
    [super updateConstraints];
}

@end


#pragma mark - implementation IOProfileMyCollectViewCell

@interface IOProfileMyCollectViewCell ()

@property (nonatomic, weak) UIImageView *dishIcon;
@property (nonatomic, weak) UIView *dishMask;
@property (nonatomic, weak) UILabel *dishName;
@property (nonatomic, weak) UILabel *dishPrice;

@end

@implementation IOProfileMyCollectViewCell

#pragma mark - privace

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupAllChildView];
    }
    
    return self;
}

#pragma mark - public

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuserId = @"profileCollectionCell";
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuserId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[self alloc] init];
     }
    
    return cell;
}

#pragma mark - custom

- (void)setupAllChildView {
//    1、菜品图片
    UIImageView *dishIcon = [[UIImageView alloc] init];
    [self addSubview:dishIcon];
    dishIcon.image = [UIImage imageNamed:@"005"];
    _dishIcon = dishIcon;
    
//    2、蒙板
    UIView *dishMask = [[UIView alloc] init];
    dishMask.backgroundColor = YWJRGBColor(255, 255, 255, 0.5);
    [self addSubview:dishMask];
    _dishMask = dishMask;
    
//    3、菜名
    UILabel *dishName = [[UILabel alloc] init];
    dishName.text = @"jkdjfks";
    [dishMask addSubview:dishName];
    _dishName = dishName;
    
//    4、菜价
    UILabel *dishPrice = [[UILabel alloc] init];
    dishPrice.textAlignment = NSTextAlignmentRight;
    dishPrice.text = @"fjskj";
    [dishMask addSubview:dishPrice];
    _dishPrice = dishPrice;
}

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.dishIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [self.dishMask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@18);
    }];
    
    [self.dishName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.dishMask);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    
    [self.dishPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.dishMask);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    
    [super updateConstraints];
}

@end
