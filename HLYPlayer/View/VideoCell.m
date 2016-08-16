//
//  VideoCell.m
//  TencentNews
//
//  Created by DengShiru on 16/2/12.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "VideoCell.h"
#import "VideoModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+ML.h"
#define SCREEN_FRAME [UIScreen mainScreen].bounds
@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.headPic.layer.cornerRadius=19;
    self.headPic.clipsToBounds=YES;
    self.videosource.layer.borderColor=[UIColor orangeColor].CGColor;
    self.videosource.layer.borderWidth=0.3;
    self.videosource.textColor=[UIColor orangeColor];
    self.videosource.layer.cornerRadius=7.25;
    self.times.layer.cornerRadius=10.5;
    self.times.clipsToBounds=YES;
    self.timess.layer.cornerRadius=10.5;
    self.timess.clipsToBounds=YES;
//    self.model=
}

-(void)setModel:(VideoModel *)model{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.name.text=model.name;
    self.time.text=model.creattime;
    NSString *contents=[NSString stringWithFormat:@"%@次播放",model.times];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:contents];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithRed:0.714 green:0.518 blue:0.165 alpha:1.000]
                          range:NSMakeRange(0,model.times.length)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithRed:0.922 green:0.984 blue:1.000 alpha:1.000]
                          range:NSMakeRange(model.times.length,3)];
    self.times.attributedText=AttributedStr;
    
    self.content.text=model.content;
    self.contenHeight.constant=[NSString sizeHeightWithString:model.content font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_FRAME.size.width-32, MAXFLOAT)].height+4;
    
    self.videosource.text=model.videosource;
    self.type.text=model.type;
    [self.backgroundIV sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"logo"]];
    [self.headPic sd_setImageWithURL:[NSURL URLWithString:model.headPic] placeholderImage:[UIImage imageNamed:@"logo"]];
}


- (IBAction)likeAction:(id)sender {
    [self.delegate likeAction:self.likeImage];
}

- (IBAction)brakesAction:(id)sender {
    [self.delegate brakesAction];
}

- (IBAction)contentAction:(id)sender {
    [self.delegate contentAction];
}

- (IBAction)sahreAction:(id)sender {
    [self.delegate sahreAction];
}
- (IBAction)moreAction:(id)sender {
}

- (IBAction)reload:(id)sender {
    [self.delegate reloadAction];
    [self.blackView.superview sendSubviewToBack:self.blackView];
}

- (IBAction)shareAction:(id)sender {
    [self.delegate sharedAction];
//    [self.blackView.superview sendSubviewToBack:self.blackView];
}
@end
