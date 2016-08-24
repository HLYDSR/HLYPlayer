//
//  TencentNewsViewController.m
//  TencentNews
//
//  Created by DengShiru on 16/2/12.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "TencentNewsViewController.h"

#import "CommonDefi.h"


#import "Masonry.h"
#import "AFNetworking.h"

#import "Reachability.h"    //网络状态

#import "ShiPinModel.h"
#import "ReTableViewCell.h"


#import "DetailViewController.h"





#import "HLYPlayer.h"
#import "AppDelegate.h"
#import "DMHeartFlyView.h"
//#import "NSString+ML.h"
#import "SharedAction.h"
#import "ShareView.h"
#import "FinishView.h"

#define STATUS_BAR_HEIGHT               20
#define SCREEN_FRAME [UIScreen mainScreen].bounds
@interface TencentNewsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,ShareViewDelegate,FinishViewDelegate>{
    HLYPlayer *wmPlayer;   //播放器
    NSIndexPath *currentIndexPath;//当前播放cell的indexpath
    ShareView *shareView;//分享显示的视图
    FinishView *finishView;
}
//页数
@property(nonatomic,assign)NSInteger tuipage;
@property (nonatomic,strong)NSMutableArray * dataArraytui;

@property (nonatomic, strong) UIAlertController *alerttui;


@property (nonatomic,strong) Reachability *reachNet;//网络状态判断

@property(nonatomic,strong)ReTableViewCell * celltui;

@property(nonatomic,copy)NSString * typeju;//举报原因
@property(nonatomic,copy)NSString * myUid;//用户id
@property (nonatomic,copy)NSString * stringtoken;
@property (nonatomic,copy)NSString * stringaName;
@end

@implementation TencentNewsViewController








//懒加载
- (NSMutableArray *)dataArraytui{
    if (_dataArraytui == nil) {
        _dataArraytui = [[NSMutableArray alloc] init];
    }
    return _dataArraytui;
}


-(Reachability *)reachNet{
    if (_reachNet == nil) {
        //reachabilityForInternetConnection 是否连接网络
        _reachNet = [Reachability reachabilityForInternetConnection];
    }
    return _reachNet;
}
//提示框
- (void)mbhudtui:(NSString *)textname numbertime:(int)nuber{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
    
    //关闭通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeTheVideo:) name:@"closeTheVideo" object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(onDeviceOrientationChange)
    //                                                 name:UIDeviceOrientationDidChangeNotification
    //                                               object:nil
    //     ];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1获得单例
    NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
    _myUid = [defaults1 objectForKey:USER_uid];
    _stringtoken = [defaults1 objectForKey:USER_token];
    _stringaName = [defaults1 objectForKey:USER_NAME];
    
    _tuipage = 1;
    
    //界面tableview
    [self addUItuijian];
    //网络判断------请求数据
    [self downLoadtuijian];
}
//tableview
- (void)addUItuijian{
//    _tableViewtui = [[UITableView alloc] init];
//    _tableViewtui.delegate = self;
//    _tableViewtui.dataSource =  self;
//    _tableViewtui.separatorStyle = UITableViewCellSeparatorStyleNone;
//    //添加
//    [self.view addSubview:self.tableViewtui];
//    //约束
//    [_tableViewtui mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
    //上拉刷新  下拉加载
    //    _tableViewtui.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        [self refreshDatatuijian];
    //    }];
    //    [self footerWithText];//向下拉刷新
}
//下拉刷新
-(void)footerWithText{
    //    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的refresh方法）
    //    _mjFootertui = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataTui)];
    //    // 设置文字
    //    [_mjFootertui setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    //    [_mjFootertui setTitle:@"松开刷新" forState:MJRefreshStateRefreshing];
    //    // 设置刷新控件
    //    self.tableViewtui.mj_footer = _mjFootertui;
}
//由上向下拉
- (void)refreshDatatuijian{
    //    _tuipage = 1;
    //    [self downLoadtuijian];
}
- (void)loadMoreDataTui{
    
    //    _tuipage++;
    //    [self downLoadtuijian];
}

