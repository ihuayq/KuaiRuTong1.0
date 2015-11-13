////
////  WorkManagerViewController.m
////  KuaiRuTong
////
////  Created by HKRT on 15/6/9.
////  Copyright (c) 2015年 HKRT. All rights reserved.
////
//
#import "WorkflowMgrViewController.h"
//#import "SHAndWorkViewController.h"
//#import "SHAndWork1ViewController.h"
//#import "KuCunViewController.h"
//#import "QuestionSHViewController.h"
//#import "ZBJRKViewController.h"

typedef NS_ENUM(NSUInteger,WorkMgr_ENUM) {
    USER_QUERY = 0,
    WOKR_STATAS  = 1,
    FLOW_SAVED  = 2,
    WAIT_FLOW = 3,
    ERROR_FLOW = 4,
    STOCK_QUERY = 5,
    SELFMACHINE_REC = 6
};

static NSArray *managerTitleArray = nil;
NSArray *getManagerTitleArray() {
    if ( ! managerTitleArray) {
        managerTitleArray = [[NSArray alloc] initWithObjects:@"商户查询",@"工作状态查询",@"已保存流程",@"待处理流程",@"问题流程",@"库存查询",@"自备机入库", nil];
    }
    return managerTitleArray;
}

static NSArray *managerIconsArray = nil;
NSArray *getManagerIconsArray() {
    if ( ! managerIconsArray) {
        managerIconsArray = [[NSArray alloc] initWithObjects:@"shcx_icon",@"gzztcx_icon",@"ybclc_icon",@"dcllc_icon",@"wtlc_icon",@"kccx_icon",@"zbjrk_icon", nil];
    }
    return managerIconsArray;
}

@interface TipCollectionViewCell(){
    UIImageView *imgView;
    UILabel *title;
    UIButton *btn;
}
@end

@implementation TipCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor purpleColor];//背景为紫色
        imgView  = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, self.size.width - 2*5, self.size.height - 3*10)];
        [self addSubview:imgView];
        
        title  = [[UILabel alloc] initWithFrame:CGRectMake(5,imgView.frame.origin.y + imgView.frame.size.height + 5,self.frame.size.width-2*5, 32)];
        title.font = [UIFont systemFontOfSize:16.0f];
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
    }
    return self;
}

-(void)setIndex:(int)index{
    
    _index = index;
    NSArray *managerTitleArray= @[@"商户查询",@"工作状态查询",@"已保存流程",@"待处理流程",@"问题流程",@"库存查询",@"自备机入库"];
    NSArray *managerIconsArray  = @[@"shcx_icon",@"gzztcx_icon",@"ybclc_icon",@"dcllc_icon",@"wtlc_icon",@"kccx_icon",@"zbjrk_icon"];
    
    UIImage *icon = [UIImage imageNamed:managerIconsArray[_index]];
    imgView.image = icon;
    imgView.frame =  CGRectMake(self.size.width/2 - icon.size.width/2, self.size.height/2 - icon.size.height/2, icon.size.width,icon.size.height);

    title.frame = CGRectMake(5,imgView.frame.origin.y + imgView.frame.size.height + 5,self.frame.size.width-2*5, 32);
    title.text = managerTitleArray[_index];
    
}

@end



@interface WorkflowMgrViewController(){
}
@end

@implementation WorkflowMgrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigation.title = @"工作管理";

    
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[TipCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    [self.view addSubview:self.collectionView];
}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    TipCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[TipCollectionViewCell alloc] init];
    }
    
    cell.layer.borderColor=[UIColor darkGrayColor].CGColor;
    if (indexPath.row == 6) {
        cell.layer.borderWidth=0.6;
    }
    else{
        cell.layer.borderWidth=0.3;
    }
    
    DLog(@"row=======%ld",indexPath.row);
    cell.index = indexPath.row;
    
    return cell;
}

#pragma mark --UICollectionViewDelegate


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
    //cell.backgroundColor = [UIColor greenColor];
//    NSLog(@"item======%ld",(long)indexPath.item);
//    NSLog(@"row=======%ld",indexPath.row);
//    NSLog(@"section===%ld",indexPath.section);
    
    switch (indexPath.row) {
        case USER_QUERY:
            
            break;
            
        default:
            break;
    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((MainWidth)/3, (MainWidth)/3);
}
//定义每个UICollectionView 的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);//上下左右
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}



