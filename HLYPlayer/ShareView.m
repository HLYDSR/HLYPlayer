//
//  ShareView.m
//  HLYPlayer
//
//  Created by DengShiru on 16/8/15.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "ShareView.h"
#import "Masonry.h"
@implementation ShareView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha=0.8;
        self.layer.cornerRadius=10;
        self.clipsToBounds=YES;
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIView *view=[[UIView alloc] init];
    view.backgroundColor=[UIColor grayColor];
    [self addSubview:view];
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(40);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(self.frame.size.height);
        make.left.equalTo(self).with.offset(0);
    }];

    UIButton *closeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    [closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.right.equalTo(self).with.offset(-5);
    }];
    
    UIButton *weiChatBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [weiChatBtn setImage:[UIImage imageNamed:@"Card-wechat"] forState:UIControlStateNormal];
    [weiChatBtn addTarget:self action:@selector(weixinAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:weiChatBtn];
    
    [weiChatBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).with.offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.equalTo(self).with.offset((self.frame.size.height-320)/5);
    }];
    UILabel *weixinlabel =[[UILabel alloc] init];
    weixinlabel.text=@"微信";
    weixinlabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:weixinlabel];
    [weixinlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weiChatBtn).with.offset(45);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
        make.left.equalTo(self).with.offset((self.frame.size.height-320)/5);
    }];
    

    
    UIButton *frinedBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [frinedBtn setImage:[UIImage imageNamed:@"weixinpengyou_popover"] forState:UIControlStateNormal];
    [frinedBtn addTarget:self action:@selector(frinedAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:frinedBtn];
    
    [frinedBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).with.offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.equalTo(self).with.offset(2*(self.frame.size.height-320)/5+80);
    }];
    
    UILabel *frinelabel =[[UILabel alloc] init];
    frinelabel.text=@"朋友圈";
    frinelabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:frinelabel];
    [frinelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(frinedBtn).with.offset(45);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
        make.left.equalTo(self).with.offset(2*(self.frame.size.height-320)/5+80);
    }];
    
    UIButton *qqBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [qqBtn setImage:[UIImage imageNamed:@"Card-qq"] forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(qqAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:qqBtn];
    
    [qqBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).with.offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.equalTo(self).with.offset(3*(self.frame.size.height-320)/5+160);
    }];
    
    UILabel *qqlabel =[[UILabel alloc] init];
    qqlabel.text=@"QQ";
    qqlabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:qqlabel];
    [qqlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(qqBtn).with.offset(45);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
        make.left.equalTo(self).with.offset(3*(self.frame.size.height-320)/5+160);
    }];
    
    UIButton *weiboBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [weiboBtn setImage:[UIImage imageNamed:@"Card-weibo"] forState:UIControlStateNormal];
    [weiboBtn addTarget:self action:@selector(weiboAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:weiboBtn];
    
    [weiboBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).with.offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.equalTo(self).with.offset(4*(self.frame.size.height-320)/5+240);
    }];
    
    UILabel *weibolabel =[[UILabel alloc] init];
    weibolabel.text=@"微博";
    weibolabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:weibolabel];
    [weibolabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weiboBtn).with.offset(45);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
        make.left.equalTo(self).with.offset(4*(self.frame.size.height-320)/5+240);
    }];
}
-(void)closeAction{
    [self.delegate closeAction];
}
-(void)weixinAction{
    [self.delegate weixinAction];
}
-(void)frinedAction{
    [self.delegate frinedAction];
}
-(void)qqAction{
   [self.delegate qqAction];
}
-(void)weiboAction{
    [self.delegate weiboAction];
}
@end
