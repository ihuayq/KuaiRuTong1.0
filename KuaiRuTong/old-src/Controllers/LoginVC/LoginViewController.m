//
//  bbbbbbbbbbbbb                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      .m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/8.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "LoginViewController.h"

#import "LoginRequest.h"

#import "CustomTabBarViewController.h"


@interface LoginViewController (){
    UITextField *usernameTextField;//用户名TF
    UITextField *passwordTextField;//密码TF
    UIButton *loginButton;//登录按钮
  
}

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicView];
}

/**
 *  加载登录基础视图
 */
- (void)loadBasicView{
    
    self.view.backgroundColor = RED_COLOR1;
    
    customNavBar.backView.hidden = YES;
    //用户名登录
    usernameTextField = [ViewModel createTextFieldWithFrame:CGRectMake(86, 43, 191, 30) Placeholder:@"请输入用户名" Font:nil];
    usernameTextField.borderStyle = UITextBorderStyleNone;
    usernameTextField.textAlignment = NSTextAlignmentLeft;
    usernameTextField.textColor = [UIColor whiteColor];
    [usernameTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    usernameTextField.delegate = self;
    [scrollView addSubview:usernameTextField];
    
    //用户名图标
    UIImageView *usernameIcon = [ViewModel createImageViewWithFrame:CGRectMake(46, 48, 26, 25) ImageName:nil];
    usernameIcon.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:usernameIcon];
    
    //分割线1
    UIView *line1 = [ViewModel createViewWithFrame:CGRectMake(46, 79, 230, 1)];
    line1.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:line1];
    
    //密码图标
    UIImageView *passwordIcon = [ViewModel createImageViewWithFrame:CGRectMake(46, 98, 26, 25) ImageName:nil];
    passwordIcon.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:passwordIcon];
    
    //密码
    passwordTextField = [ViewModel createTextFieldWithFrame:CGRectMake(86, 98, 191, 30) Placeholder:@"请输入密码" Font:nil];
    passwordTextField.textColor = [UIColor whiteColor];
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.textAlignment = NSTextAlignmentLeft;
    [passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    passwordTextField.secureTextEntry = YES;
    passwordTextField.delegate  = self;
    [scrollView addSubview:passwordTextField];
    
    //分割线2
    UIView *line2 = [ViewModel createViewWithFrame:CGRectMake(46, 133, 230, 1)];
    line2.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:line2];
    
    //登录按钮
    loginButton = [ViewModel createButtonWithFrame:CGRectMake(75, 165, 170, 38) ImageNormalName:nil ImageSelectName:nil Title:@"登   录" Target:self Action:@selector(loginButtonClicked)];
    loginButton.backgroundColor = ORANGE_COLOR;
    [scrollView addSubview:loginButton];
   
    //简信
    UILabel *infoLabel = [ViewModel createLabelWithFrame:CGRectMake(0, 0, 0, 0) Font:[UIFont boldSystemFontOfSize:12.0] Text:@"海科融通公司2011-2013版本所有"];
    infoLabel.frame = CGRectMake(0, scrollView.frame.size.height - 101 * HEIGHT_SCALE, 320 * WIDTH_SCALE, 100 * HEIGHT_SCALE);
    infoLabel.backgroundColor = RED_COLOR2;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:infoLabel];
}



#pragma mark -- private Methods
/**
 *  登录方法
 *  @retun void
 */
- (void)loginButtonClicked{
    
    usernameTextField.text = @"Test-办事处销售陈玉洁";
    passwordTextField.text = @"1q2w3e4r";
   
    //1.退出键盘
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    //2.禁止按下登录按钮
    //按钮不能点击
    loginButton.userInteractionEnabled = NO;
    //按钮变灰
    loginButton.backgroundColor = [UIColor grayColor];
    
    //3.进入等待状态
    hud_SuperVC.mode = MBProgressHUDModeIndeterminate;
    hud_SuperVC.labelText = @"登录中...";
    [hud_SuperVC show:YES];

    
    LoginRequest *loginRequest = [[LoginRequest alloc] init];
    [loginRequest loginWithUsername:usernameTextField.text AndPassword:passwordTextField.text completionBlock:^(NSDictionary *loginDic) {
        if([loginDic[@"status"] intValue] == 2){
            //没有网络
            hud_SuperVC.labelText = loginDic[@"Info"];
        }else if ([loginDic[@"status"] intValue] == 1){
            //登录失败
            hud_SuperVC.labelText = loginDic[@"Info"];
        }else{
            //登录成功
            hud_SuperVC.labelText = loginDic[@"Info"];
        }
        [hud_SuperVC hide:YES afterDelay:1];
    }];
}

#pragma mark -- UITextFieldDelegate 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [scrollView setContentOffset:CGPointMake(0, 40 * HEIGHT_SCALE) animated:YES];
    return YES;
}
#pragma mark -- MBProgressHUDDelegate 代理方法
- (void)hudWasHidden:(MBProgressHUD *)hud{
    loginButton.userInteractionEnabled = YES;
    loginButton.backgroundColor = [UIColor orangeColor];
    if ([hud.labelText isEqualToString:@"登录成功"]) {

        UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
        CustomTabBarViewController *childController = [board instantiateViewControllerWithIdentifier: @"CustomTabBarVC"];
        [self.navigationController pushViewController:childController animated:YES];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
