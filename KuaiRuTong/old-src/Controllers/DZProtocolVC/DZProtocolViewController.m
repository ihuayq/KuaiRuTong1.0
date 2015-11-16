//
//  DZProtocolViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/19.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "DZProtocolViewController.h"
#import "DeviceManager.h"
@interface DZProtocolViewController ()

@end

@implementation DZProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicView];
}
- (void)loadBasicView{
    //标题栏
    CustomNavBar *customNavBar = [[CustomNavBar alloc] initWithFrame:CGRectMake(0, 0, 320 * WIDTH_SCALE, 60 * HEIGHT_SCALE + 20)];
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"快入通电子协议";
    customNavBar.Delegate = self;
    [self.view addSubview:customNavBar];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20 + 60 * HEIGHT_SCALE, 320 * WIDTH_SCALE, HEIGHT - 60 * HEIGHT_SCALE - 20)];
    webView.layer.borderWidth = 1.0f;
    [self.view addSubview:webView];
    

}


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
