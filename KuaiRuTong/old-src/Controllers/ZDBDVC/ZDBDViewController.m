//
//  ZDBDViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "ZDBDViewController.h"
#import "DeviceManager.h"

@interface ZDBDViewController (){
    ScanView *scanView;
    ZDBDView *bangDingView;
    UIScrollView *scrollView;
    NSString *shbhString;
    NSString *wdmcString;
    NSString *xlhString;
    NSString *bddhString;
    MBProgressHUD *HUD_ZDBDVC;
}

@end

@implementation ZDBDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicView];
}

- (void)loadBasicView{
    //HUD
    HUD_ZDBDVC = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    HUD_ZDBDVC.delegate = self;
    [self.navigationController.view addSubview:HUD_ZDBDVC];
    //标题栏
    CustomNavBar *customNavBar = [[CustomNavBar alloc] initWithFrame:CGRectMake(0, 0, 320 * WIDTH_SCALE, 60 * HEIGHT_SCALE + 20)];
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"终端绑定";
    customNavBar.Delegate = self;
    [self.view addSubview:customNavBar];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20 + 60 * HEIGHT_SCALE, 320 * WIDTH_SCALE, HEIGHT - 60 * HEIGHT_SCALE)];
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    //扫一扫按钮
    UIButton *scanButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
    scanButton.backgroundColor = [UIColor lightGrayColor];
    scanButton.layer.borderWidth = 1;
    [scanButton setTitle:@"扫一扫" forState:UIControlStateNormal];
    [scanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scanButton addTarget:self action:@selector(scanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:scanButton];
    
    
    UIButton *bangdingButton = [[UIButton alloc] initWithFrame:CGRectMake(160 * WIDTH_SCALE, 0, 160 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
    bangdingButton.backgroundColor = [UIColor lightGrayColor];
    bangdingButton.layer.borderWidth = 1;
    [bangdingButton setTitle:@"绑 定" forState:UIControlStateNormal];
    [bangdingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bangdingButton addTarget:self action:@selector(bangdingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:bangdingButton];
    
    [self createScanView];
}

- (void)scanButtonClicked{
    
    [self createScanView];
    
}
- (void)createBangDingView{
    [scanView removeFromSuperview];
    scanView = nil;
    [bangDingView removeFromSuperview];
    bangDingView = nil;
    bangDingView = [[ZDBDView alloc] initWithFrame:CGRectMake(0 * WIDTH_SCALE, 30 * HEIGHT_SCALE, 320 * WIDTH_SCALE, HEIGHT - 110 * HEIGHT_SCALE)];
    bangDingView.Delegate =self;
    [scrollView addSubview:bangDingView];
    
}
- (void)createScanView{
    [bangDingView removeFromSuperview];
    bangDingView = nil;
    [scanView removeFromSuperview];
    scanView = nil;
    scanView = [[ScanView alloc] initWithFrame:CGRectMake(0 * WIDTH_SCALE, 30 * HEIGHT_SCALE, 320 * WIDTH_SCALE, HEIGHT - 110 * HEIGHT_SCALE)];
    scanView.Delegate = self;
    [scrollView addSubview:scanView];
    
}
- (void)pushOtherViewAndPassInfo:(NSString *)info{
    
    [self createBangDingView];
    
    
    NSLog(@"info == %@",info);
}

- (void)bangdingButtonClicked{
    
    
    
    [self createBangDingView];
}

- (void)bangDingButtonClikcedMethod:(UITextField *)shbhTextField AndwdmcTextField:(UITextField *)wdmcTextField AndxlhTextField:(UITextField *)xlhTextField AndbddhTextField:(UITextField *)bddhTextField{
    
    HUD_ZDBDVC.labelText = @"绑定成功";
    HUD_ZDBDVC.mode = MBProgressHUDModeText;
    [HUD_ZDBDVC show:YES];
    [HUD_ZDBDVC hide:YES afterDelay:2];
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
