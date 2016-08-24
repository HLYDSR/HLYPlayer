//
//  UIImage+Extension.m
//  DouBeDemo
//
//  Created by gaolili on 16/5/4.
//  Copyright © 2016年 mRocker. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
- (UIImage *)clipImageWithRadius:(CGFloat)radius{
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    
    if(radius<0){radius = 0;}
    if (radius>MIN(w, h)) {
        radius = MIN(w, h);
    }
    
    CGRect imgFrame = CGRectMake(0, 0, w, h);
    
    UIGraphicsBeginImageContextWithOptions(imgFrame.size, NO, 0);
    UIBezierPath  *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, w, h) cornerRadius:radius];
    [path addClip];
    [self drawInRect:imgFrame];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
 }


- (UIImage *)createImageWithColor:(UIColor *)color{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [color setFill];
    CGRect bounds = (CGRect){CGPointZero, self.size};
    UIRectFill(bounds);
    
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;

}

+ (UIImage *)resizableImageWithName:(NSString *)imageName
{
    
    // 加载原有图片
    UIImage *norImage = [UIImage imageNamed:imageName];
    // 获取原有图片的宽高的一半
    CGFloat w = norImage.size.width * 0.5;
    CGFloat top = norImage.size.height * 0.5;
    CGFloat bottom = norImage.size.height-top;
    // 生成可以拉伸指定位置的图片
    UIImage *newImage = [norImage resizableImageWithCapInsets:UIEdgeInsetsMake(top, w, bottom, w) resizingMode:UIImageResizingModeStretch];
    
    return newImage;
}
@end
