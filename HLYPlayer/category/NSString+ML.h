//
//  NSString+ML.h
//  MartinDemos
//
//  Created by Gao Huang on 14-12-8.
//  Copyright (c) 2014年 Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (ML)

+(CGSize)sizeHeightWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;

+(NSInteger)lineOfImages:(NSArray *)imgs andNum:(NSInteger )num;



@end
