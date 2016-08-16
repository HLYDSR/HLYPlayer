//
//  NSString+ML.m
//  MartinDemos
//
//  Created by Gao Huang on 14-12-8.
//  Copyright (c) 2014年 Martin. All rights reserved.
//

#import "NSString+ML.h"

@implementation NSString (ML)

+(CGSize)sizeHeightWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}
+(NSInteger)lineOfImages:(NSArray *)imgs andNum:(NSInteger )num{
    NSInteger line;
    if (imgs.count>num) {
        if (imgs.count%num) {
            line=(int)imgs.count/num+1;
        }else{
            line=(int)imgs.count/num;
        }
    }else{
        if (imgs.count>0) {
            line=1;
        }else{
            line=0;
        }
    }
    return line;
}
@end
