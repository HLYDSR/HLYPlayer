//
//  ReTableViewCell.m
//  SunShine
//
//  Created by 阳光互联 on 16/6/30.
//  Copyright © 2016年 阳光互联. All rights reserved.
//

#import "ReTableViewCell.h"
#import "UIImage+Extension.h"
#import "NSString+Extension.h"

#import "GlobalUI.h"

#import "UIImageView+WebCache.h"

#import "Reachability.h"    //网络状态
#import "AFNetworking.h"

#import "CommonDefi.h"



#import "DMHeartFlyView.h"

#define imgHeight  (CGRectGetWidth([UIScreen mainScreen].bounds))/3
#define imaHeight2  (CGRectGetWidth([UIScreen mainScreen].bounds))/2
#define wk CGRectGetWidth([UIScreen mainScreen].bounds)



//视频
#import <AVFoundation/AVFoundation.h>



@interface ReTableViewCell ()
@property (nonatomic, assign)CGFloat heartSize;


@property (nonatomic,strong) UIView  * bgImgsView; // 9张图片bgView
@property (nonatomic,strong) NSArray * imgArray;
@property (nonatomic,strong) NSMutableArray * groupImgArr;



@property (nonatomic,strong) Reachability *reachNet;//网络状态判断


@property(nonatomic,assign)int viewHeight;


@property (nonatomic,strong) UILabel * xianLabel;
@property (nonatomic,strong) UILabel * xiaLabel;
//发布用户头像url
@property (strong, nonatomic) UIImageView *header_path;


//内容审核通过时间
@property (nonatomic, strong)UILabel *publish_at;

//内容发布时间
@property(nonatomic,strong)UILabel * create_at;

//文本内容
@property (nonatomic, strong)UILabel *txt_content;
//视频图片url
@property (nonatomic, strong)UIImageView *video_image;

//标签图片名
@property (nonatomic, strong)UIImageView *tag_icon_name;

//标签名
@property (nonatomic, strong)UILabel *tag_name;

//点赞(喜欢)数
@property (nonatomic, strong)UIButton *likes;

//踩(不喜欢)数
@property (nonatomic, strong)UIButton *dislikes;
//分享数
@property (nonatomic, strong)UIButton *shares;
// 是否赞(顶)过
@property(nonatomic,copy)NSString * has_like;

// 是否不喜欢(踩)过
@property(nonatomic,copy)NSString * has_dislike;

// 是否分享过
@property(nonatomic,copy)NSString * has_share;

//点赞
@property(nonatomic,assign)BOOL islikes;
//踩
@property(nonatomic,assign)BOOL isdislikes;
//分享
@property(nonatomic,assign)BOOL isShar;
//赞
@property(nonatomic,assign)int has_lik;
@property(nonatomic,assign)int has_dislik;


@end


@implementation ReTableViewCell



-(Reachability *)reachNet{
    if (_reachNet == nil) {
        //reachabilityForInternetConnection 是否连接网络
        _reachNet = [Reachability reachabilityForInternetConnection];
    }
    return _reachNet;
}



//3
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
   
     _bgImgsView = [[UIView alloc]init];
//    _vide_View = [[UIView alloc] init];
//    _vide_View.backgroundColor = [UIColor clearColor];
    
    _backgroundIV= [[UIImageView alloc] init];
    _playBtn = [[UIButton alloc] init];
    [_playBtn setImage:[UIImage imageNamed:@"vedioIcon-1"] forState:UIControlStateNormal];
