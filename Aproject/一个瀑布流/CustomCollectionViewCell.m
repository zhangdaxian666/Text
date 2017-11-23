//
//  CustomCollectionViewCell.m
//  Aproject
//
//  Created by slcf888 on 2017/11/20.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        _imageview =[[UIImageView alloc]init];
        _imageview.backgroundColor =[UIColor yellowColor];
        [self.contentView addSubview:_imageview];
    }
    return self;
}
@end
