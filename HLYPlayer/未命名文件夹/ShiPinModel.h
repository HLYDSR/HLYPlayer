//
//  ShiPinModel.h
//  SunShine
//
//  Created by 阳光互联 on 16/6/2.
//  Copyright © 2016年 阳光互联. All rights reserved.
//

#import "JSONModel.h"

@interface ShiPinModel : JSONModel


///id 内容id
@property(nonatomic,copy)NSString<Optional> * ID;

///catid 分类id
@property(nonatomic,copy)NSString<Optional> * catid;

///tagid 标签id
@property(nonatomic,copy)NSString<Optional> * tagid;

///uid 用户id
@property(nonatomic,copy)NSString<Optional> * uid;

///txt_content 文本内容
@property(nonatomic,copy)NSString<Optional> * txt_content;

///img_path 图片url
@property(nonatomic,copy)NSString<Optional> * img_path;

///video_path 视频url
@property(nonatomic,copy)NSString<Optional> * video_path;

///create_at 内容提交时间
@property(nonatomic,copy)NSString<Optional> * create_at;

///publish_at 内容审核通过时间
@property(nonatomic,copy)NSString<Optional> * publish_at;

///clicks 点击（播放、查看）数
@property(nonatomic,copy)NSString<Optional> * clicks;

///likes 点赞(喜欢)数
@property(nonatomic,copy)NSString<Optional> * likes;

///dislikes 踩(不喜欢)数
@property(nonatomic,copy)NSString<Optional> * dislikes;

///shares 分享数
@property(nonatomic,copy)NSString<Optional> * shares;

///comments 评论数
@property(nonatomic,copy)NSString<Optional> * comments;

///category_name 分类名称
@property(nonatomic,copy)NSString<Optional> * category_name;

///tag_name 标签名
@property(nonatomic,copy)NSString<Optional> * tag_name;

///tag_icon_name 标签图片名
@property(nonatomic,copy)NSString<Optional> * tag_icon_name;

///nick_name 发布用户昵称
@property(nonatomic,copy)NSString<Optional> * nick_name;

///header_path 发布用户头像url
@property(nonatomic,copy)NSString<Optional> * header_path;

///has_like 是否赞(顶)过
@property(nonatomic,copy)NSString<Optional> * has_like;

///has_dislike 是否不喜欢(踩)过
@property(nonatomic,copy)NSString<Optional> * has_dislike;

///has_share 是否分享过
@property(nonatomic,copy)NSString<Optional> * has_share;


//has_follow是否关注过
@property(nonatomic,copy)NSString<Optional> * has_follow;









@end
