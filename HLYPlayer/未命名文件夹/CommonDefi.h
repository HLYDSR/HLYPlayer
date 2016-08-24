//
//  CommonDefin.h
//  LoveLimitFree
//
//  Created by 郝海圣 on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef LoveLimitFree_CommonDefin_h
#define LoveLimitFree_CommonDefin_h

//宏定义  请求头字段
#define APP_TYPE @"ios"
#define API_KEY @"ios_ecgn741czjcjz1cc9j77ousvo7krfgdt"
#define Content_type @"application/x-www-form-urlencoded"
#define USER_NAME  @"NAME"
#define USER_PASSWOR @"PASSWODE"
#define USER_token  @"TOKEN"
#define USER_uid @"UID"








/**
 *    字体
 */
#define Thefont @"PingFang TC"


//颜色
#define kRGB(R,G,B)       [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];



/**
 *  当前屏幕大小
 */
#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kScreenWidth (kScreenBounds.size.width)
#define kScreenHeight (kScreenBounds.size.height)


#endif


