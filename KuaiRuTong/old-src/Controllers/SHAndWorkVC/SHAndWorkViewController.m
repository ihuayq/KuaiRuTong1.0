//
//  SHAndWorkViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/11.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "SHAndWorkViewController.h"
#import "SHSearchViewController.h"
#import "SearchSHRequest.h"
@interface SHAndWorkViewController (){
    UITextField *shbhTextField;
    UITextField *shxmTextField;
    UITextField *xlhTextField;
    UIButton *searchButton;
    NSArray *detailSHInfosArray;
}

@end

@implementation SHAndWorkViewController

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
    customNavBar.titleLabel.text = @"商户查询";
    
    //商户编号 - label
    UILabel *shbhLabel = [ViewModel createLabelWithFrame:CGRectMake(10, 10, 70, 21) Font:[UIFont boldSystemFontOfSize:13.0] Text:@"商户编号"];
    [scrollView addSubview:shbhLabel];
    
    //商户编号 - TextField
    shbhTextField = [ViewModel createTextFieldWithFrame:CGRectMake(90, 8, 220, 30) Placeholder:nil Font:[UIFont boldSystemFontOfSize:13.0]];
    shbhTextField.delegate = self;
    [scrollView addSubview:shbhTextField];
    
    //分割线1
    UIView *line1 = [ViewModel createViewWithFrame:CGRectMake(0, 41, 320, 1)];
    line1.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:line1];
    
    //商户姓名 - label
    UILabel *shmcLabel = [ViewModel createLabelWithFrame:CGRectMake(10, 50, 70, 21) Font:[UIFont boldSystemFontOfSize:13.0] Text:@"商户名称"];
    [scrollView addSubview:shmcLabel];
    
    //商户姓名 - TextField
    shxmTextField = [ViewModel createTextFieldWithFrame:CGRectMake(90, 46, 220, 30) Placeholder:nil Font:[UIFont boldSystemFontOfSize:13.0]];
    shxmTextField.delegate = self;
    [scrollView addSubview:shxmTextField];
    
    //分割线2
    UIView *line2 = [ViewModel createViewWithFrame:CGRectMake(0, 80, 320, 1)];
    line2.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:line2];
    
    //机身序列号 - label
    UILabel *xlhLabel = [ViewModel createLabelWithFrame:CGRectMake(10, 86, 70, 21) Font:[UIFont boldSystemFontOfSize:13.0] Text:@"机身序列号"];
    [scrollView addSubview:xlhLabel];
    
    
    //机身序列号 - TextField
    xlhTextField = [ViewModel createTextFieldWithFrame:CGRectMake(90, 84, 220, 30) Placeholder:nil Font:[UIFont boldSystemFontOfSize:13.0]];
    xlhTextField.delegate = self;
    [scrollView addSubview:xlhTextField];
    
    //分割线3
    UIView *line3 = [ViewModel createViewWithFrame:CGRectMake(0, 116, 320, 1)];
    line3.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:line3];
    
    //商户查询按钮
    searchButton = [ViewModel createButtonWithFrame:CGRectMake(0, 327, 320, 30) ImageNormalName:nil ImageSelectName:nil Title:@"商户查询" Target:self Action: @selector(searchButtonClicked)];
    searchButton.backgroundColor = RED_COLOR2;
    [scrollView addSubview:searchButton];
    
}

#pragma mark -- PrivateMethods 代理方法
- (void)searchButtonClicked{
    shbhTextField.text = @"M0058523";
    shxmTextField.text = @"Test--陈玉洁";
    xlhTextField.text =  @"130014122902373";
    
    searchButton.backgroundColor = [UIColor lightGrayColor];
    searchButton.userInteractionEnabled = NO;
    
    hud_SuperVC.mode = MBProgressHUDModeIndeterminate;
    hud_SuperVC.labelText = @"查询中...";
    [hud_SuperVC show:YES];
    
    
    SearchSHRequest *searchSHRequest = [[SearchSHRequest alloc] init];
    [searchSHRequest searchSHCode:shbhTextField.text AndshName:shxmTextField.text AndPosCode:xlhTextField.text completionBlock:^(NSDictionary *seachSHDic) {
        if([seachSHDic[@"status"] intValue] == 2){
            //没有网络
            hud_SuperVC.labelText = seachSHDic[@"Info"];
        }else if ([seachSHDic[@"status"] intValue] == 1){
            //登录失败
            hud_SuperVC.labelText = seachSHDic[@"Info"];
        }else{
            //登录成功
            hud_SuperVC.labelText = seachSHDic[@"Info"];
            detailSHInfosArray = [[NSArray alloc] initWithArray:seachSHDic[@"desic"]];
        }
        [hud_SuperVC hide:YES afterDelay:1];

    }];
    
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    searchButton.userInteractionEnabled = YES;
    searchButton.backgroundColor = RED_COLOR2;
    if ([hud.labelText isEqualToString:@"查询成功"]) {
        
        UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
        SHSearchViewController *childController = [board instantiateViewControllerWithIdentifier: @"SHSearchVC"];
        childController.resultsArray = detailSHInfosArray;
        [self.navigationController pushViewController:childController animated:YES];
        
    }
}
#pragma mark -- UITextFieldDelegate 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == xlhTextField) {
         [scrollView setContentOffset:CGPointMake(0, 80 * HEIGHT_SCALE) animated:YES];
    }
   
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
