//
//  WSContainerController.h
//  WSContainViewController
//
//  Created by DengShiru on 16/1/6.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomScrollMenu.h"

@interface WSContainerController : UIViewController

@property (strong, nonatomic) UIViewController *parentController;

@property (strong, nonatomic) UIColor *navigationBarBackgrourdColor;
@property (strong, nonatomic) NSArray * menusArray;
@property (strong, nonatomic) CustomScrollMenu *scrollMenu;
+ (instancetype) containerControllerWithSubControlers:(NSArray<UIViewController *> *)viewControllers parentController:(UIViewController *)vc;


@end
