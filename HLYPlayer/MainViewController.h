//
//  ViewController.h
//  HLYPlayer
//
//  Created by DengShiru on 16/8/12.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomScrollMenu.h"

@interface MainViewController : UIViewController
@property (strong, nonatomic) CustomScrollMenu  *scrollMenu;
@property (strong, nonatomic) NSArray * menusArray;
@end

