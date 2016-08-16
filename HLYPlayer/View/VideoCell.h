//
//  VideoCell.h
//  TencentNews
//
//  Created by DengShiru on 16/2/12.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoModel;
@protocol VideoCellDegate <NSObject>

/**
 *  点赞
 *
 *  @param sender 传递sender过去
 */
-(void)likeAction:(id)sender;
/**
 *  踩
 */
-(void)brakesAction;
/**
 *  评论
 */
-(void)contentAction;
/**
 *  分享
 */
-(void)sahreAction;
/**
 *  重播
 */
-(void)reloadAction;
/**
 *  分享时的分享
 */
-(void)sharedAction;

@end
@interface VideoCell : UITableViewCell
/**
 *  话题高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contenHeight;
@property (nonatomic,strong)id<VideoCellDegate>delegate;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headPic;
//名字
@property (weak, nonatomic) IBOutlet UILabel *name;
//时长
@property (weak, nonatomic) IBOutlet UILabel *time;
//内容
@property (weak, nonatomic) IBOutlet UILabel *content;
//来源
@property (weak, nonatomic) IBOutlet UILabel *videosource;
//热门
@property (weak, nonatomic) IBOutlet UILabel *type;
//未播放时显示的背景图
@property (weak, nonatomic) IBOutlet UIImageView *backgroundIV;
//播放暂停按钮
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

//数据源  这个模型 根据自己的接口写

@property (nonatomic, strong)VideoModel *model;
- (IBAction)likeAction:(id)sender;
- (IBAction)brakesAction:(id)sender;
- (IBAction)contentAction:(id)sender;
- (IBAction)sahreAction:(id)sender;
//分享数量
@property (weak, nonatomic) IBOutlet UILabel *shareNum;
//评论数量
@property (weak, nonatomic) IBOutlet UILabel *contnetNUm;
//踩的数量
@property (weak, nonatomic) IBOutlet UILabel *brakesNum;
//点赞数量
@property (weak, nonatomic) IBOutlet UILabel *likeNum;
//点赞图标
@property (weak, nonatomic) IBOutlet UIImageView *likeImage;
//时长
@property (weak, nonatomic) IBOutlet UILabel *times;
//播放次数
@property (weak, nonatomic) IBOutlet UILabel *timess;
- (IBAction)moreAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *active;

- (IBAction)reload:(id)sender;
- (IBAction)shareAction:(id)sender;
//播放完毕出现的蒙板

@property (weak, nonatomic) IBOutlet UIView *blackView;


@end
