
/*!
 @header DataManager.m
 
 @abstract  作者Github地址：https://github.com/zhengwenming
            作者CSDN博客地址:http://blog.csdn.net/wenmingzheng
 
 @author   Created by zhengwenming on  16/1/20
 
 @version 1.00 16/1/20 Creation(版本信息)
 
   Copyright © 2016年 郑文明. All rights reserved.
 */

#import "DataManager.h"
#import "VideoModel.h"

@implementation DataManager

+(DataManager *)shareManager{
    
    static DataManager* manager = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{

        manager = [[[self class] alloc] init];
    });
    
    return manager;
    
}

-(void)getDataSoucesWithDone:(doneWithObject)done{
    NSArray *array=@[@{@"mp4s_url":@"http://flv2.bn.netease.com/videolib3/1608/13/NajhW2749/SD/NajhW2749-mobile.mp4",@"cover":@"http://vimg2.ws.126.net/image/snapshot/2016/8/P/7/VBTF4K5P7.jpg",@"name":@"动心娱乐",@"time":@"03:23",@"times":@"1234",@"creattime":@"3小时前",@"videosource":@"新媒体",@"type":@"热门",@"like":@"32",@"brakes":@"322",@"contentnum":@"12",@"share":@"122",@"content":@"每天我们的生活中都会发生这样那样好的坏的有趣的无聊的事，我习惯记录下来和大家一起分享",@"headPic":@"http://vimg3.ws.126.net/image/snapshot/2016/7/E/A/VBS4KO5EA.jpg"},@{@"mp4s_url":@"http://flv2.bn.netease.com/videolib3/1608/13/HZuTA1508/SD/HZuTA1508-mobile.mp4",@"cover":@"http://vimg2.ws.126.net/image/snapshot/2016/8/P/7/VBTF4K5P7.jpg",@"name":@"动心娱乐",@"time":@"03:23",@"times":@"1234",@"creattime":@"3小时前",@"videosource":@"新媒体",@"type":@"热门",@"like":@"32",@"brakes":@"322",@"contentnum":@"12",@"share":@"122",@"content":@"每天我们的生活中都会发生这样那样好的坏的有趣的无聊的事，我习惯记录下来和大家一起分享",@"headPic":@"http://vimg3.ws.126.net/image/snapshot/2016/7/E/A/VBS4KO5EA.jpg"},@{@"mp4s_url":@"http://flv2.bn.netease.com/videolib3/1608/12/jNYOf8483/HD/jNYOf8483-mobile.mp4",@"cover":@"http://vimg2.ws.126.net/image/snapshot/2016/8/P/7/VBTF4K5P7.jpg",@"name":@"动心娱乐",@"time":@"03:23",@"times":@"1234",@"creattime":@"3小时前",@"videosource":@"新媒体",@"type":@"热门",@"like":@"32",@"brakes":@"322",@"contentnum":@"12",@"share":@"122",@"content":@"每天我们的生活中都会发生这样那样好的坏的有趣的无聊的事，我习惯记录下来和大家一起分享",@"headPic":@"http://vimg3.ws.126.net/image/snapshot/2016/7/E/A/VBS4KO5EA.jpg"},@{@"mp4s_url":@"http://flv2.bn.netease.com/videolib3/1608/12/KFXTz5294/SD/KFXTz5294-mobile.mp4",@"cover":@"http://vimg2.ws.126.net/image/snapshot/2016/8/P/7/VBTF4K5P7.jpg",@"name":@"动心娱乐",@"time":@"03:23",@"times":@"1234",@"creattime":@"3小时前",@"videosource":@"新媒体",@"type":@"热门",@"like":@"32",@"brakes":@"322",@"contentnum":@"12",@"share":@"122",@"content":@"每天我们的生活中都会发生这样那样好的坏的有趣的无聊的事，我习惯记录下来和大家一起分享",@"headPic":@"http://vimg3.ws.126.net/image/snapshot/2016/7/E/A/VBS4KO5EA.jpg"},@{@"mp4s_url":@"http://flv2.bn.netease.com/videolib3/1608/13/tQSCY7511/SD/tQSCY7511-mobile.mp4",@"cover":@"http://vimg2.ws.126.net/image/snapshot/2016/8/P/7/VBTF4K5P7.jpg",@"name":@"动心娱乐",@"time":@"03:23",@"times":@"1234",@"creattime":@"3小时前",@"videosource":@"新媒体",@"type":@"热门",@"like":@"32",@"brakes":@"322",@"contentnum":@"12",@"share":@"122",@"content":@"每天我们的生活中都会发生这样那样好的坏的有趣的无聊的事，我习惯记录下来和大家一起分享",@"headPic":@"http://vimg3.ws.126.net/image/snapshot/2016/7/E/A/VBS4KO5EA.jpg"}];
    NSMutableArray *videoArray = [NSMutableArray array];
    for (NSDictionary * video in array) {
        VideoModel * model = [[VideoModel alloc] init];
        [model setValuesForKeysWithDictionary:video];
        [videoArray addObject:model];
    }
    self.videoArray = [NSArray arrayWithArray:videoArray];
    done(videoArray);
}


@end
