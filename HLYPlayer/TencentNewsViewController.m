//
//  TencentNewsViewController.m
//  TencentNews
//
//  Created by DengShiru on 16/2/12.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "TencentNewsViewController.h"
#import "VideoCell.h"
#import "VideoModel.h"
#import "HLYPlayer.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "DMHeartFlyView.h"
#import "NSString+ML.h"
#import "SharedAction.h"
#import "ShareView.h"
#import "FinishView.h"
#define STATUS_BAR_HEIGHT               20
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_FRAME [UIScreen mainScreen].bounds
@interface TencentNewsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,VideoCellDegate,ShareViewDelegate,FinishViewDelegate>{
    HLYPlayer *wmPlayer;   //播放器
    NSIndexPath *currentIndexPath;//当前播放cell的indexpath
    ShareView *shareView;//分享显示的视图
    FinishView *finishView;
}
//当前播放的cell
@property(nonatomic,retain)VideoCell *currentCell;
/**
 *  心大小
 */
@property (nonatomic, assign)CGFloat heartSize;
@end

@implementation TencentNewsViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
    [self.table registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];
    //关闭通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeTheVideo:)
                                                 name:@"closeTheVideo"
                                               object:nil
     ];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(onDeviceOrientationChange)
//                                                 name:UIDeviceOrientationDidChangeNotification
//                                               object:nil
//     ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMJRefresh];//在这里设置下啦刷新和加载
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
            finishView.frame = CGRectMake(80, 200, SCREEN_FRAME.size.width-160, SCREEN_FRAME.size.height-400);
        }
        [[UIApplication sharedApplication].keyWindow addSubview:finishView];
    }else{
    //将cell上的播放按钮放到最上层
        [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
        [self.currentCell.playBtn setImage:[UIImage imageNamed:@"plays"] forState:UIControlStateNormal];
        [self.currentCell.blackView.superview bringSubviewToFront:self.currentCell.blackView];
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
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
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
     VideoCell *currentCell = [self currentCell];
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
            make.height.mas_equalTo(5);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        
        [wmPlayer.playOrPauseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((SCREEN_FRAME.size.width-50)/2);
            make.height.mas_equalTo(50);
            make.top.equalTo(wmPlayer).with.offset(66);
            make.width.mas_equalTo(50);
        }];
        
        [wmPlayer.loadFaildLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((SCREEN_FRAME.size.width-250)/2);
            make.height.mas_equalTo(20);
            make.bottom.equalTo(wmPlayer.playOrPauseBtn).with.offset(25);
            make.width.mas_equalTo(250);
        }];
        
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        wmPlayer.fullScreenBtn.selected = NO;
        [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
    }];
}

//全屏播放模式
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
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
        make.height.mas_equalTo(5);
        make.top.mas_equalTo(SCREEN_FRAME.size.width-5);
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

