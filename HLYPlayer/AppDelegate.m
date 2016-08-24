//
//  AppDelegate.m
//  HLYPlayer
//
//  Created by DengShiru on 16/8/12.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"
#import "Reachability.h"
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //检测和监测网络状态
    _hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status = [_hostReach currentReachabilityStatus];
    //观察者模式
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:kReachabilityChangedNotification object:nil];
    [_hostReach startNotifier];
    
    [[DataManager shareManager] getDataSoucesWithDone:^(NSArray *videoArray){
        self.videoArray = [NSArray arrayWithArray:videoArray];
        NSLog(@"videoArray = %@",videoArray);
    }];
    
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &setCategoryErr];
    [[AVAudioSession sharedInstance] setActive: YES error: &activationErr];
    return YES;
}
//网络状态发生改变时会掉用
-(void)change:(NSNotification *)notfication{
    _hostReach = notfication.object;
    NSLog(@"%ld",(long)_hostReach.currentReachabilityStatus);
    
    NSString *status = @"";
    switch (_hostReach.currentReachabilityStatus) {
        case NotReachable:{
            status = @"无网络";
        }break;
        case ReachableViaWiFi:{
            status = @"WIFI网络";
        }break;
        case ReachableViaWWAN:{
            status = @"WAN网络";
        }break;
        default:
        break;
    }
    NSLog(@"%@",status);
            
}
- (BOOL)prefersStatusBarHidden
{
    // iOS7后,[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    // 已经不起作用了
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"APPRunBack" object:nil];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
+(AppDelegate *)shareAppDelegate{
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}
@end
