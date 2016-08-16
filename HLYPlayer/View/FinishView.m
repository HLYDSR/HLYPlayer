//
//  FinishView.m
//  HLYPlayer
//
//  Created by DengShiru on 16/8/15.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "FinishView.h"
#import "Masonry.h"
@implementation FinishView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha=0.8;
        self.layer.cornerRadius=10;
        self.clipsToBounds=YES;
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    _chooseView=[[UIView alloc] init];
    _chooseView.backgroundColor=[UIColor grayColor];
    _chooseView.layer.cornerRadius=10;
    _chooseView.clipsToBounds=YES;
    [self addSubview:_chooseView];
    
    [_chooseView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset((self.frame.size.width-200)/2);
        make.height.mas_equalTo(200);
        make.width.mas_equalTo(200);
        make.left.equalTo(self).with.offset((self.frame.size.height-200)/2);
    }];
    
    UIButton *chongboBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [chongboBtn setImage:[UIImage imageNamed:@"refreshicon_pull"] forState:UIControlStateNormal];
    [chongboBtn addTarget:self action:@selector(chongboAction) forControlEvents:UIControlEventTouchUpInside];
    [_chooseView addSubview:chongboBtn];
    
    [chongboBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chooseView).with.offset(25);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.equalTo(_chooseView).with.offset(25);
    }];
    
    UILabel *chongbolabel =[[UILabel alloc] init];
    chongbolabel.text=@"重播";
    chongbolabel.textColor=[UIColor whiteColor];
    chongbolabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:chongbolabel];
    [chongbolabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_chooseView).with.offset(-25);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        make.left.equalTo(_chooseView).with.offset(25);
    }];
    
    UIButton *fenxiangBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [fenxiangBtn setImage:[UIImage imageNamed:@"product_share"] forState:UIControlStateNormal];
    [fenxiangBtn addTarget:self action:@selector(fenxiangAction) forControlEvents:UIControlEventTouchUpInside];
    [_chooseView addSubview:fenxiangBtn];
    
    [fenxiangBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chooseView).with.offset(25);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.right.equalTo(_chooseView).with.offset(-25);
    }];
    
    UILabel *fenxianglabel =[[UILabel alloc] init];
    fenxianglabel.text=@"分享";
    fenxianglabel.textColor=[UIColor whiteColor];
    fenxianglabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:fenxianglabel];
    [fenxianglabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_chooseView).with.offset(-25);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        make.right.equalTo(_chooseView).with.offset(-25);
    }];
    
    UIButton *closeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [_chooseView addSubview:closeBtn];
    
    [closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chooseView).with.offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.right.equalTo(_chooseView).with.offset(-5);
    }];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    singleTap.numberOfTapsRequired = 1; // 单击
    [self addGestureRecognizer:singleTap];
}

-(void)handleSingleTap{

}
-(void)closeAction{
    [self.delegate closedAction];
}
-(void)chongboAction{
    [self.delegate repalyAction];
}

-(void)fenxiangAction{
    [self.delegate shareAction];
}
@end