//添加下拉刷新和上拉加载
-(void)addMJRefresh{
}
                     
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoModel *model=[_dataSource objectAtIndex:indexPath.section];
    return 300+[NSString sizeHeightWithString:model.content font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_FRAME.size.width-32, MAXFLOAT)].height+4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"VideoCell";
    VideoCell *cell= (VideoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        [cell.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
    //将数据传给cell
    cell.model = [_dataSource objectAtIndex:indexPath.section];
    [cell.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
    cell.playBtn.tag = indexPath.section;
    cell.delegate=self;
    if (wmPlayer&&wmPlayer.superview) {
        if (indexPath==currentIndexPath) {
            [cell.playBtn.superview sendSubviewToBack:cell.playBtn];
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
    return cell;
}
//开始播放或者暂停
-(void)startPlayVideo:(UIButton *)sender{
    currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
    VideoModel *model = [_dataSource objectAtIndex:sender.tag];
    [self showOrHidTimesWithType:NO];
    self.currentCell = (VideoCell *)sender.superview.superview;
    if (wmPlayer) {
        [wmPlayer removeFromSuperview];
        [wmPlayer setVideoURLStr:model.mp4s_url];
        [wmPlayer.player play];
    }else{
        wmPlayer = [[HLYPlayer alloc]initWithFrame:self.currentCell.backgroundIV.bounds videoURLStr:model.mp4s_url];
        wmPlayer.closeBtn.hidden=YES;
        [wmPlayer.player play];
    }
    [self showOrHidTimesWithType:YES];
    [self.currentCell.backgroundIV addSubview:wmPlayer];
    [self.currentCell.backgroundIV bringSubviewToFront:wmPlayer];
    [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
    [self.table reloadData];
}

//判断tableview的滑动  当超出屏幕时停止播放
#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView ==self.table){
        if (wmPlayer==nil) {
            return;
        }
        if (wmPlayer.superview) {
            CGRect rectInTableView = [self.table rectForRowAtIndexPath:currentIndexPath];
            CGRect rectInSuperview = [self.table convertRect:rectInTableView toView:[self.table superview]];
            //判断时否处于屏幕外面
            if (rectInSuperview.origin.y<-self.currentCell.contentView.frame.size.height||rectInSuperview.origin.y>self.view.frame.size.height) {//往上拖动
                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]) {
                    //在屏幕外的时候 停止播放
                    [self showOrHidTimesWithType:NO];
                    [self.currentCell.blackView.superview sendSubviewToBack:self.currentCell.blackView];
                    [self toCell];
                    [self.currentCell.playBtn.superview bringSubviewToFront:self.currentCell.playBtn];
                    [self releaseWMPlayer];
                    //暂停播放
//                    [wmPlayer.player pause];
                    [self.currentCell.playBtn setImage:[UIImage imageNamed:@"plays"] forState:UIControlStateNormal];
                    [self showOrHidTimesWithType:NO];
                }else{
                    //在屏幕外的时候 停止播放
                    [self showOrHidTimesWithType:NO];
                    [self.currentCell.blackView.superview sendSubviewToBack:self.currentCell.blackView];
                    [self toCell];
                    [self.currentCell.playBtn.superview bringSubviewToFront:self.currentCell.playBtn];
                    [self releaseWMPlayer];

                    //暂停播放
//                    [wmPlayer.player pause];
                    [self.currentCell.playBtn setImage:[UIImage imageNamed:@"plays"] forState:UIControlStateNormal];
                    [self showOrHidTimesWithType:NO];
                }
            }else{
                if ([self.currentCell.backgroundIV.subviews containsObject:wmPlayer]) {
                    
                }else{
                    [self toCell];
                }
            }
        }else{
            CGRect rectInTableView = [self.table rectForRowAtIndexPath:currentIndexPath];
            CGRect rectInSuperview = [self.table convertRect:rectInTableView toView:[self.table superview]];
            if (rectInSuperview.origin.y<-self.currentCell.contentView.frame.size.height||rectInSuperview.origin.y>self.view.frame.size.height) {//往上拖动
            [self showOrHidTimesWithType:NO];
            [self.currentCell.blackView.superview sendSubviewToBack:self.currentCell.blackView];
            [self.currentCell.playBtn.superview bringSubviewToFront:self.currentCell.playBtn];
            }
        }
    }
}

//这里是点击cell  查看详情  这里下先注释掉了
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    VideoModel *   model = [dataSource objectAtIndex:indexPath.section];
//    DetailViewController *detailVC = [[DetailViewController alloc]init];
//    detailVC.URLString  = model.m3u8_url;
//    detailVC.title = model.title;
//    detailVC.URLString = model.mp4_url;
//    [self.navigationController pushViewController:detailVC animated:YES];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark VideoCell delegate
//点赞的动画效果  
-(void)likeAction:(id)sender{
    UIImageView *like =sender;
    _heartSize = 36;
    DMHeartFlyView* heart = [[DMHeartFlyView alloc]initWithFrame:CGRectMake(-15, 0, _heartSize, _heartSize)];
    [self.view addSubview:heart];
    CGRect rect = [self.view convertRect:like.frame fromView:like.superview];
    CGPoint fountainSource = CGPointMake(rect.origin.x+20, rect.origin.y);
    heart.center = fountainSource;
    [heart animateInView:self.view];
    
    // button点击动画
    CAKeyframeAnimation *btnAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    btnAnimation.values = @[@(1.0),@(0.7),@(0.5),@(0.3),@(0.5),@(0.7),@(1.0), @(1.2), @(1.4), @(1.2), @(1.0)];
    btnAnimation.keyTimes = @[@(0.0),@(0.1),@(0.2),@(0.3),@(0.4),@(0.5),@(0.6),@(0.7),@(0.8),@(0.9),@(1.0)];
    
    btnAnimation.calculationMode = kCAAnimationLinear;
    btnAnimation.duration = 0.3;
    [like.layer addAnimation:btnAnimation forKey:@"SHOW"];
}
//重播
-(void)reloadAction{
    VideoModel *model = [_dataSource objectAtIndex:currentIndexPath.section];
    [wmPlayer removeFromSuperview];
    [wmPlayer setVideoURLStr:model.mp4s_url];
    [wmPlayer.player play];
    wmPlayer.playOrPauseBtn.selected=NO;
    [self showOrHidTimesWithType:YES];
    
    [self.currentCell.backgroundIV addSubview:wmPlayer];
    [self.currentCell.backgroundIV bringSubviewToFront:wmPlayer];
    [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
    [self.table reloadData];
}
-(void)showOrHidTimesWithType:(BOOL)type{
    self.currentCell.times.hidden=type;
    self.currentCell.timess.hidden=type;
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
#pragma mark FinishView delegate
-(void)repalyAction{
    wmPlayer.playOrPauseBtn.selected=NO;
    VideoModel *model = [_dataSource objectAtIndex:currentIndexPath.section];
    [wmPlayer setVideoURLStr:model.mp4s_url];
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
@end
