//
//  AppDelegate.h
//  HLYPlayer
//
//  Created by DengShiru on 16/8/12.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//这里是获取数据  根据你们自己的 接口喝方式进行获取  
@property (strong, nonatomic) NSArray *videoArray;
@property (strong, nonatomic)Reachability *hostReach;
+(AppDelegate *)shareAppDelegate;


@end