//    _blackView = [[UIView alloc] init];
//    _blackView.alpha = 0.9;
    //头像
    _header_path = [GlobalUI createImageViewbgColor:[UIColor whiteColor]];
    _header_path.image = [[UIImage imageNamed:@"banner_bg"] clipImageWithRadius:15];
    self.header_path.layer.cornerRadius = 19;
    self.header_path.layer.masksToBounds = YES;
    _headbtn = [GlobalUI createButtonWithImg:[UIImage imageNamed:@""] title:@"" titleColor:[UIColor clearColor]];

    //用户名称
    _nick_name = [GlobalUI createButtonWithImg:[UIImage imageNamed:@""] title:@"用户昵称" titleColor:[UIColor grayColor]];
    _nick_name.titleLabel.font = [UIFont fontWithName:@"PingFang TC" size:14];
    _nick_name.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_nick_name setTitleColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1] forState:UIControlStateNormal];
    
    //发布时间
    _create_at = [GlobalUI createLabelFont:12 titleColor:[UIColor blackColor] bgColor:[UIColor whiteColor]];
    _create_at.textColor = kRGB(172, 172, 172);
    //内容
    _txt_content = [GlobalUI createLabelFont:15 titleColor:[UIColor blackColor] bgColor:[UIColor whiteColor]];
    _txt_content.textColor = kRGB(71, 71, 71);
    _txt_content.numberOfLines = 0;
    _text_contBtn = [GlobalUI createButtonWithImg:[UIImage imageNamed:@""] title:@"" titleColor:[UIColor grayColor]];
    //文字格式
//    NSLog(@"%@", [UIFont familyNames]);
     _txt_content.font = [UIFont fontWithName:@"PingFang TC" size:15];
    
    //分类
    _category_name = [GlobalUI createButtonWithImg:[UIImage imageNamed:@""] title:@"" titleColor:[UIColor grayColor]];
    _category_name.titleLabel.font = [UIFont fontWithName:@"PingFang TC" size:14];
    _category_name.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_category_name setTitleColor:[UIColor colorWithRed:255/255.0 green:185/255.0 blue:34/255.0 alpha:1] forState:UIControlStateNormal];
    //圆角
    _category_name.layer.cornerRadius = 10;
    _category_name.layer.masksToBounds = YES;
    //边框
    _category_name.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:185/255.0 blue:34/255.0 alpha:1] CGColor];
    _category_name.layer.borderWidth = 1.0f;
    
    
    
    //标签图片
    _tag_icon_name = [GlobalUI createImageViewbgColor:[UIColor whiteColor]];
    _tag_icon_name.image = [[UIImage imageNamed:@""] clipImageWithRadius:8];

    //标签名字
    _tag_name = [GlobalUI createLabelFont:14 titleColor:[UIColor grayColor] bgColor:[UIColor whiteColor]];

    //点赞
    _likes = [GlobalUI createButtonWithImg:[UIImage imageNamed:@"contentGoodIconNl-1"] title:@"" titleColor:[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1]];
   _likes.titleLabel.font = [UIFont fontWithName:@"PingFang TC" size:13];
    [self.likes addTarget:self action:@selector(likezan:) forControlEvents:UIControlEventTouchUpInside];
    //踩
    _dislikes = [GlobalUI createButtonWithImg:[UIImage imageNamed:@"contentGoodIconNl"] title:@"" titleColor:[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1]];
    _dislikes.titleLabel.font = [UIFont fontWithName:@"PingFang TC" size:13];
     [self.dislikes addTarget:self action:@selector(nolike:) forControlEvents:UIControlEventTouchUpInside];
  

    //评论
    _comments = [GlobalUI createButtonWithImg:[UIImage imageNamed:@"contentCommentIconNl"] title:@"" titleColor:[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1]];
    _comments.titleLabel.font = [UIFont fontWithName:@"PingFang TC" size:13];
      //分享
    _shares = [GlobalUI createButtonWithImg:[UIImage imageNamed:@"contentShareIconNl-1"] title:@"" titleColor:[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1]];
    _shares.titleLabel.font = [UIFont fontWithName:@"PingFang TC" size:13];
    //分享
    [self.shares addTarget:self action:@selector(shar:) forControlEvents:UIControlEventTouchUpInside];
   
    _xianLabel = [[UILabel alloc] init];
    _xianLabel.backgroundColor = kRGB(245, 245, 245);
    _xiaLabel = [[UILabel alloc] init];
    _xiaLabel.backgroundColor = kRGB(240, 240, 240);
    //弹窗
   _tanchaung = [GlobalUI createButtonWithImg:[UIImage imageNamed:@""] title:@"" titleColor:[UIColor grayColor]];
    [_tanchaung setBackgroundImage:[UIImage imageNamed:@"contentIconMore"] forState:UIControlStateNormal];

    [self.contentView addSubview:_header_path];
    [self.contentView addSubview:_headbtn];
    [self.contentView addSubview:_nick_name];
    [self.contentView addSubview:_create_at];
    [self.contentView addSubview:_tanchaung];
    [self.contentView addSubview:_txt_content];
    [self.contentView addSubview:_text_contBtn];
    [self.contentView addSubview:_category_name];
    [self.contentView addSubview:_tag_icon_name];
    [self.contentView addSubview:_tag_name];
    [self.contentView addSubview:_likes];
    [self.contentView addSubview:_dislikes];
    [self.contentView addSubview:_comments];
    [self.contentView addSubview:_shares];
    [self.contentView addSubview:_xianLabel];
    [self.contentView addSubview:_xiaLabel];
    [self.contentView addSubview:_bgImgsView];
    _groupImgArr = [NSMutableArray array];
    
}


