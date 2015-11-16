//
//  KuCunViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/16.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "KuCunViewController.h"
#import "KuCunDetailViewController.h"
#import "SearchKCRequest.h"
@interface KuCunViewController (){
    UITextField *shbhTextField;
    UITextField *shxmTextField;
    UITextField *xlhTextField;
    UITextField *stateTextField;
    UIButton *searchButton;
    NSDictionary *searchKuCunData;
}

@end

@implementation KuCunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicView];
    
}
/**
 *  加载基本视图
 */
- (void)loadBasicView{
    
    //标题栏
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"库存查询";
    customNavBar.Delegate = self;

    
    //商户编号 - label
    UILabel *shbhLabel = [ViewModel createLabelWithFrame:CGRectMake(10, 10, 92, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@"商户编号"];
    [scrollView addSubview:shbhLabel];
    //商户编号 - TextField
    shbhTextField = [ViewModel createTextFieldWithFrame:CGRectMake(102, 8, 205, 30) Placeholder:nil Font:nil];
    shbhTextField.delegate = self;
    [scrollView addSubview:shbhTextField];
    //分割线
    UIView *line1 = [ViewModel createViewWithFrame:CGRectMake(0, 42, 320, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:line1];
    
    
    //商户姓名 - label
    UILabel *shmcLabel = [ViewModel createLabelWithFrame:CGRectMake(10, 47, 91, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@"商户名称"];
    [scrollView addSubview:shmcLabel];
    //商户姓名 - TextField
    shxmTextField = [ViewModel createTextFieldWithFrame:CGRectMake(102, 45, 205, 30) Placeholder:nil Font:nil];
    shxmTextField.delegate = self;
    [scrollView addSubview:shxmTextField];
    //分割线
    UIView *line2 = [ViewModel createViewWithFrame:CGRectMake(0, 79, 320, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:line2];
    
    //机身序列号 - label
    UILabel *xlhLabel = [ViewModel createLabelWithFrame:CGRectMake(10, 84, 91, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@"机身序列号"];
    [scrollView addSubview:xlhLabel];
    //机身序列号 - TextField
    xlhTextField = [ViewModel createTextFieldWithFrame:CGRectMake(102, 82, 205, 30) Placeholder:nil Font:nil];
    xlhTextField.delegate = self;
    [scrollView addSubview:xlhTextField];
    //分割线
    UIView *line3 = [ViewModel createViewWithFrame:CGRectMake(0, 117, 320, 1)];
    line3.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:line3];
    
    
    //绑定状态 - label
    UILabel *stateLabel = [ViewModel createLabelWithFrame:CGRectMake(10, 121, 91, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@"绑定状态"];
    [scrollView addSubview:stateLabel];
    //绑定状态 - TextField
    stateTextField = [ViewModel createTextFieldWithFrame:CGRectMake(102, 119, 205, 30) Placeholder:nil Font:nil];
    stateTextField.delegate = self;
    [scrollView addSubview:stateTextField];
    //分割线
    UIView *line4 = [ViewModel createViewWithFrame:CGRectMake(0, 153, 320, 1)];
    line4.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:line4];
    
    //商户查询按钮
    searchButton = [ViewModel createButtonWithFrame:CGRectMake(0, 327, 320, 30) ImageNormalName:nil ImageSelectName:nil Title:@"查 询" Target:self Action:@selector(searchButtonClicked)];
    searchButton.backgroundColor = RED_COLOR1;
    [scrollView addSubview:searchButton];
    
}



#pragma mark -- PrivateMethods 代理方法
- (void)searchButtonClicked{
    shbhTextField.text = @"M0058557";
    shxmTextField.text =@"TTest-子商户-陈玉洁";
    xlhTextField.text =@"130014122902066";
    stateTextField.text =@"FALSE";
    NSMutableDictionary *searchKuCunDic = [[NSMutableDictionary alloc] init];
    [searchKuCunDic setObject:shbhTextField.text forKey:@"shbh"];
    [searchKuCunDic setObject:shxmTextField.text forKey:@"shxm"];
    [searchKuCunDic setObject:xlhTextField.text forKey:@"xlh"];
    [searchKuCunDic setObject:stateTextField.text forKey:@"state"];
    NSUserDefaults *userDefaults  = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searchKuCunDic forKey:@"SouSuoKuCun"];
    [userDefaults synchronize];
    
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    KuCunDetailViewController *childController = [board instantiateViewControllerWithIdentifier: @"KuCunDetailVC"];
    [self.navigationController pushViewController:childController animated:YES];
    
    
    }







#pragma mark -- UITextFieldDelegate 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    return YES;
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
