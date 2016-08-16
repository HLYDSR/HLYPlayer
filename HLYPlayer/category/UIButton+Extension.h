//
//  UIButton+Extension.h
//  BoFangqiDemo
//
//  Created by DengShiru on 16/8/1.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
+ (instancetype)buttonWithTitle:(NSString *)title andUiColor:(UIColor *)color andBackGroundColor:(UIColor *)backgroundColor  imageName:(NSString *)imageName target:(id)target action:(SEL)action ;
@end
