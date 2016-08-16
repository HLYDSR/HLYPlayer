//
//  FinishView.h
//  HLYPlayer
//
//  Created by DengShiru on 16/8/15.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FinishViewDelegate <NSObject>
-(void)repalyAction;
-(void)shareAction;
-(void)closedAction;
@end

@interface FinishView : UIView
@property (nonatomic,strong) UIView *chooseView ;
@property (nonatomic,strong)id<FinishViewDelegate>delegate;
@end
