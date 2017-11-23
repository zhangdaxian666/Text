//
//  imageViewCell.m
//  Aproject
//
//  Created by slcf888 on 2017/11/21.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "imageViewCell.h"

@implementation imageViewCell
//懒加载
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView =[[UIImageView alloc]init];
    }
    return _imageView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
    [self.contentView addSubview:self.imageView];
    self.imageView.backgroundColor =[UIColor orangeColor];
    self.imageView.frame =self.contentView.frame;
}
#pragma mark
- (void)setImage:(UIImage *)image
{
    self.imageView.image =image;
}
@end
