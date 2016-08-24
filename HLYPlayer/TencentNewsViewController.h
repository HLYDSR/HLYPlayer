//
//  TencentNewsViewController.h
//  TencentNews
//
//  Created by DengShiru on 16/2/12.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TencentNewsViewController : UIViewController
//tableview  
@property (strong, nonatomic) IBOutlet UITableView *tableViewtui;
@property (strong, nonatomic)  NSMutableArray *dataSource;//数据源
@end
