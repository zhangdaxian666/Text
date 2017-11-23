//
//  CustCollectionViewlayout.h
//  Aproject
//
//  Created by slcf888 on 2017/11/20.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import <UIKit/UIKit.h>
//代理
@protocol CustCollectionViewlayoutDelegate<NSObject>
- (CGSize)itemSizeForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end
@interface CustCollectionViewlayout : UICollectionViewLayout
@property (nonatomic, strong)NSMutableDictionary *maxYDic;
@property (nonatomic, assign)CGFloat clomnInst;//间距
@property (nonatomic, weak) id<CustCollectionViewlayoutDelegate>delegate;
@end