//判断网络
- (void)downLoadtuijian{
    //    if ([self.reachNet currentReachabilityStatus]==NotReachable) {
    //        [self mbhudtui:@"请检查网络" numbertime:1];
    //        //结束刷新
    //        [_tableViewtui.mj_header endRefreshing];
    //        [_tableViewtui.mj_footer endRefreshing];
    //    }else if ([self.reachNet currentReachabilityStatus]==ReachableViaWWAN){
    //        static int i = 10;
    //        i++;
    //        if (i == 11) {
    //            [self mbhudtui:@"您现在是3g/4g网络" numbertime:1];
    //        }
    //        [self downLoadDatatuijian];
    //    }else{
    //        [self downLoadDatatuijian];
    //    }
    [self downLoadDatatuijian];
}
//下载数据
- (void)downLoadDatatuijian{
    
    // 全局队列
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        AFHTTPSessionManager *mantui = [AFHTTPSessionManager manager];
        mantui.responseSerializer = [AFHTTPResponseSerializer serializer];
        [mantui.requestSerializer setValue:APP_TYPE forHTTPHeaderField:@"APP-TYPE"];
        [mantui.requestSerializer setValue:@"" forHTTPHeaderField:@"API-REQ-TIME"];
        [mantui.requestSerializer setValue:@"" forHTTPHeaderField:@"API-REQ-SIGN"];
        [mantui.requestSerializer setValue:@"" forHTTPHeaderField:@"CLIENT-ID"];
        [mantui.requestSerializer setValue:@"" forHTTPHeaderField:@"APP-VERSION"];
        [mantui.requestSerializer setValue:_stringtoken forHTTPHeaderField:@"TOKEN"];
        [mantui.requestSerializer setValue:_stringaName forHTTPHeaderField:@"LOGIN-NAME"];
        [mantui.requestSerializer setValue:Content_type forHTTPHeaderField:@"Content-type"];
        
        NSString * strpagetui = [NSString stringWithFormat:@"%ld",(long)_tuipage];
        
        NSDictionary * tuiDict = @{@"tab":@"2"};
        //发起请求
        [mantui GET:@"http://119.29.65.238:85/m/i/index" parameters:tuiDict progress:^(NSProgress * _Nonnull downloadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            NSString * status = dict[@"status"];
            NSDictionary * data = dict[@"data"];
            NSArray * data_list = data[@"data_list"];
            int statu = [status intValue];
            if (statu == 1) {
                //主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (NSDictionary * dict1 in data_list) {
                        ShiPinModel  * model = [[ShiPinModel alloc] initWithDictionary:dict1 error:nil];
                        [_dataArraytui addObject:model];
                    }
                    
                    //1刷新当前offset
                    [self.tableViewtui reloadData];
                    
                });
            }else{
                
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self mbhudtui:@"请求异常" numbertime:1];
            
            
            NSLog(@"tuijain视频解析错误信息:%@",error);
            
        }];
        
    });
}
#pragma make 协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArraytui.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ReTableViewCell";
    //自定义cell类
    ReTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    cell.model = self.dataArraytui[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //播放startPlayVideo
    [cell.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.playBtn.tag = indexPath.row;
    //    _celltui.delegate=self;
    if (wmPlayer&&wmPlayer.superview) {
        if (indexPath==currentIndexPath) {
            [cell.playBtn.superview.superview sendSubviewToBack:cell.playBtn];
        }else{
            [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
        }
        NSArray *indexpaths = [tableView indexPathsForVisibleRows];
        if (![indexpaths containsObject:currentIndexPath]) {//复用
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]) {
                wmPlayer.hidden = NO;
            }else{
                wmPlayer.hidden = YES;
                [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
            }
        }else{
            if ([cell.backgroundIV.subviews containsObject:wmPlayer]) {
                [cell.backgroundIV addSubview:wmPlayer];
                [wmPlayer.player play];
                wmPlayer.playOrPauseBtn.selected = NO;
                wmPlayer.hidden = NO;
            }
        }
    }
    
    
    //    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    //    view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    //    [_celltui.contentView addSubview:view];
    return cell;
}


//开始播放或者暂停
-(void)startPlayVideo:(UIButton *)sender{
    
    currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    ShiPinModel * model = self.dataArraytui[currentIndexPath.row];
    
    [self showOrHidTimesWithType:NO];
    self.celltui = (ReTableViewCell *)sender.superview.superview;
    
    if (wmPlayer) {
        [wmPlayer removeFromSuperview];
        [wmPlayer setVideoURLStr:model.video_path];
        [wmPlayer.player play];
    }else{
        wmPlayer = [[HLYPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) videoURLStr:model.video_path];
        wmPlayer.closeBtn.hidden=YES;
        [wmPlayer.player play];
    }
    [self showOrHidTimesWithType:YES];
    [self.celltui.backgroundIV addSubview:wmPlayer];
    [self.celltui.backgroundIV bringSubviewToFront:wmPlayer];
    [self.celltui.playBtn.superview sendSubviewToBack:self.celltui.playBtn];
    [self.tableViewtui reloadData];
}


//全屏播放模式
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [wmPlayer removeFromSuperview];
    wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
        self.view.transform=CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.view.transform=CGAffineTransformMakeRotation(M_PI_2);
    }
    //使用autolayout 适配位置
    wmPlayer.frame = SCREEN_FRAME;
    wmPlayer.playerLayer.frame =  SCREEN_FRAME;
    [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(SCREEN_FRAME.size.width-40);
        make.width.mas_equalTo(SCREEN_FRAME.size.height);
    }];
    
    [wmPlayer.progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(2);
        make.top.mas_equalTo(SCREEN_FRAME.size.width-2);
        make.width.mas_equalTo(SCREEN_FRAME.size.height);
    }];
    
    [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer).with.offset(15);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(wmPlayer).with.offset(5);
    }];
    
    [wmPlayer.playOrPauseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.top.mas_equalTo((SCREEN_FRAME.size.width-50)/2);
        make.left.mas_equalTo((SCREEN_FRAME.size.height-50)/2);
        make.width.mas_equalTo(50);
    }];
    [wmPlayer.loadFaildLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((SCREEN_FRAME.size.height-250)/2);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(wmPlayer.playOrPauseBtn).with.offset(25);
        make.width.mas_equalTo(250);
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
    wmPlayer.isFullscreen = YES;
    wmPlayer.closeBtn.hidden=NO;
    wmPlayer.fullScreenBtn.selected = YES;
    [wmPlayer bringSubviewToFront:wmPlayer.progressView];
    [wmPlayer bringSubviewToFront:wmPlayer.bottomView];
}



