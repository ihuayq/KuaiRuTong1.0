//
//  CustomTabBarViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/9.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "WorkManagerViewController.h"
#import "NewBusinessViewController.h"
#import "UserCenterViewController.h"
#import "FileManager.h"

@interface CustomTabBarViewController ()

@end

@implementation CustomTabBarViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBar.hidden = NO;
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

    self.view.backgroundColor = [UIColor clearColor];
    self.viewControllers = @[[self workManagerViewController],[self newBusinessViewController],[self userCenterViewController]];
    self.delegate = self;
    self.tabBar.tintColor = [UIColor redColor];
  
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![[userDefaults objectForKey:@"isSaveNewBussinss"] isEqualToString:@"yes"]) {
        if (![viewController isKindOfClass:[NewBusinessViewController class]]) {
            FileManager *fileManager = [[FileManager alloc] init];
            NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"SHPhotosTemp"];
            [fileManager removeFile:path];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults removeObjectForKey:@"photosTempArray"];
            [userDefaults synchronize];
        }
    }
    
    
}

/**
 *  工作管理界面
 *  @return  UIViewController
 */
- (UIViewController *)workManagerViewController{
    
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WorkManagerVC"];
    viewController.tabBarItem.title =@"工作管理";
    viewController.tabBarItem.image = [UIImage imageNamed:@"newBusiness-icon-normal"];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:@"newBusiness-icon-select"];
    return viewController;
}
/**
 *  新商户界面
 *  @return  UIViewController
 */
- (UIViewController *)newBusinessViewController{
    NewBusinessViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NewBusinessVC"];
    viewController.pendingType = @"no";
    viewController.tabBarItem.title =@"新建商户";
    viewController.tabBarItem.image = [UIImage imageNamed:@"workManager-icon-normal"];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:@"workManager-icon-select"];
   
    return viewController;
}
/**
 *  个人中心界面
 *  @return  UIViewController
 */
- (UIViewController *)userCenterViewController{
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UserCenterVC"];
    viewController.tabBarItem.title =@"个人中心";
    viewController.tabBarItem.image = [UIImage imageNamed:@"userCenter-icon-normal"];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:@"userCenter-icon-select"];
    return viewController;
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
