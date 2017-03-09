//
//  IOProfileMyCollectView.h
//  iOrder
//
//  Created by 易无解 on 8/29/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - interface IOProfileMyCollectView

@interface IOProfileMyCollectView : UIView

@end

#pragma mark - interface IOProfileMyCollectViewHeader

@interface IOProfileMyCollectViewHeader : UICollectionReusableView

@end

#pragma mark - interface IOProfileMyCollectView

@interface IOProfileMyCollectViewCell : UICollectionViewCell

/**
 使用collectionView初始化cell

 @param collectionView 将要装入cell的collectionview
 @param indexPath      将要插入的位置

 @return 返回一个实例化的cell
 */
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath;

@end

