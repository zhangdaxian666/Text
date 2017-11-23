//
//  TaskNsobject.h
//  Aproject
//
//  Created by slcf888 on 2017/11/21.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskNsobject : NSObject
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *download;
+ (instancetype)appWithDict:(NSDictionary *)dict;
@end