//7
- (void)layoutSubviews{
    [super layoutSubviews];

    //头像
    _header_path.frame = CGRectMake(12.5, 12.5, 38, 38);
    _headbtn.frame = CGRectMake(12.5, 12.5, 38, 38);

    //名字的宽度
    float width = [self.nick_name.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 100) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.width+10;
    //名称
    _nick_name.frame = CGRectMake(62, 13, width, 21);

    //时间
    _create_at.frame = CGRectMake(CGRectGetMaxX(_header_path.frame) + 10, CGRectGetMinY(_nick_name.frame) + 17, CGRectGetWidth(self.contentView.bounds) - CGRectGetMaxX(_header_path.frame) + 13, 21);
    
    //弹窗
    _tanchaung.frame = CGRectMake(wk - 36, 24, 16, 16);
    
    CGFloat contentHeight = [_txt_content.text heightWithWidth:CGRectGetWidth(self.contentView.bounds) - 40 font:14];
    //文本内容
    _txt_content.frame = CGRectMake(12.5, CGRectGetMaxY(_header_path.frame) + 20, CGRectGetWidth(self.contentView.bounds) - 40, contentHeight);
    _text_contBtn.frame = CGRectMake(12.5, CGRectGetMaxY(_header_path.frame) + 20, CGRectGetWidth(self.contentView.bounds) - 40, contentHeight);
    //分类名字
     _category_name.frame = CGRectMake(12.5,CGRectGetMaxY(_bgImgsView.frame)+ 12, kScreenWidth/4-20, 20);
    
    
    //标签图片
     _tag_icon_name.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 70, CGRectGetMaxY(_bgImgsView.frame)+ 12, 20, 20);
    
    //标签名字
    _tag_name.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 40, CGRectGetMaxY(_bgImgsView.frame)+ 12, 30, 20);
    
    if (self.video_path) {
//        _bgImgsView = nil;
        if ([self.video_path isEqual:@"(null)"]) {
            NSLog(@"0");
        }else if (self.video_path == nil) {
            NSLog(@"1");
        }else if ([self.video_path isEqual:[NSNull null]]){
            NSLog(@"2");
        }else{

            
            _bgImgsView.frame = CGRectMake(0, CGRectGetMaxY(_txt_content.frame) + 10, CGRectGetWidth([UIScreen mainScreen].bounds), 200);
            _bgImgsView.backgroundColor = [UIColor redColor];
            
            
            

            _backgroundIV.image=[UIImage imageNamed:@"66.jpg"];
            _backgroundIV.frame =  _bgImgsView.frame;
            
            
            _playBtn.frame = CGRectMake(50, CGRectGetMaxY(_txt_content.frame) + 20,50, 50);
            
            
            [self.contentView addSubview:_backgroundIV];
            [self.contentView addSubview:_playBtn];
            
            
  
            
        }
    }else if (_imgArray.count == 1){
        
        UIImageView * img1 =[[UIImageView alloc]init];
        NSString * strurl = [NSString stringWithFormat:@"%@?w=%f",_imgArray[0],kScreenWidth];
        [img1 sd_setImageWithURL:[NSURL URLWithString:strurl]];
        CGFloat a = img1.image.size.height;
        _bgImgsView.frame = CGRectMake(0, CGRectGetMaxY(_txt_content.frame) + 10, CGRectGetWidth([UIScreen mainScreen].bounds), a);
    }else if (_imgArray.count == 2 || _imgArray.count == 4){
        NSInteger row = _imgArray.count / 2;
        if (_imgArray.count %2 != 0 ) {
            ++row;
        }
        // 是否有图片，如果有图片  高度= 图片的总高度 + 中间的间距 ，如果没有 ，高度=0
        CGFloat bgH = _imgArray.count ? row * imaHeight2 + (row-1) * 3 :0;
        
        _bgImgsView.frame = CGRectMake(0, CGRectGetMaxY(_txt_content.frame) + 10, CGRectGetWidth([UIScreen mainScreen].bounds), bgH);
        
    }else{
        NSInteger row = _imgArray.count / 3;// 多少行图片
        if (_imgArray.count %3 !=0) {
            ++row;
        }
        // 是否有图片，如果有图片  高度= 图片的总高度 + 中间的间距 ，如果没有 ，高度=0
        CGFloat bgH = _imgArray.count ? row * imgHeight + (row-1) * 3 :0;
        
        _bgImgsView.frame = CGRectMake(0, CGRectGetMaxY(_txt_content.frame) + 10, CGRectGetWidth([UIScreen mainScreen].bounds), bgH);
        
    }
    _xianLabel.frame = CGRectMake(0,CGRectGetMaxY(_category_name.frame) + 10, wk, 1);
    _likes.frame = CGRectMake(0,CGRectGetMaxY(_category_name.frame) + 20 , wk / 4, 30);
    _dislikes.frame = CGRectMake(wk / 4, CGRectGetMaxY(_category_name.frame) + 20, wk / 4, 30);
    _comments.frame = CGRectMake(wk / 2,CGRectGetMaxY(_category_name.frame) + 20, wk / 4, 30);
    _shares.frame = CGRectMake(wk / 4 * 3, CGRectGetMaxY(_category_name.frame) + 20, wk / 4, 30);
}


