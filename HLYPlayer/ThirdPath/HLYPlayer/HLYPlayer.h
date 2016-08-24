 //  HLYPlayer.h
 //  TencentNews
 //
 //  Created by DengShiru on 16/2/12.
 //  Copyright © 2016年 hlyclub. All rights reserved.
 //

#import <UIKit/UIKit.h>
#import "Masonry.h"

@import MediaPlayer;
@import AVFoundation;

/**
 *  注意⚠：本人把属性都公开到.h文件里面了，为了适配广大开发者，不同的需求可以修改属性东西，也可以直接修改源代码。
 */
/** 系统菊花 */

@interface HLYPlayer : UIView
/**
 *  播放器player
 */
@property(nonatomic,retain)AVPlayer *player;
/**
 *playerLayer,可以修改frame
 */
@property(nonatomic,retain)AVPlayerLayer *playerLayer;
/**
 *  底部操作工具栏
 */
@property(nonatomic,retain)UIView *bottomView;
//视频加载失败显示
@property(nonatomic,retain)UILabel *loadFaildLabel;
/**
 *  进度条
 */
@property(nonatomic,retain)UIProgressView *progressView;
//滑动条
@property(nonatomic,retain)UISlider *progressSlider;
@property(nonatomic,retain)UISlider *volumeSlider;
/**
 *  视频播放地址
 */
@property(nonatomic,copy) NSString *videoURLStr;
/**
 *  BOOL值判断当前的状态
 */
@property(nonatomic,assign)BOOL isFullscreen;
/**
 *  显示播放总时间的UILabel
 */
@property(nonatomic,retain)UILabel *timeLabel;

/**
 *  显示播放时间的UILabel
 */
@property(nonatomic,retain)UILabel *crutimeLabel;
/**
 *  控制全屏的按钮
 */
@property(nonatomic,retain)UIButton *fullScreenBtn;
/**
 *  播放暂停按钮
 */
@property(nonatomic,retain)UIButton *playOrPauseBtn;
/**
 *  关闭按钮
 */
@property(nonatomic,retain)UIButton *closeBtn;

/* playItem */
@property (nonatomic, retain) AVPlayerItem *currentItem;
/**
 *  初始化WMPlayer的方法
 *
 *  @param frame       frame
 *  @param videoURLStr URL字符串，包括网络的和本地的URL
 *
 *  @return id类型，实际上就是WMPlayer的一个对象
 */
- (id)initWithFrame:(CGRect)frame videoURLStr:(NSString *)videoURLStr;
@end