//判断tableview的滑动  当超出屏幕时停止播放
#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView ==self.tableViewtui){
        if (wmPlayer==nil) {
            return;
        }
        if (wmPlayer.superview) {
            CGRect rectInTableView = [self.tableViewtui rectForRowAtIndexPath:currentIndexPath];
            CGRect rectInSuperview = [self.tableViewtui convertRect:rectInTableView toView:[self.tableViewtui superview]];
            //判断时否处于屏幕外面
            if (rectInSuperview.origin.y<-self.celltui.contentView.frame.size.height||rectInSuperview.origin.y>self.view.frame.size.height) {//往上拖动
                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]) {
                    //在屏幕外的时候 停止播放
                    [self showOrHidTimesWithType:NO];
                    //                    [self.celltui.blackView.superview sendSubviewToBack:self.celltui.blackView];
                    [self toCell];
                    [self.celltui.playBtn.superview bringSubviewToFront:self.celltui.playBtn];
                    [self releaseWMPlayer];
                    //暂停播放
                    //                    [wmPlayer.player pause];
                    [self.celltui.playBtn setImage:[UIImage imageNamed:@"plays"] forState:UIControlStateNormal];
                    [self showOrHidTimesWithType:NO];
                }else{
                    //在屏幕外的时候 停止播放
                    [self showOrHidTimesWithType:NO];
                    //                    [self.celltui.blackView.superview sendSubviewToBack:self.celltui.blackView];
                    [self toCell];
                    [self.celltui.playBtn.superview bringSubviewToFront:self.celltui.playBtn];
                    [self releaseWMPlayer];
                    //暂停播放
                    //                    [wmPlayer.player pause];
                    [self.celltui.playBtn setImage:[UIImage imageNamed:@"plays"] forState:UIControlStateNormal];
                    [self showOrHidTimesWithType:NO];
                }
            }else{
                if ([self.celltui.backgroundIV.subviews containsObject:wmPlayer]) {
                    
                }else{
                    [self toCell];
                }
            }
        }else{
            CGRect rectInTableView = [self.tableViewtui rectForRowAtIndexPath:currentIndexPath];
            CGRect rectInSuperview = [self.tableViewtui convertRect:rectInTableView toView:[self.tableViewtui superview]];
            if (rectInSuperview.origin.y<-self.celltui.contentView.frame.size.height||rectInSuperview.origin.y>self.view.frame.size.height) {//往上拖动
                [self showOrHidTimesWithType:NO];
                //                [self.celltui.blackView.superview sendSubviewToBack:self.celltui.blackView];
                [self.celltui.playBtn.superview bringSubviewToFront:self.celltui.playBtn];
            }
        }
    }
}


