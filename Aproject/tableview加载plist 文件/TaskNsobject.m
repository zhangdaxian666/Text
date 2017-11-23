//
//  TaskNsobject.m
//  Aproject
//
//  Created by slcf888 on 2017/11/21.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "TaskNsobject.h"
@implementation TaskNsobject
+ (instancetype)appWithDict:(NSDictionary *)dict
{
    TaskNsobject *app =[[self alloc]init];
    [app setValuesForKeysWithDictionary:dict];
    return app;
}
@end
