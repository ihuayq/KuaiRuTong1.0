//
//  VersionDetailViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/9.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "VersionDetailViewController.h"
#import "CustomTabBarViewController.h"

@interface VersionDetailViewController ()

@end

@implementation VersionDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (id viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[UITabBarController class]]) {
            CustomTabBarViewController *tabBarViewController = (CustomTabBarViewController *)viewController;
            tabBarViewController.tabBar.hidden = YES;
        }
    }
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
    
    customNavBar.titleLabel.text = @"版本信息";
 
    //applogo
    UIImageView *logoImageView = [ViewModel createImageViewWithFrame:CGRectMake(100, 150, 120, 120) ImageName:@"KuaiRuTong_Icon"];
    [self.view addSubview:logoImageView];

    //版本信息
    NSString *versionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *versionStr = [NSString stringWithFormat:@"版 本 号 : V %@",versionString];
    UILabel *versionLabel = [ViewModel createLabelWithFrame:CGRectMake(0, 300, 320, 21) Font:nil Text:versionStr];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];
}



#pragma mark -- CustomNavBarDelegate
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
