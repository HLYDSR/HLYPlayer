//
//  ViewController.m
//  HLYPlayer
//
//  Created by DengShiru on 16/8/12.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "MainViewController.h"
#import "TencentNewsViewController.h"
#import "WSContainerController.h"
#import "UIColor+Hex.h"
#import "AppDelegate.h"
#define STATUS_BAR_HEIGHT               20
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


@interface MainViewController ()<CustomScrollerMenuDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray  *vics =[NSMutableArray new];
    //根据标题添加对应的视图控制器
    NSArray *vcs=@[@"推荐",@"视频",@"图片",@"段子",@"分类",@"订阅",@"xxxx",@"xxxx"];
    for (int i=0; i<vcs.count; i++) {
            TencentNewsViewController *vic=[[TencentNewsViewController alloc] init];
            vic.title=vcs[i];
        if (!vic.dataSource) {
            vic.dataSource=[NSMutableArray new];
        }
            [vic.dataSource addObjectsFromArray:[AppDelegate shareAppDelegate].videoArray];
            [vic.table reloadData];
            [vics addObject:vic];
    }
    //创建滑动视图
    WSContainerController *containVC = [WSContainerController containerControllerWithSubControlers:vics parentController:self];
    containVC.navigationBarBackgrourdColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