//5
- (void)setModel:(ShiPinModel *)model{

    //头像
    if (model.header_path) {
        [self.header_path sd_setImageWithURL:[NSURL URLWithString:model.header_path]];
        
    }else{
        
        [self.header_path setImage:[UIImage imageNamed:@"ioc"]];
    }
    //昵称
    if (model.nick_name) {
        
       [self.nick_name setTitle:model.nick_name forState:UIControlStateNormal];
    }else{
        int i = 1;
        i++;
        [self.nick_name setTitle:[NSString stringWithFormat:@"系统用户%d",i] forState:UIControlStateNormal];
    }
    
    //时间
    _create_at.text = model.publish_at;
    //文本内容
    _txt_content.text = model.txt_content;
    
    //视频接口
    self.video_path = model.video_path;

   
    
    //分类名称
    [self.category_name setTitle:model.category_name forState:UIControlStateNormal];
    //标签图片
    [_tag_icon_name sd_setImageWithURL:[NSURL URLWithString:model.tag_icon_name]];
    //标签名字
    _tag_name.text = model.tag_name;
   
    //赞
    [_likes setTitle:[NSString stringWithFormat:@" %@",model.likes] forState:UIControlStateNormal];
    //踩
    [_dislikes setTitle:[NSString stringWithFormat:@" %@",model.dislikes] forState:UIControlStateNormal];
    //评论
    [_comments setTitle:[NSString stringWithFormat:@" %@",model.comments] forState:UIControlStateNormal];
    //分享
    [_shares setTitle:[NSString stringWithFormat:@" %@",model.shares] forState:UIControlStateNormal];
   
    //内容id
    self.ID = model.ID;

    //分类id
    self.catid = model.catid;
    
    //标签id
    self.tagid = model.tagid;
    
    //用户id
    self.uid = model.uid;
    
    
    //是否赞(顶)过
    self.has_like = model.has_like;

     _has_lik = [self.has_like intValue];

    if (_has_lik == 1) {

        _islikes = NO;
        [self.likes setImage:[UIImage imageNamed:@"contentGoodIconHl-1"] forState:UIControlStateNormal];
        self.dislikes.enabled = NO;
        [self.dislikes setImage:[UIImage imageNamed:@"contentGoodIconNl"] forState:UIControlStateDisabled];

    }else if (_has_lik == 0){
        _islikes = YES;
        [self.likes setImage:[UIImage imageNamed:@"contentGoodIconNl-1"] forState:UIControlStateNormal];
         self.dislikes.enabled = YES;
    }
    

    // 是否不喜欢(踩)过
    self.has_dislike = model.has_dislike;

    _has_dislik = [self.has_dislike intValue];
    
    if (_has_dislik == 1) {
        
        _isdislikes = NO;
        [self.dislikes setImage:[UIImage imageNamed:@"contentGoodIconHl"] forState:UIControlStateNormal];
        self.likes.enabled = NO;
        [self.likes setImage:[UIImage imageNamed:@"contentGoodIconNl-1"] forState:UIControlStateDisabled];
        
    }else if (_has_dislik == 0){
        _isdislikes = YES;
        [self.dislikes setImage:[UIImage imageNamed:@"contentGoodIconNl"] forState:UIControlStateNormal];
        self.likes.enabled = YES;
    }

    //是否分享过
    self.has_share = model.has_share;
    int has_sha = [self.has_share intValue];
    
    if (has_sha == 0) {
        
        _isShar = YES;
        [self.shares setImage:[UIImage imageNamed:@"contentShareIconNl-1"] forState:UIControlStateNormal];
        
    }else if (has_sha == 1){
        
        _isShar = NO;
        [self.shares setImage:[UIImage imageNamed:@"contentShareIconHl-1"] forState:UIControlStateNormal];
    }

    

    
    if (_groupImgArr.count) {
        [_groupImgArr enumerateObjectsUsingBlock:^(UIImageView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [_groupImgArr removeAllObjects];
    }
    _imgArray = [model.img_path componentsSeparatedByString:@","];
    if (_imgArray.count) {
        [self setupImageGroupView];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

//6
- (void)setupImageGroupView{
    
     if (_imgArray.count == 1){
        UIImageView * img1 =[[UIImageView alloc]init];
        NSString * strurl = [NSString stringWithFormat:@"%@?w=%f",_imgArray[0],kScreenWidth];
        [img1 sd_setImageWithURL:[NSURL URLWithString:strurl]];
        
        CGFloat a = img1.image.size.height;
        img1.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), a);
      
        img1.userInteractionEnabled = YES;
        
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
//        
//        [img1 addGestureRecognizer:tap];
        [_bgImgsView addSubview:img1];
        [_groupImgArr addObject:img1];
        
        
    }else if(_imgArray.count == 2 || _imgArray.count == 4){
        CGFloat w = imaHeight2;
        CGFloat h = imaHeight2;
        
        CGFloat edge = 3;
        for (int i = 0; i<_imgArray.count; i++) {
            
            int row = i / 2;
            int loc = i % 2;
            CGFloat x = (edge + w) * loc ;
            CGFloat y = (edge + h) * row;
            
            UIImageView * img2=[[UIImageView alloc]init];
            [img2 sd_setImageWithURL:[NSURL URLWithString:_imgArray[i]]];
           
    
            img2.frame = CGRectMake(x, y, w, h);
            img2.userInteractionEnabled = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
            [img2 addGestureRecognizer:tap];
            [_bgImgsView addSubview:img2];
            [_groupImgArr addObject:img2];
        }
        
        
    }else {
        CGFloat w = imgHeight;
        CGFloat h = imgHeight;
        
        CGFloat edge = 3;
        for (int i = 0; i<_imgArray.count; i++) {
            
            int row = i / 3;
            int loc = i % 3;
            CGFloat x = (edge + w) * loc ;
            CGFloat y = (edge + h) * row;
            
            UIImageView * img =[[UIImageView alloc]init];
            [img sd_setImageWithURL:[NSURL URLWithString:_imgArray[i]]];
            
            img.frame = CGRectMake(x, y, w, h);
            img.userInteractionEnabled = YES;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
            [img addGestureRecognizer:tap];
            [_bgImgsView addSubview:img];
            [_groupImgArr addObject:img];
        }
    }
}

#pragma mark - brower image
//8
- (void)browerImage:(UITapGestureRecognizer *)gest{
//    UIImageView * tapView = (UIImageView *)gest.view;
//    XHImageViewer * brower  = [[XHImageViewer alloc]init];
//    [brower showWithImageViews:_groupImgArr selectedView:tapView];
}
//1
+ (CGFloat)cellHeightWithStr:(NSString *)str imgs:(NSArray *)imgs str:(NSString *)videUrl{
    CGFloat strH = [str heightWithWidth:CGRectGetWidth([UIScreen mainScreen].bounds) - 40 font:14];
    CGFloat cellH = strH + 170;
    if (videUrl) {
        
        if ([videUrl isEqual:@"(null)"]) {
            NSLog(@"0");
        }else if (videUrl == nil) {
            NSLog(@"1");
        }else if ([videUrl isEqual:[NSNull null]]){
            NSLog(@"2");
        }else{
            cellH += 200;
        }
    }else if(imgs.count == 1){
        UIImageView * img1 =[[UIImageView alloc]init];
        NSString * strurl = [NSString stringWithFormat:@"%@?w=%f",imgs[0],kScreenWidth];
        [img1 sd_setImageWithURL:[NSURL URLWithString:strurl]];

        CGFloat a = img1.image.size.height;
        
        cellH += a;
    }else if(imgs.count == 2 || imgs.count == 4){
        NSInteger row = imgs.count / 2 ;
        if (imgs.count) {
            if ( imgs.count % 2 !=0) {
                row += 1;
            }
            cellH +=  row * imaHeight2  + (row-1) * 10; // 图片高度 + 间隙
        }
        
    }else{
        NSInteger row = imgs.count / 3 ;
        if (imgs.count) {
            if ( imgs.count % 3 !=0) {
                row += 1;
            }
            cellH +=  row * imgHeight  + (row-1) * 10; // 图片高度 + 间隙
        }
        
    }
    
    return  cellH;
}
//2
+ (ReTableViewCell *)dynamicCellWithTable:(UITableView *)table{
    ReTableViewCell * cell = [table dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (cell==nil) {
        cell = [[ReTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
    }else{
        NSLog(@"123");
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}






//点赞
- (void)likezan:(UIButton *)seder{
    UIImageView *like =(UIImageView *)seder;
    _heartSize = 32;
    DMHeartFlyView* heart = [[DMHeartFlyView alloc]initWithFrame:CGRectMake(0, 0, _heartSize, _heartSize)];
    [self.contentView addSubview:heart];
    CGRect rect = [self.contentView convertRect:like.frame fromView:like.superview];
    CGPoint fountainSource = CGPointMake(rect.origin.x+40, rect.origin.y);
    heart.center = fountainSource;
    [heart animateInView:self.contentView];
    // button点击动画
    CAKeyframeAnimation *btnAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    btnAnimation.values = @[@(1.0),@(0.7),@(0.5),@(0.3),@(0.5),@(0.7),@(1.0), @(1.2), @(1.4), @(1.2), @(1.0)];
    btnAnimation.keyTimes = @[@(0.0),@(0.1),@(0.2),@(0.3),@(0.4),@(0.5),@(0.6),@(0.7),@(0.8),@(0.9),@(1.0)];
    btnAnimation.calculationMode = kCAAnimationLinear;
    btnAnimation.duration = 0.3;
    [like.layer addAnimation:btnAnimation forKey:@"SHOW"];
    

}


//下踩
- (void)nolike:(UIButton *)seder{
    
    UIImageView *like =(UIImageView *)seder;
    _heartSize = 32;
    DMHeartFlyView* heart = [[DMHeartFlyView alloc]initWithFrame:CGRectMake(0, 0, _heartSize, _heartSize)];
    [self.contentView addSubview:heart];
    CGRect rect = [self.contentView convertRect:like.frame fromView:like.superview];
    CGPoint fountainSource = CGPointMake(rect.origin.x+40, rect.origin.y);
    heart.center = fountainSource;
    [heart animateInView:self.contentView];
    // button点击动画
    CAKeyframeAnimation *btnAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    btnAnimation.values = @[@(1.0),@(0.7),@(0.5),@(0.3),@(0.5),@(0.7),@(1.0), @(1.2), @(1.4), @(1.2), @(1.0)];
    btnAnimation.keyTimes = @[@(0.0),@(0.1),@(0.2),@(0.3),@(0.4),@(0.5),@(0.6),@(0.7),@(0.8),@(0.9),@(1.0)];
    btnAnimation.calculationMode = kCAAnimationLinear;
    btnAnimation.duration = 0.3;
    [like.layer addAnimation:btnAnimation forKey:@"SHOW"];
}


//分享
- (void)shar:(UIButton *)seder{
 }



@end
