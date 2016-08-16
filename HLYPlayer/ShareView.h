//
//  ShareView.h
//  HLYPlayer
//
//  Created by DengShiru on 16/8/15.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareViewDelegate <NSObject>
-(void)closeAction;
-(void)weixinAction;
-(void)frinedAction;
-(void)qqAction;
-(void)weiboAction;
@end

@interface ShareView : UIView

@property (nonatomic,strong)id<ShareViewDelegate>delegate;
@end
