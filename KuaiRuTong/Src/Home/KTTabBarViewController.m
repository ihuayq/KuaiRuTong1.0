//
//  KTTabBarViewController.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/13.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "KTTabBarViewController.h"
#import "WorkflowMgrViewController.h"
#import "UserCenterViewController.h"
#import "NewBusinessViewController.h"
#import "NavigationWithInteract.h"

@interface KTTabBarViewController (){

    WorkflowMgrViewController *workflowViewVC;
    UserCenterViewController  *userCenterVC;
    NewBusinessViewController *newBussinessVC;
}
@end


@implementation KTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}


-(void)initUI{
    workflowViewVC = [[WorkflowMgrViewController alloc] init];
    userCenterVC = [[UserCenterViewController alloc] init];
    newBussinessVC = [[NewBusinessViewController alloc] init];
    
    NavigationWithInteract * nc1 = [[NavigationWithInteract alloc] initWithRootViewController:workflowViewVC];
    NavigationWithInteract * nc2 = [[NavigationWithInteract alloc] initWithRootViewController:newBussinessVC];
    NavigationWithInteract * nc3 = [[NavigationWithInteract alloc] initWithRootViewController:userCenterVC];
    
    
    self.viewControllers = [NSArray arrayWithObjects:nc1,nc2,nc3,nil];
    
    nc1.tabBarItem.title = @"工作管理";
    nc2.tabBarItem.title = @"添加商户";
    nc3.tabBarItem.title = @"用户中心";

    nc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"首页"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nc2.tabBarItem.selectedImage = [[UIImage imageNamed:@"投资"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nc3.tabBarItem.selectedImage = [[UIImage imageNamed:@"账号"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    nc1.tabBarItem.image = [UIImage imageNamed:@"首页-normal"];
    nc2.tabBarItem.image = [UIImage imageNamed:@"投资-normal"];
    nc3.tabBarItem.image = [UIImage imageNamed:@"账号-normal"];
    
    //self.selectedViewController = nc4;
}

-(void)setIndexPage:(int)indexPage{
    _indexPage = indexPage;
    self.selectedIndex = _indexPage;
}


@end
