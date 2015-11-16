//
//  SHAndWork1ViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/15.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "SHAndWork1ViewController.h"
#import "DeviceManager.h"
#import "MBProgressHUD.h"
#import "WorkSearchViewController.h"
#import "SearchWorkRequest.h"
@interface SHAndWork1ViewController (){
    UITextField *shbhTextField;
    UITextField *shxmTextField;

    UIButton *searchButton;
    NSDictionary *workInfoDic;
}

@end

@implementation SHAndWork1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicView];
}

/**
 *  加载基础视图
 *  @return void
 */
- (void)loadBasicView{
   
    //标题栏
    customNavBar.backView.hidden  = NO;
    customNavBar.titleLabel.text = @"工作查询";
    
    //商户编号 - label
    UILabel *shbhLabel = [ViewModel createLabelWithFrame:CGRectMake(10, 10, 91, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@"商户编号"];
    [scrollView addSubview:shbhLabel];
    
    //商户编号 - TextField
    shbhTextField = [ViewModel createTextFieldWithFrame:CGRectMake(102, 8, 205, 30) Placeholder:@"" Font:nil];
    shbhTextField.delegate = self;
    [scrollView addSubview:shbhTextField];
    //分割线1
    UIView *line1 = [ViewModel createViewWithFrame:CGRectMake(0, 40, 320, 1)];
    line1.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:line1];
    
    //商户姓名 - label
    UILabel *shmcLabel = [ViewModel createLabelWithFrame:CGRectMake(10, 45, 91, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@"商户名称"];
    [scrollView addSubview:shmcLabel];
    
    //商户姓名 - TextField
    shxmTextField = [ViewModel createTextFieldWithFrame:CGRectMake(102, 43, 205, 30) Placeholder:nil Font:nil];
    shxmTextField.delegate = self;
    [scrollView addSubview:shxmTextField];
    //分割线2
    UIView *line2 = [ViewModel createViewWithFrame:CGRectMake(0, 75, 320, 1)];
    line2.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:line2];
    

    
    
    //商户查询按钮
    searchButton = [ViewModel createButtonWithFrame:CGRectMake(0, 327, 320, 30) ImageNormalName:nil ImageSelectName:nil Title:@"查 询" Target:self Action:@selector(searchButtonClicked)];
    searchButton.backgroundColor =  RED_COLOR1;
    [searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:searchButton];
    
}

#pragma mark -- PrivateMethods 代理方法
- (void)searchButtonClicked{
    
    shxmTextField.text = @"bscsales";
    shbhTextField.text = @"M0058723";
    
    searchButton.backgroundColor = [UIColor lightGrayColor];
    searchButton.userInteractionEnabled = NO;
    hud_SuperVC.mode = MBProgressHUDModeIndeterminate;
    hud_SuperVC.labelText = @"查询中...";
    [hud_SuperVC show:YES];
    SearchWorkRequest *searchWorkRequest = [[SearchWorkRequest alloc] init];
    
    [searchWorkRequest searchWorkShopName:shxmTextField.text AndShopCode:shbhTextField.text completionBlock:^(NSDictionary *searchWorkDic) {
        
        if([searchWorkDic [@"status"] intValue] == 2){
            //没有网络
            hud_SuperVC.labelText = searchWorkDic[@"Info"];
        }else if ([searchWorkDic[@"status"] intValue] == 1){
            //登录失败
            hud_SuperVC.labelText = searchWorkDic[@"Info"];
        }else{
            //登录成功
            hud_SuperVC.labelText = searchWorkDic[@"Info"];
            workInfoDic = [[NSDictionary alloc] initWithDictionary:searchWorkDic[@"jsonInfoData"]];
        }
        [hud_SuperVC hide:YES afterDelay:1];

        NSLog(@"%@",searchWorkDic);
    }];
    

    
}
#pragma mark -- Super Method
- (void)hudWasHidden:(MBProgressHUD *)hud{
    searchButton.userInteractionEnabled = YES;
    searchButton.backgroundColor = RED_COLOR2;
    if ([hud.labelText isEqualToString:@"查询成功"]) {
        
        UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
        WorkSearchViewController *childController = [board instantiateViewControllerWithIdentifier: @"WorkSearchVC"];
        childController.searchWorkData = workInfoDic;
        [self.navigationController pushViewController:childController animated:YES];

        
    }
}






#pragma mark -- UITextFieldDelegate 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];

    return YES;
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
