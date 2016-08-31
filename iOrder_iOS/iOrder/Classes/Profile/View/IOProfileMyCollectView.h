//
//  IOProfileMyCollectView.h
//  iOrder
//
//  Created by 易无解 on 8/29/16.
//  Copyright © 2016 易无解. All rights reserved.
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

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath;

@end

