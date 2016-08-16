//
//  CustomScrollMenu.h
//  WSContainViewController
//
//  Created by DengShiru on 16/1/6.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomScrollerMenuDelegate <NSObject>

@optional
- (void)itemDidSelectedWithIndex:(NSInteger)index;
@end
@interface CustomScrollMenu : UIView
@property (nonatomic, weak) id  <CustomScrollerMenuDelegate>delegate;
//菜单名称数组
@property(nonatomic,copy)NSArray *myTitleArray;
//选中菜单时的文字颜色
@property(nonatomic,strong)UIColor *selectedColor;
//未选中菜单的文字颜色
@property(nonatomic,strong)UIColor *noSlectedColor;
//文字的字体
@property(nonatomic,strong)UIFont *titleFont;
//下划线的颜色
@property(nonatomic,strong)UIColor *LineColor;
//当前选中的索引值
@property (nonatomic, assign) NSInteger currentIndex;


- (instancetype)initWithFrame:(CGRect)frame showArrayButton:(BOOL)yesOrNo;
@end
