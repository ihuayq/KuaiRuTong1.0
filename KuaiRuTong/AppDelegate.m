//
//  AppDelegate.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/10.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "KTTabBarViewController.h"
#import "SHInfoViewController.h"
#import "DAO.h"
#import "CateViewController.h"

@interface AppDelegate (){
    UINavigationController * nc;
    LoginViewController * login;
}


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginInitMainwidow:) name:@"LoginInitMainwidow" object:nil];
    
#ifdef DEBUGLOG
    [SNLogger startWithLogLevel:SNLogLevelDEBUG];
#else
    [SNLogger startWithLogLevel:SNLogLevelOFF];
#endif
    
    //初始化数据库
    /*建表*/
    [DAO createTablesNeeded];

    
//#define TEST
#ifndef TEST
    login = [[LoginViewController alloc] init];
    nc =[[UINavigationController alloc]initWithRootViewController:login];
    [nc.navigationBar setHidden:YES];
    self.window.rootViewController = nc;
    
#else
//    SHInfoViewController* Vc=[[SHInfoViewController alloc]init];
//    self.window.rootViewController = Vc;
    
    
    CateViewController* Vc=[[CateViewController alloc]init];
    self.window.rootViewController = Vc;
#endif
    

    
    // Override point for customization after application launch.
    return YES;
}


- (void)LoginInitMainwidow:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"login"]);
    NSLog(@"－－－－－接收到通知------");
    
    //0 主界面 logintype
    if([text.userInfo[@"login"] isEqualToString:@"0"])
    {
        KTTabBarViewController* Vc=[[KTTabBarViewController alloc] init];
        self.window.rootViewController = Vc;
    }
    else if ([text.userInfo[@"login"] isEqualToString:@"1"]){
        login = [[LoginViewController alloc] init];
        nc =[[UINavigationController alloc]initWithRootViewController:login];
        [nc.navigationBar setHidden:YES];
        self.window.rootViewController = nc;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
