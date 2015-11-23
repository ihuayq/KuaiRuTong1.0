//
//  LoginViewController.m
//  jxtuan
//
//  Created by 融通互动 on 13-8-19.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import "LoginViewController.h"
#import "BTLabel.h"

@interface LoginViewController (){
    UIButton *loginButton;
//    UILabel*agreeTitleLabel;
}

@end

@implementation LoginViewController

@synthesize isSupplerSelected = _isSupplerSelected;

@synthesize loginService = _loginService;

- (LoginDataService *)loginService
{
    if (!_loginService) {
        _loginService = [[LoginDataService alloc] init];
        _loginService.delegate = self;
    }
    return _loginService;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _isSupplerSelected = true;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    //nameTextField.text=[self delStringNull:[[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_SUPPLYER_NAME]];
    //[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:LAST_LOGIN_NAME];
    
    [passwordTextField setText:@""];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

-(UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


-(void) initUI
{
//    UIImageView *logoImageView = [[UIImageView alloc] init ];
//    [logoImageView setFrame:CGRectMake(0, 0, MainWidth, MainHeight/3 + 30)];
//    [logoImageView setImage:[UIImage imageNamed:@"loginpage"]];
//    UIImage * ii = [self imageWithColor:UISTYLECOLOR andSize:(CGSize)CGSizeMake(MainWidth,MainHeight/3)];
//    [logoImageView setImage:ii];
//    [self.view addSubview:logoImageView];
    self.title = @"快入通";
    
    BTLabel *label;
    
    CGFloat fontSize = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? 13 : 8;
    UIFont *font = [UIFont systemFontOfSize:18];
    CGColorRef color = [UIColor colorWithHue:0 saturation:0 brightness:0.8 alpha:1].CGColor;
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:28],
                                 NSForegroundColorAttributeName: [UIColor orangeColor]
                                 };
    
    label = [[BTLabel alloc] initWithFrame:CGRectMake(20, NAVIGATION_OUTLET_HEIGHT + 20,MainWidth - 20*2,120) edgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    label.text = [NSString stringWithFormat:@"快入通"];
    label.verticalAlignment = BTVerticalAlignmentCenter;
    label.textAlignment = NSTextAlignmentCenter;
    //    label.layer.borderWidth = 1;
    //    label.layer.borderColor = color;
    [self.view addSubview:label];
    
    
    //设置 姓名信息
    UIImageView *bgImageView10 = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,25,25)];
    [bgImageView10 setImage:[UIImage imageNamed:@"姓名"]];

    UIImageView *bgImageView11 = [[UIImageView alloc] initWithFrame:CGRectMake(20,NAVIGATION_OUTLET_HEIGHT + 120,MainWidth-40, 40)];
    [bgImageView11 setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView11 ];
    [bgImageView11 addSubview:bgImageView10];

    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, NAVIGATION_OUTLET_HEIGHT + 120, 240, 40)];
    nameTextField.backgroundColor = [UIColor clearColor];
    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    nameTextField.placeholder = @"请输入用户账号";
    nameTextField.font = [UIFont systemFontOfSize:14];
    nameTextField.delegate = self;
    nameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    nameTextField.borderStyle = UITextBorderStyleNone;
    nameTextField.text = self.loginName;
    [self.view addSubview:nameTextField];
    
    //设置密码设置信息
    UIImageView *bgImageView20 = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,25,25)];
    [bgImageView20 setImage:[UIImage imageNamed:@"密码"]];
    [self.view  addSubview:bgImageView20];

    UIImageView *bgImageView21 = [[UIImageView alloc] initWithFrame:CGRectMake(20, nameTextField.frame.size.height + nameTextField.frame.origin.y + 20,MainWidth-40, 40)];
    [bgImageView21 setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView21];
    [bgImageView21 addSubview:bgImageView20];


    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(60,nameTextField.frame.size.height + nameTextField.frame.origin.y + 20, 240, 40)];
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField.placeholder = @"请输入登录密码";
    passwordTextField.font = [UIFont systemFontOfSize:14];
    passwordTextField.delegate = self;
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.secureTextEntry=YES;
    [self.view addSubview:passwordTextField];

//  f84206 橘红色按钮点击后及其他非按钮的橘红色色值
//  f9551c 点击前色值
    loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [loginButton setFrame:CGRectMake(20, passwordTextField.frame.size.height + passwordTextField.frame.origin.y + 50, MainWidth-40, 40)];
    [loginButton addTarget:self action:@selector(touchLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [loginButton.layer setMasksToBounds:YES];
    [loginButton.layer setCornerRadius:loginButton.frame.size.height/2.0f];
    [self.view addSubview:loginButton];
    
    nameTextField.text = @"Test-办事处销售陈玉洁";
    passwordTextField.text = @"1q2w3e4r";
    
}


- (UIColor *)getColor:(NSString*)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
}


- (BOOL)checkPassword:(NSString *)str
{
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入密码" delegate:self cancelButtonTitle:L(@"queding")otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
//    if (msgstring.length<6)
//    {
//        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"密码输入少于6位" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
//        [alertview show];
//        return NO;
//    }
//    return [self checkPassWordString:str];
    return  YES;
}

- (BOOL)checkName:(NSString *)str
{
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入账号" delegate:self cancelButtonTitle:L(@"queding") otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
//    NSString *regex = PhoneNoRegex;
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isMatch = [pred evaluateWithObject:str];
//    
//    if (!isMatch)
//    {
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:queding otherButtonTitles:nil, nil];
//        [alert show];
//        return NO;
//        
//    }
    return YES;
}


-(void)touchLoginButton
{


    
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"login", nil];
    NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
//    [self displayOverFlowActivityView];
//    
//    [self.loginService beginLogin:nameTextField.text Passport:passwordTextField.text];
    
}

-(void)getLoginServiceResult:(LoginDataService *)service
                      Result:(BOOL)isSuccess_
                    errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if(YES == isSuccess_)
    {
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"login", nil];
        NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}

#pragma mark -
#pragma mark - UITextFieldDelegate
//业务规则
//1、	手机号码
//l	手机号码为11位纯数字，正则表达式验证输入登录手机号后输入框失去焦点后立即校验手机号码合法性；
//2、登录密码
//l	6≤密码长度≤16，数字和英文字母（区分大小写），必须有至少一位英文字母；
//l	密码输入错误时，提示“提示密码错误后清空密码输入框，保留已输入手机号；密码累计错误次数达到一定值时（可配置），账号锁定一段时间（可配置）；
//l	密码校验时间：用户手机3分钟无操作，完全退出程序，再次进入程序时，
//l	已经设置手势密码登录的商户下次登录时，默认为手势密码登录，在页面给出传统登录方式的切换方式(二期)；
//3、	交易密码
//l	6≤密码长度≤16；禁止使用连续性比较强的字母和数字，不能与登录密码相同；至少有一位英文字母；

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(0, -120, MainWidth, MainHeight)];
    }];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   // [self touchesBegan:nil withEvent:nil];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == nameTextField)
    {
        if (string.length > 0)
        {
            if ([string isEqualToString:@" "])
            {
                return NO;
            }
            return textField.text.length < 20;
        }
    }
    if (textField==passwordTextField)
    {
        if (string.length > 0)
        {
            if ([string isEqualToString:@" "])
            {
                return NO;
            }
            return textField.text.length < 20;
        }
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    }];
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
