//
//  SuperViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/26.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "SuperViewController.h"


@interface SuperViewController ()

@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSuperView];
    
}

/**
 *  加载父类的基础视图
 */
- (void)loadSuperView{
   
//    //CustomNavBar
//    customNavBar = [[CustomNavBar alloc] initWithFrame:CGRectMake(0, 0, 320 * WIDTH_SCALE, 60 * HEIGHT_SCALE + 20)];
//    customNavBar.backView.hidden = NO;
//    customNavBar.titleLabel.text = @"快入通";
//    customNavBar.Delegate = self;
//    [self.view addSubview:customNavBar];
//    //scrollView
//    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20 + 60 * HEIGHT_SCALE, 320 * WIDTH_SCALE, HEIGHT - 60 * HEIGHT_SCALE - 20)];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight)];
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
//    //添加HUD
//    hud_SuperVC = [[MBProgressHUD alloc] initWithView:self.view];
//    hud_SuperVC.mode = MBProgressHUDModeText;
//    hud_SuperVC.mode = MBProgressHUDModeIndeterminate;
//    hud_SuperVC.delegate = self;
//    [self.view addSubview:hud_SuperVC];
}


#pragma mark -- MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud{
    
}
#pragma mark -- CustomNavBarDelegate
- (void)dealWithBackButtonClickedMethod{
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
