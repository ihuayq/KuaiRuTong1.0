//
//  WorkManagerViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/9.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "WorkManagerViewController.h"
#import "SHAndWorkViewController.h"
#import "SHAndWork1ViewController.h"
#import "KuCunViewController.h"
#import "QuestionSHViewController.h"
#import "ZBJRKViewController.h"
//#import "TCSearchViewController.h"
//#import "SHManagerViewController.h"
//#import "ZDManagerViewController.h"
@interface WorkManagerViewController ()
@end

@implementation WorkManagerViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    customNavBar.backView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicView];
}
/**
 *  加载基础视图
 *  @return void
 */
- (void)loadBasicView{
    self.view.backgroundColor = GRAY_COLOR;
    scrollView.frame = CGRectMake(0, 20 + 60 * HEIGHT_SCALE, 320 * WIDTH_SCALE, HEIGHT - 60 * HEIGHT_SCALE - 20 - 49);
   
    NSArray *managerArray= @[@"商户查询",@"工作状态查询",@"已保存流程",@"待处理流程",@"问题流程",@"库存查询",@"自备机入库"];
    NSArray *managerIconsArray  = @[@"shcx_icon",@"gzztcx_icon",@"ybclc_icon",@"dcllc_icon",@"wtlc_icon",@"kccx_icon",@"zbjrk_icon"];
    
   
    for (int i = 0; i < managerArray.count; i ++) {
        UIView *managerView = [ViewModel createViewWithFrame:CGRectMake(107 * (i % 3), 20 + 116 * (i / 3), 107, 116)];
        managerView.backgroundColor = [UIColor whiteColor];
        managerView.layer.borderWidth = 0.5;
        [scrollView addSubview:managerView];
        
        //icon
        UIImageView *managerIcon = [ViewModel createImageViewWithFrame:CGRectMake(40, 18, 36, 36) ImageName:managerIconsArray[i]];
        [managerView addSubview:managerIcon];
        
        //文本
        UILabel *managerLabel = [ViewModel createLabelWithFrame:CGRectMake(0, 60, 106, 35) Font:[UIFont boldSystemFontOfSize:10.0] Text:managerArray[i]];
        managerLabel.textAlignment = NSTextAlignmentCenter;
        [managerView addSubview:managerLabel];
        
        //按钮添加
        UIButton *managerButton = [ViewModel createButtonWithFrame:CGRectMake(107 * (i % 3), 20 + 116 * (i / 3), 107, 116)ImageNormalName:nil ImageSelectName:nil Title:nil Target:self Action:@selector(managerButtonClicked:)];
        managerButton.tag = 200 + i;
        [scrollView addSubview:managerButton];
    }
    
    [scrollView setContentSize:CGSizeMake(0, 150 + (managerArray.count / 3) * 116 )];
    
}

#pragma mark -- Private Methods
/**
 * 功能按钮点击事件方法
 * @return void
 */
- (void)managerButtonClicked:(UIButton *)btn{
    switch (btn.tag) {
        case 200:
            [self searchSHMethod];
            break;
        case 201:
            [self searchWorkStateMethod];
            break;
        case 202:
            [self savedProcessMethod];
            break;
        case 203:
            [self dealWithProcessMethod];
            break;
        case 204:
            [self questionProcessMethod];
            break;
        case 205:
            [self searchStockMethod];
            break;
        case 206:
            [self enterIntoStockMethod];
            break;
            
        default:
            break;
    }
}

/**
 *  功能按钮点击事件方法 - 商户查询200
 *
 *  @return void
 */
- (void)searchSHMethod{
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    SHAndWorkViewController *childController = [board instantiateViewControllerWithIdentifier: @"SHAndWorkVC"];
    [self.navigationController pushViewController:childController animated:YES];

}
/**
 *  功能按钮点击事件方法 - 工作状态查询201
 *
 *  @return void
 */
- (void)searchWorkStateMethod{
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    SHAndWork1ViewController *childController = [board instantiateViewControllerWithIdentifier: @"SHAndWork1VC"];
    [self.navigationController pushViewController:childController animated:YES];

}
/**
 *  功能按钮点击事件方法 - 已保存流程202
 *
 *  @return void
 */
- (void)savedProcessMethod{
    
}
/**
 *  功能按钮点击事件方法 - 待处理流程203
 *
 *  @return void
 */
- (void)dealWithProcessMethod{
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    QuestionSHViewController *childController = [board instantiateViewControllerWithIdentifier: @"QuestionSHVC"];
    [self.navigationController pushViewController:childController animated:YES];

}
/**
 *  功能按钮点击事件方法 - 问题流程204
 *
 *  @return void
 */
- (void)questionProcessMethod{
    
}
/**
 *  功能按钮点击事件方法 - 库存查询205
 *
 *  @return void
 */
- (void)searchStockMethod{
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    KuCunViewController *childController = [board instantiateViewControllerWithIdentifier: @"KuCunVC"];
    [self.navigationController pushViewController:childController animated:YES];
}
/**
 *  功能按钮点击事件方法 - 自备机入库206
 *
 *  @return void
 */
- (void)enterIntoStockMethod{
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    ZBJRKViewController *childController = [board instantiateViewControllerWithIdentifier: @"ZBJRKVC"];
    [self.navigationController pushViewController:childController animated:YES];
  
}


///**
// * 功能按钮点击事件方法 - 商户管理
// * @return void
// */
//- (void)SHManagerMethod{
//    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
//    SHManagerViewController *childController = [board instantiateViewControllerWithIdentifier: @"SHManagerVC"];
//    [self.navigationController pushViewController:childController animated:YES];
//}
///**
// * 功能按钮点击事件方法 - 终端管理
// * @return void
// */
//- (void)ZDManagerMethod{
//    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
//    ZDManagerViewController *childController = [board instantiateViewControllerWithIdentifier: @"ZDManagerVC"];
//    [self.navigationController pushViewController:childController animated:YES];
//}
///**
// * 功能按钮点击事件方法 - 提成查询
// * @return void
// */
//- (void)TCSearchMethod{
//    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
//    TCSearchViewController *childController = [board instantiateViewControllerWithIdentifier: @"TCSerachVC"];
//    [self.navigationController pushViewController:childController animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
