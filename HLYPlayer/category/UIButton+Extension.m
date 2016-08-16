//
//  UIButton+Extension.m
//  BoFangqiDemo
//
//  Created by DengShiru on 16/8/1.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

/// 标题默认颜色
#define kItemTitleColor ([UIColor colorWithWhite:80.0 / 255.0 alpha:1.0])
/// 标题高亮颜色
#define kItemTitleHighlightedColor ([UIColor orangeColor])
/// 标题字体大小
#define kItemFontSize  14

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
+ (instancetype)buttonWithTitle:(NSString *)title andUiColor:(UIColor *)color andBackGroundColor:(UIColor *)backgroundColor imageName:(NSString *)imageName target:(id)target action:(SEL)action {
        UIButton *button = [[self alloc] init];
    // 设置图像
    if (imageName != nil) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        NSString *highlighted = [NSString stringWithFormat:@"%@_highlighted", imageName];
        [button setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    }
    // 设置标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateHighlighted];
    [button setBackgroundColor:backgroundColor];
    button.titleLabel.font = [UIFont systemFontOfSize:kItemFontSize];
    [button sizeToFit];
    // 监听方法
    if (action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
        return button;
}
@end
