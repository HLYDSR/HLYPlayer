
/*!
 @header DataManager.h
 
 @abstract  作者Github地址：https://github.com/zhengwenming
            作者CSDN博客地址:http://blog.csdn.net/wenmingzheng
 
 @author   Created by zhengwenming on  16/1/20
 
 @version 1.00 16/1/20 Creation(版本信息)
 
   Copyright © 2016年 郑文明. All rights reserved.
 */

#import <Foundation/Foundation.h>

typedef void(^onFailed)(NSError *error);

@interface DataManager : NSObject

@property(nonatomic,copy)NSArray *videoArray;

typedef void (^doneWithObject)(id object);

+(DataManager *)shareManager;

-(void)getDataSoucesWithDone:(doneWithObject)done;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com