//清除WMPlayer
-(void)releaseWMPlayer{
    [wmPlayer.player.currentItem cancelPendingSeeks];
    [wmPlayer.player.currentItem.asset cancelLoading];
    [wmPlayer.player pause];
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer = nil;
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    currentIndexPath = nil;
}

//重播
-(void)reloadAction{
    ShiPinModel *model = [_dataArraytui objectAtIndex:currentIndexPath.section];
    [wmPlayer removeFromSuperview];
    [wmPlayer setVideoURLStr:model.video_path];
    [wmPlayer.player play];
    wmPlayer.playOrPauseBtn.selected=NO;
    [self showOrHidTimesWithType:YES];
    
    [self.celltui.backgroundIV addSubview:wmPlayer];
    [self.celltui.backgroundIV bringSubviewToFront:wmPlayer];
    [self.celltui.playBtn.superview sendSubviewToBack:self.celltui.playBtn];
    [self.tableViewtui reloadData];
}
-(void)showOrHidTimesWithType:(BOOL)type{
    //    self.celltui.times.hidden=type;
    //    self.celltui.timess.hidden=type;
}

-(void)brakesAction{
    NSLog(@"踩");
}
-(void)contentAction{
    NSLog(@"评论");
}
-(void)sahreAction{
    [wmPlayer.player pause];
    [self videoDidFinished:nil];
    NSLog(@"分享");
}

#pragma mark ShareView delegate
-(void)closeAction{
    [shareView removeFromSuperview];
    [[UIApplication sharedApplication].keyWindow addSubview:finishView];
    NSLog(@"关闭分享");
}

-(void)closedAction{
    [finishView removeFromSuperview];
}

-(void)weixinAction{
    [shareView removeFromSuperview];
    NSLog(@"分享至微信");
}
-(void)frinedAction{
    [shareView removeFromSuperview];
    NSLog(@"分享至朋友圈");
}
-(void)qqAction{
    [shareView removeFromSuperview];
    NSLog(@"分享至qq");
}
-(void)weiboAction{
    [shareView removeFromSuperview];
    NSLog(@"分享至微博");
}



//视频播放完成后掉用
-(void)videoDidFinished:(NSNotification *)notice{
    if (wmPlayer.isFullscreen == YES) {
        wmPlayer.playOrPauseBtn.selected=YES;
        if (!finishView) {
            finishView=[[FinishView alloc] init];
            finishView.delegate=self;
            finishView.backgroundColor=[UIColor clearColor];
            finishView.transform = CGAffineTransformMakeRotation(-M_PI_2);
            //使用autolayout 适配位置
            finishView.frame = CGRectMake(80, 200, kScreenWidth-160, kScreenHeight-400);
        }
        [[UIApplication sharedApplication].keyWindow addSubview:finishView];
    }else{
        //将cell上的播放按钮放到最上层
        [self.celltui.playBtn.superview sendSubviewToBack:self.celltui.playBtn];
        [self.celltui.playBtn setImage:[UIImage imageNamed:@"plays"] forState:UIControlStateNormal];
        //        [self.celltui.blackView.superview bringSubviewToFront:self.celltui.blackView];
        [wmPlayer removeFromSuperview];
    }
}

