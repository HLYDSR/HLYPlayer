//
//  WSContainerController.m
//  WSContainViewController
//
//  Created by DengShiru on 16/1/6.
//  Copyright © 2016年 hlyclub. All rights reserved.
//

#import "WSContainerController.h"
//#import "WSNavigationView.h"

#import "UIColor+Hex.h"
#define STATUS_BAR_HEIGHT               20
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_FRAME [UIScreen mainScreen].bounds
@interface WSContainerController ()<UICollectionViewDataSource, UICollectionViewDelegate,CustomScrollerMenuDelegate>
{
    NSInteger curIndex;
}
@property (strong, nonatomic) NSArray *viewControllers;

@property (assign, nonatomic) NSInteger selectedIndex;

@property (weak, nonatomic) UICollectionView *collectionView;

@property (weak, nonatomic) UICollectionViewFlowLayout *flowLayout;



@end

static NSString *CellID = @"ControllerCell";

@implementation WSContainerController


#pragma mark - collectionView datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *view = [self.viewControllers[indexPath.item] view];
    [cell.contentView addSubview:view];
    cell.backgroundColor=[UIColor blackColor];
    view.frame = cell.bounds;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64-40);
}
#pragma mark - collectionView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    if(index<[_menusArray count]-1){
        index++;
    }
    if(index>=1){
        index--;
    }
    
    [_scrollMenu setCurrentIndex:index];
}


- (void)itemDidSelectedWithIndex:(NSInteger)index{
    _selectedIndex = index;
    CGFloat offsetX = self.view.bounds.size.width * index;
    self.collectionView.contentOffset = CGPointMake(offsetX, self.collectionView.contentOffset.y);
}


#pragma mark - view

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //禁用滚动到最顶部的属性
    self.collectionView.scrollsToTop = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    CGFloat width = SCREEN_FRAME.size.width;
    CGFloat height = SCREEN_FRAME.size.height;
    CGFloat topNav = 64;
//    if (self.navigationController && self.tabBarController) {
//        
//        self.scrollMenu.frame = CGRectMake(0, 0, width, 45);
        self.scrollMenu.frame = CGRectMake(0, 64, width, 30);
        self.collectionView.frame = CGRectMake(0, 42, width, height - self.scrollMenu.frame.size.height-10);
//    }else{
    
    NSLog(@"%f,%f,%f,%f",self.collectionView.frame.origin.x,self.collectionView.frame.origin.y,self.collectionView.frame.size.width,self.collectionView.frame.size.height);
//        self.collectionView.frame = CGRectMake(0, 34, width, height+10);
//    }
    self.flowLayout.itemSize = self.collectionView.bounds.size;
}

#pragma mark - init

- (void)setParentController:(UIViewController *)parentController{
    _parentController = parentController;
    [parentController addChildViewController:self];
    [parentController.view addSubview:self.view];
}

+ (instancetype)containerControllerWithSubControlers:(NSArray<UIViewController *> *)viewControllers parentController:(UIViewController *)vc{
    id container = [[self alloc] init];
    [container setViewControllers:viewControllers];
    [container setParentController:vc];
    __block NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:viewControllers.count];
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [container addChildViewController:obj];
        [arrM addObject:obj.title ? : @""];
    }];
    
//    _menusArray=arrM.copy;
//    _scrollMenu.myTitleArray=arrM.copy;
//    [vc.view addSubview:_scrollMenu];
//    _scrollMenu.currentIndex=0;
//}
    [container scrollMenu].myTitleArray = arrM.copy;
   
//    [container navigationView].selectedItemIndex = 0;
    
    return container;
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout = flowLayout;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        //设置collectionView的属性
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:SCREEN_FRAME collectionViewLayout:flowLayout];
        collectionView.pagingEnabled = YES;
        _collectionView = collectionView;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellID];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:collectionView];
        
//         if(!_scrollMenu){
         _scrollMenu=[[CustomScrollMenu alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 45) showArrayButton:NO];
        _scrollMenu.delegate=self;
        _scrollMenu.LineColor=[UIColor colorWithRed:0.992 green:0.416 blue:0.322 alpha:1.000];
        _scrollMenu.selectedColor=[UIColor colorWithHexString:@"#303030"];
        _scrollMenu.titleFont=[UIFont systemFontOfSize:15];
        _scrollMenu.noSlectedColor=[UIColor colorWithHexString:@"#8c8c8c"];
        _scrollMenu.backgroundColor=[UIColor colorWithHexString:@"#ffffff"];
        [self.view addSubview:_scrollMenu];
//         }
       
//        //添加导航view
//        typeof(self) __weak weakObj= self;
//        WSNavigationView *view = [WSNavigationView navigationViewWithItems:nil itemClick:^(NSInteger selectedIndex) {
//
//            [weakObj setSelectedIndex:selectedIndex];
//        }];
//        view.backgroundColor = [UIColor greenColor];
//        
//        [self.view addSubview:view];
//        
//        [self setNavigationView:view];
        
    }
    return self;
}

@end
