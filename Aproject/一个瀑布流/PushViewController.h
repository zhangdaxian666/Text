//
//  PushViewController.h
//  Aproject
//  http://www.jb51.net/article/77690.htm
//  Created by slcf888 on 2017/11/20.
//  Copyright © 2017年 slcf888. All rights reserved.
//   富文本
/*
 // 创建Attributed
 NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:_label.text];
 // 需要改变的第一个文字的位置
 NSUInteger firstLoc = [[noteStr string] rangeOfString:@"金"].location + 1;
 // 需要改变的最后一个文字的位置
 NSUInteger secondLoc = [[noteStr string] rangeOfString:@"元"].location;
 // 需要改变的区间
 NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
 // 改变颜色
 [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:range];
 // 改变字体大小及类型
 [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:27] range:range];
 // 为label添加Attributed
 [_label setAttributedText:noteStr];
 */
#import "ViewController.h"

@interface PushViewController : ViewController

@end
