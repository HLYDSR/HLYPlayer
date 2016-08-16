//
//  SharedAction.m
//  HLYPlayer
//
//  Created by DengShiru on 16/8/15.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "SharedAction.h"

@implementation SharedAction
//判断网络
+(BOOL)testNetWorkwithViewController:(UIViewController*)viewController{
    UIAlertAction *cancelAction;
    UIAlertAction *okAction;
    UIAlertController*alertViewcontroller;
    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger status=[appDlg.hostReach currentReachabilityStatus];
    if (status==0) {
        alertViewcontroller=[UIAlertController alertControllerWithTitle:@"网络异常！" message:@"网络异常，请检查网络设置！"  preferredStyle:UIAlertControllerStyleAlert];
        cancelAction= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        }];
        okAction= [UIAlertAction actionWithTitle:@"打开网络设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
        }];
        [alertViewcontroller addAction:cancelAction];
        [alertViewcontroller addAction:okAction];
        [viewController presentViewController:alertViewcontroller animated:YES completion:nil];
        return NO;
    }else if (status==1){
        alertViewcontroller=[UIAlertController alertControllerWithTitle:@"移动网络！" message:@"当前使用移动网络，时否要继续播放！"  preferredStyle:UIAlertControllerStyleAlert];
        cancelAction= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
        }];
        okAction= [UIAlertAction actionWithTitle:@"打开网络设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
            
        }];
        [alertViewcontroller addAction:cancelAction];
        [alertViewcontroller addAction:okAction];
        [viewController presentViewController:alertViewcontroller animated:YES completion:nil];
        return NO;
    }else{
        return YES;
    }
}
@end
