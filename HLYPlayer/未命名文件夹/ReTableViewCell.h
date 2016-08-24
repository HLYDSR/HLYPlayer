//
//  ReTableViewCell.h
//  SunShine
//
//  Created by 阳光互联 on 16/6/30.
//  Copyright © 2016年 阳光互联. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShiPinModel.h"
@interface ReTableViewCell : UITableViewCell
@property (nonatomic,strong) ShiPinModel * model;
+ (CGFloat)cellHeightWithStr:(NSString *)str imgs:(NSArray *)imgs str:(NSString *)videUrl;
+ (ReTableViewCell *)dynamicCellWithTable:(UITableView *)table;

@property(nonatomic,strong)UIButton * headbtn;
@property (nonatomic, strong)UIButton *nick_name;//发布用户昵称
@property(nonatomic,strong)UIButton * text_contBtn;
@property (nonatomic, strong)UIButton *tanchaung;//弹窗
@property(nonatomic,strong)NSString * video_path;//视频
//@property(nonatomic,strong)UIView * vide_View;
@property (nonatomic, strong)UIButton *category_name;//分类名称
@property (nonatomic, strong)UIButton *comments;//评论数
@property(nonatomic,copy)NSString * ID;//内容id
@property(nonatomic,copy)NSString * catid;//分类id
@property(nonatomic,copy)NSString * tagid;// 标签id
@property(nonatomic,copy)NSString * uid;//用户id
@property(nonatomic,strong)UIButton * playBtn;//播放按钮
//@property(nonatomic,strong)UIView * blackView;//蒙版
@property(nonatomic,strong)UIImageView * backgroundIV ;//未播放时的背景图
@end
