//
//  ZBJRKViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "ZBJRKViewController.h"
#import "DeviceManager.h"
@interface ZBJRKViewController (){
    ScanView *scanView;
    ZBJRKView *rukuView;
  
}

@end

@implementation ZBJRKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicView];
}
- (void)loadBasicView{
   
    //标题栏 //nav
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"自备机入库";
    customNavBar.Delegate = self;

    //背景
    UIView *backView = [ViewModel createViewWithFrame:CGRectMake(0, 0, 320, 50)];
    backView.backgroundColor = RED_COLOR1;
    [scrollView addSubview:backView];
    //扫一扫按钮
    UIButton *scanButton = [ViewModel createButtonWithFrame:CGRectMake(80, 5, 160, 40) ImageNormalName:nil ImageSelectName:nil Title:@"扫一扫" Target:self Action:@selector(scanButtonClicked)];
    scanButton.backgroundColor = [UIColor orangeColor];
   [backView addSubview:scanButton];
    
    [self createBangDingView:@""];
}
- (void)scanButtonClicked{
    
    [self createScanView];
    
}
- (void)createBangDingView:(NSString *)scanInfo{
    NSLog(@"%@",scanInfo);
    [scanView removeFromSuperview];
    scanView = nil;
    [rukuView removeFromSuperview];
    rukuView = nil;
    rukuView = [[ZBJRKView alloc] initWithFrame:CGRectMake(0 * WIDTH_SCALE, 50 * HEIGHT_SCALE, 320 * WIDTH_SCALE, HEIGHT - 130 * HEIGHT_SCALE)];
    [rukuView passScanInfoForZBJRK:scanInfo];
    rukuView.Delegate =self;
    [scrollView addSubview:rukuView];
    
}
- (void)createScanView{
    [rukuView removeFromSuperview];
    rukuView = nil;
    [scanView removeFromSuperview];
    scanView = nil;
    scanView = [[ScanView alloc] initWithFrame:CGRectMake(0 * WIDTH_SCALE, 50 * HEIGHT_SCALE, 320 * WIDTH_SCALE, HEIGHT - 130 * HEIGHT_SCALE)];
    scanView.Delegate = self;
    [scrollView addSubview:scanView];
    
}
- (void)pushOtherViewAndPassInfo:(NSString *)info{
    
    [self createBangDingView:info];
    
}


- (void)rukuButtonClikcedMethod:(UITextField *)jsTextField AndcsmcTextField:(UITextField *)csmcTextField AndjjlxTextField:(UITextField *)jjlxTextField AndjjxhTextField:(UITextField *)jjxhTextField AndjjslTextField:(UITextField *)jjslTextField{
//    HUD_ZBJRKVC.labelText = @"入库成功";
//    HUD_ZBJRKVC.mode = MBProgressHUDModeText;
//    [HUD_ZBJRKVC show:YES];
//    [HUD_ZBJRKVC hide:YES afterDelay:2];
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
