//
//  CustCollectionViewlayout.m
//  Aproject
//
//  Created by slcf888 on 2017/11/20.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "CustCollectionViewlayout.h"
@interface CustCollectionViewlayout()
{
    NSMutableDictionary *maxDic;
    NSMutableArray *attributesArray;
}
@property (nonatomic,assign)UIEdgeInsets contentInset;
@end
@implementation CustCollectionViewlayout
- (void)prepareLayout{
    [super prepareLayout];
    attributesArray =[NSMutableArray array];
    for (int index =0; index<[self.collectionView numberOfItemsInSection:0]; index++) {
        UICollectionViewLayoutAttributes *attributes =[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [attributesArray addObject:attributes];
        NSLog(@"%f %f %f %f",attributes.frame.origin.x,attributes.frame.origin.y,attributes.frame.size.width,attributes.frame.size.height);
    }
}
- (instancetype)init{
    self =[super init];
    if (self) {
        maxDic =[NSMutableDictionary dictionary];
        //第一列和第二列的启示高度都会0
        [maxDic setObject:@(0) forKey:@"maxO"];
        [maxDic setObject:@(0) forKey:@"maxS"];
        //lie jianju
        _clomnInst =10;
        //bian ju
        _contentInset =UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}
#pragma mark 以下不懂
//know Dont
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return attributesArray;
}
- (CGSize)collectionViewContentSize
{
    CGFloat width =0;
    CGFloat height;
    //比较那一列Y大
    CGFloat maxO =[[maxDic objectForKey:@"maxO"]floatValue];
    CGFloat maxS =[[maxDic objectForKey:@"maxS"]floatValue];
    if (maxO >maxS) {
        height =maxO +_contentInset.bottom;
    }else{
        height =maxS +_contentInset.bottom;
    }
    return CGSizeMake(width, height);
}
//error
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat borderInsetX =_contentInset.left;
    CGFloat borderInsetY =_contentInset.top;
    CGSize itemsize =[self.delegate itemSizeForCollectionView:self.collectionView indexPath:indexPath];
    CGFloat width =itemsize.width;
    CGFloat height =itemsize.height;
    
    CGFloat left;
    CGFloat top;
    CGFloat maxO =[[maxDic objectForKey:@"maxO"]floatValue];
    CGFloat maxS =[[maxDic objectForKey:@"maxS"]floatValue];
    CGFloat maxY;
    if (maxO <maxS||maxO ==maxS) {
        maxY =maxO;
        left =borderInsetX;
        top =maxY +borderInsetY;
        [maxDic setObject:@(top +height) forKey:@"maxO"];
    }else{
        maxY =maxS;
        left =borderInsetX +itemsize.width +_clomnInst;
        top =maxY +borderInsetY;
        [maxDic setObject:@(top +height) forKey:@"maxS"];
    }
    [maxDic setObject:@(maxY) forKey:@"maxY"];
    UICollectionViewLayoutAttributes *attributes =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame =CGRectMake(left, top, width, height);
    return attributes;
}
@end
