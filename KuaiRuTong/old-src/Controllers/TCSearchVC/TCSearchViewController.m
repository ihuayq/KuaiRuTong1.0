//
//  TCSearchViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/11.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "TCSearchViewController.h"

#import "DeviceManager.h"

@interface TCSearchViewController ()

@end

@implementation TCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicView];
    // Do any additional setup after loading the view.
}



/**
 *  加载基础视图
 *  @return void
 */
- (void)loadBasicView{
    self.view.backgroundColor = [UIColor whiteColor];
    //标题栏
    CustomNavBar *customNavBar = [[CustomNavBar alloc] initWithFrame:CGRectMake(0, 0, 320 * WIDTH_SCALE, 60 * HEIGHT_SCALE + 20)];
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"提成查询";
    customNavBar.Delegate = self;
    [self.view addSubview:customNavBar];
    
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(60 ,200, 200, 100)];
    infoView.backgroundColor = [UIColor clearColor];
    infoView.layer.masksToBounds = YES;
    infoView.layer.borderWidth = 1.0;
    [self.view addSubview:infoView];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.font = [UIFont systemFontOfSize:20.0];
    infoLabel.text = @"敬请期待...";
    [infoView addSubview:infoLabel];
    
    
    
}

#pragma mark -- CustomNavBarDelegate 代理方法
- (void)dealWithBackButtonClickedMethod{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