//关掉视频通知
-(void)closeTheVideo:(NSNotification *)obj{
    //    [self showOrHidTimesWithType:NO];
    //    [self.currentCell.blackView.superview sendSubviewToBack:self.currentCell.blackView];
    [finishView removeFromSuperview];
    [shareView removeFromSuperview];
    //    VideoCell *currentCell = (VideoCell *)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:currentIndexPath.section]];
    [self toCell];
    //    [self.currentCell.playBtn.superview bringSubviewToFront:self.currentCell.playBtn];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //    [self releaseWMPlayer];
}

//全屏播放
-(void)fullScreenBtnClick:(NSNotification *)notice{
    UIButton *fullScreenBtn = (UIButton *)[notice object];
    if (fullScreenBtn.isSelected) {//全屏显示
        wmPlayer.closeBtn.hidden=NO;
        
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        wmPlayer.closeBtn.hidden=YES;
        [self toCell];
    }
}

/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    if (wmPlayer==nil||wmPlayer.superview==nil){
        return;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (wmPlayer.isFullscreen) {
                wmPlayer.closeBtn.hidden=YES;
                [self toCell];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            if (wmPlayer.isFullscreen == NO) {
                wmPlayer.closeBtn.hidden=NO;
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            if (wmPlayer.isFullscreen == NO) {
                wmPlayer.closeBtn.hidden=NO;
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        default:
            break;
    }
}

//cell上的播放模式
-(void)toCell{
    ReTableViewCell *currentCell = [self celltui];
    [wmPlayer removeFromSuperview];
    [finishView removeFromSuperview];
    [shareView removeFromSuperview];
    [UIView animateWithDuration:0.3f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = currentCell.backgroundIV.bounds;
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [currentCell.backgroundIV addSubview:wmPlayer];
        [currentCell.backgroundIV bringSubviewToFront:wmPlayer];
        self.view.transform=CGAffineTransformIdentity;
        
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        
        [wmPlayer.progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(2);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        
        [wmPlayer.playOrPauseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((kScreenWidth-50)/2);
            make.height.mas_equalTo(50);
            make.top.equalTo(wmPlayer).with.offset(66);
            make.width.mas_equalTo(50);
        }];
        
        [wmPlayer.loadFaildLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((kScreenWidth-250)/2);
            make.height.mas_equalTo(20);
            make.bottom.equalTo(wmPlayer.playOrPauseBtn).with.offset(25);
            make.width.mas_equalTo(250);
        }];
        
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        wmPlayer.fullScreenBtn.selected = NO;
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }];
}


#pragma mark FinishView delegate
-(void)repalyAction{
    wmPlayer.playOrPauseBtn.selected=NO;
    ShiPinModel *model = [_dataArraytui objectAtIndex:currentIndexPath.section];
    [wmPlayer setVideoURLStr:model.video_path];
    [wmPlayer.player play];
    [finishView removeFromSuperview];
}

-(void)shareAction{
    [finishView removeFromSuperview];
    if (!shareView) {
        shareView=[[ShareView alloc] init];
    }
    shareView.delegate=self;
    shareView.transform=CGAffineTransformMakeRotation(-M_PI_2);
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([UIApplication sharedApplication].keyWindow).with.offset(250);
        make.width.mas_equalTo(SCREEN_FRAME.size.height-200);
        make.right.equalTo([UIApplication sharedApplication].keyWindow).with.offset((SCREEN_FRAME.size.width-200)/2);
        make.height.mas_equalTo(200);
    }];
}
//点击分享之后分享
-(void)sharedAction{
    [self closeTheVideo:nil];
}

-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    [self releaseWMPlayer];
}






//返回高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShiPinModel *model = _dataArraytui[indexPath.row];
    NSArray * imgs = [[NSArray alloc] init];
    if ([model.img_path isEqualToString:@""]) {
    }else if (model.img_path) {
        imgs  = [model.img_path componentsSeparatedByString:@","];
    }
    NSString * url = model.video_path;
    return  [ReTableViewCell cellHeightWithStr:model.txt_content imgs:imgs str:url];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    VideoModel *   model = [dataSource objectAtIndex:indexPath.section];
    //    DetailViewController *detailVC = [[DetailViewController alloc]init];
    //    detailVC.URLString  = model.m3u8_url;
    //    detailVC.title = model.title;
    //    detailVC.URLString = model.mp4_url;
    //    [self.navigationController pushViewController:detailVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end