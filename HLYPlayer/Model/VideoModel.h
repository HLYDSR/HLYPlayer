
/*!
 @header VideoModel.h
 
 @abstract  作者Github地址：https://github.com/zhengwenming
            作者CSDN博客地址:http://blog.csdn.net/wenmingzheng
 
 @author   Created by zhengwenming on  16/1/20
 
 @version 1.00 16/1/20 Creation(版本信息)
 
   Copyright © 2016年 郑文明. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
/**
 *  播放地址
 */
@property (nonatomic, strong) NSString * mp4s_url;
/**
 *  名称
 */
@property (nonatomic, strong) NSString * name;
/**
 *  时长
 */
@property (nonatomic, strong) NSString  *time;
/**
 *  来源
 */
@property (nonatomic, strong) NSString * videosource;
/**
 *  热门
 */
@property (nonatomic, strong) NSString * type;
/**
 *  点赞人数
 */
@property (nonatomic, strong) NSString * like;
/**
 *  踩 人数
 */
@property (nonatomic, strong) NSString * brakes;
/**
 *  评论数量
 */
@property (nonatomic, strong) NSString  *contentnum;
/**
 *  分享数量
 */
@property (nonatomic, strong) NSString * share;
/**
 *  话题内容
 */
@property (nonatomic, strong) NSString * content;
/**
 *  头像
 */
@property (nonatomic, strong) NSString * headPic;
/**
 *  静态图
 */
@property (nonatomic, strong) NSString * cover;
/**
 *  发布时间
 */
@property (nonatomic, strong) NSString *creattime;
/**
 *  播放次数
 */
@property (nonatomic, strong) NSString *times;

@end