@end
///**
// *  加载基础视图
// *  @return void
// */
//- (void)loadBasicView{
////    self.view.backgroundColor = GRAY_COLOR;
////    //scrollView.frame = CGRectMake(0, 20 + 60 * HEIGHT_SCALE, 320 * WIDTH_SCALE, HEIGHT - 60 * HEIGHT_SCALE - 20 - 49);
////   
////    NSArray *managerArray= @[@"商户查询",@"工作状态查询",@"已保存流程",@"待处理流程",@"问题流程",@"库存查询",@"自备机入库"];
////    NSArray *managerIconsArray  = @[@"shcx_icon",@"gzztcx_icon",@"ybclc_icon",@"dcllc_icon",@"wtlc_icon",@"kccx_icon",@"zbjrk_icon"];
////    
////   
////    for (int i = 0; i < managerArray.count; i ++) {
////        UIView *managerView = [ViewModel createViewWithFrame:CGRectMake(107 * (i % 3), 20 + 116 * (i / 3), 107, 116)];
////        managerView.backgroundColor = [UIColor whiteColor];
////        managerView.layer.borderWidth = 0.5;
////        //[scrollView addSubview:managerView];
////        
////        //icon
////        UIImageView *managerIcon = [ViewModel createImageViewWithFrame:CGRectMake(40, 18, 36, 36) ImageName:managerIconsArray[i]];
////        [managerView addSubview:managerIcon];
////        
////        //文本
////        UILabel *managerLabel = [ViewModel createLabelWithFrame:CGRectMake(0, 60, 106, 35) Font:[UIFont boldSystemFontOfSize:10.0] Text:managerArray[i]];
////        managerLabel.textAlignment = NSTextAlignmentCenter;
////        [managerView addSubview:managerLabel];
////        
////        //按钮添加
////        UIButton *managerButton = [ViewModel createButtonWithFrame:CGRectMake(107 * (i % 3), 20 + 116 * (i / 3), 107, 116)ImageNormalName:nil ImageSelectName:nil Title:nil Target:self Action:@selector(managerButtonClicked:)];
////        managerButton.tag = 200 + i;
////        [scrollView addSubview:managerButton];
////    }
////    
////    [scrollView setContentSize:CGSizeMake(0, 150 + (managerArray.count / 3) * 116 )];
//    
//}
//
//#pragma mark -- Private Methods
///**
// * 功能按钮点击事件方法
// * @return void
// */
//- (void)managerButtonClicked:(UIButton *)btn{
//    switch (btn.tag) {
////        case 200:
////            [self searchSHMethod];
////            break;
////        case 201:
////            [self searchWorkStateMethod];
////            break;
////        case 202:
////            [self savedProcessMethod];
////            break;
////        case 203:
////            [self dealWithProcessMethod];
////            break;
////        case 204:
////            [self questionProcessMethod];
////            break;
////        case 205:
////            [self searchStockMethod];
////            break;
////        case 206:
////            [self enterIntoStockMethod];
////            break;
//            
//        default:
//            break;
//    }
//}
//
///**
// *  功能按钮点击事件方法 - 商户查询200
// *
// *  @return void
// */
//- (void)searchSHMethod{
//    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
//    SHAndWorkViewController *childController = [board instantiateViewControllerWithIdentifier: @"SHAndWorkVC"];
//    [self.navigationController pushViewController:childController animated:YES];
//
//}
///**
// *  功能按钮点击事件方法 - 工作状态查询201
// *
// *  @return void
// */
//- (void)searchWorkStateMethod{
//    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
//    SHAndWork1ViewController *childController = [board instantiateViewControllerWithIdentifier: @"SHAndWork1VC"];
//    [self.navigationController pushViewController:childController animated:YES];
//
//}
///**
// *  功能按钮点击事件方法 - 已保存流程202
// *
// *  @return void
// */
//- (void)savedProcessMethod{
//    
//}
///**
// *  功能按钮点击事件方法 - 待处理流程203
// *
// *  @return void
// */
//- (void)dealWithProcessMethod{
//    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
//    QuestionSHViewController *childController = [board instantiateViewControllerWithIdentifier: @"QuestionSHVC"];
//    [self.navigationController pushViewController:childController animated:YES];
//
//}
///**
// *  功能按钮点击事件方法 - 问题流程204
// *
// *  @return void
// */
//- (void)questionProcessMethod{
//    
//}
///**
// *  功能按钮点击事件方法 - 库存查询205
// *
// *  @return void
// */
//- (void)searchStockMethod{
//    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
//    KuCunViewController *childController = [board instantiateViewControllerWithIdentifier: @"KuCunVC"];
//    [self.navigationController pushViewController:childController animated:YES];
//}
///**
// *  功能按钮点击事件方法 - 自备机入库206
// *
// *  @return void
// */
//- (void)enterIntoStockMethod{
//    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
//    ZBJRKViewController *childController = [board instantiateViewControllerWithIdentifier: @"ZBJRKVC"];
//    [self.navigationController pushViewController:childController animated:YES];
//  
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//@end
