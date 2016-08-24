//
//  ShiPinModel.m
//  SunShine
//
//  Created by 阳光互联 on 16/6/2.
//  Copyright © 2016年 阳光互联. All rights reserved.
//

#import "ShiPinModel.h"

@implementation ShiPinModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ID"}];
}
@end
