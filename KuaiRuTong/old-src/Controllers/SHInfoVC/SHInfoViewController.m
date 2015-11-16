//
//  SHInfoViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "SHInfoViewController.h"
#import "DeviceManager.h"
#import "DZProtocolViewController.h"
#import "AddWebViewController.h"
typedef NS_ENUM(int, PickerViewTag){
    SuoShuHangYe = 500,
    HangYeXiLei,
    MCC,
    DepartmentPickerTag,
    Sheng,
    Shi,
};

@interface SHInfoViewController (){
    UITableView *infoTableView;
    UITableView *webTableView;
    UIButton *dlButton;
    UIButton *xlButton;
    UIButton *mccButton;
    UIButton *cityButton;
    UITextField *shopNameTextField;
    UITextField *usernameTextField;
    UITextField *cardNumberTextField;
    UITextField *addressTextField;
    UITextField *inviteCodeTextField;
    CGFloat current_Y;
}
@end

@implementation SHInfoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    [self loadBasicView];
}

-(void)loadBasicView{
    //navBar
    customNavBar.customSaveBtn.hidden = NO;
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"新增商户";
    customNavBar.Delegate = self;
    //infoTableView
    infoTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 5, 320, 280) CellHeight:40 ScrollEnabled:NO];
    infoTableView.dataSource = self;
    infoTableView.delegate = self;
    [scrollView addSubview:infoTableView];
    //webTabelView
    webTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 285, 320, 0) CellHeight:40 ScrollEnabled:NO];
    webTableView.dataSource = self;
    webTableView.delegate = self;
    [scrollView addSubview:webTableView];
    current_Y = 285 + (webTableView.frame.size.height / HEIGHT_SCALE) + 50;
   
    //uibutton
    UIButton *addWDButton = [ViewModel createButtonWithFrame:CGRectMake(110, current_Y, 100, 40) ImageNormalName:nil ImageSelectName:nil Title:@"新增网点" Target:self Action:@selector(addWDButtonClicked)];
    addWDButton.backgroundColor = RED_COLOR1;
    addWDButton.layer.masksToBounds = YES;
    addWDButton.layer.cornerRadius = 5.0;
    [scrollView addSubview:addWDButton];
    [scrollView setContentSize:CGSizeMake(0, current_Y + 50)];
    
}
#pragma mark -- Private Method
- (void)addWDButtonClicked{
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    AddWebViewController *childController = [board instantiateViewControllerWithIdentifier: @"AddWebVC"];
    [self.navigationController pushViewController:childController animated:YES];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"InfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [self loadUIForCell:cell AtRow:indexPath.row];
    return cell;
}

#pragma PrivateMethods
- (void)loadUIForCell:(UITableViewCell *)cell AtRow:(NSInteger)row{
    if (row == 0) {
        //商户名称
        shopNameTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, 320, 40) Placeholder:@"请输入商户名称" Font:[UIFont systemFontOfSize:20.0]];
        shopNameTextField.borderStyle = UITextBorderStyleNone;
        shopNameTextField.textAlignment = NSTextAlignmentLeft;
        shopNameTextField.delegate = self;
        [cell.contentView addSubview:shopNameTextField];
    }else if(row == 1){
        //行业大类（选择）
        dlButton = [ViewModel createButtonWithFrame:CGRectMake(10, 5, 90, 30) ImageNormalName:nil ImageSelectName:nil Title:@"行业大类" Target:self Action:@selector(dlButtonClicked)];
        dlButton.backgroundColor  = [UIColor lightGrayColor];
        [dlButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        dlButton.layer.masksToBounds = YES;
        dlButton.layer.cornerRadius = 5.0f;
        [cell.contentView addSubview:dlButton];
        //行业细类（选择）
        xlButton = [ViewModel createButtonWithFrame:CGRectMake(110, 5, 110, 30) ImageNormalName:nil ImageSelectName:nil Title:@"行业细类" Target:self Action:@selector(xlButtonClicked)];
        xlButton.backgroundColor  = [UIColor lightGrayColor];
        [xlButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        xlButton.layer.masksToBounds = YES;
        xlButton.layer.cornerRadius = 5.0f;
        [cell.contentView addSubview:xlButton];
        //mcc（选择）
        mccButton = [ViewModel createButtonWithFrame:CGRectMake(230, 5, 80, 30) ImageNormalName:nil ImageSelectName:nil Title:@"mcc" Target:self Action:@selector(mccButtonClicked)];
        mccButton.backgroundColor  = [UIColor lightGrayColor];
        [mccButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        mccButton.layer.masksToBounds = YES;
        mccButton.layer.cornerRadius = 5.0f;
        [cell.contentView addSubview:mccButton];

    }else if (row == 2){
        //账户名称
        usernameTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, 320, 40) Placeholder:@"请输入账户名称" Font:[UIFont systemFontOfSize:20.0]];
        usernameTextField.borderStyle = UITextBorderStyleNone;
        usernameTextField.textAlignment = NSTextAlignmentLeft;
        usernameTextField.delegate = self;
        [cell.contentView addSubview:usernameTextField];
    }else if (row == 3){
        //结算卡号
        cardNumberTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, 320, 40) Placeholder:@"请输入结算卡号" Font:[UIFont systemFontOfSize:20.0]];
        cardNumberTextField.borderStyle = UITextBorderStyleNone;
        cardNumberTextField.textAlignment = NSTextAlignmentLeft;
        cardNumberTextField.delegate = self;
        [cell.contentView addSubview:cardNumberTextField];
    }else if (row == 4){
        //省、市
        cityButton = [ViewModel createButtonWithFrame:CGRectMake(10, 5, 210, 30) ImageNormalName:nil ImageSelectName:nil Title:@"省 / 市" Target:self Action:@selector(cityButtonClicked)];
        cityButton.backgroundColor  = [UIColor lightGrayColor];
        [cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cityButton.layer.masksToBounds = YES;
        cityButton.layer.cornerRadius = 5.0f;
        [cell.contentView addSubview:cityButton];
        
    }else if (row == 5){
        //详细地址
        addressTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, 320, 40) Placeholder:@"请输入详细地址" Font:[UIFont systemFontOfSize:20.0]];
        addressTextField.borderStyle = UITextBorderStyleNone;
        addressTextField.textAlignment = NSTextAlignmentLeft;
        addressTextField.delegate = self;
        [cell.contentView addSubview:addressTextField];
    }else if (row == 6){
        //商户邀请码
        inviteCodeTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, 320, 40) Placeholder:@"请输入商户邀请码(选填)" Font:[UIFont systemFontOfSize:20.0]];
        inviteCodeTextField.borderStyle = UITextBorderStyleNone;
        inviteCodeTextField.textAlignment = NSTextAlignmentLeft;
        inviteCodeTextField.delegate = self;
        [cell.contentView addSubview:inviteCodeTextField];
    }
}
- (void)cityButtonClicked{
    
}
- (void)dlButtonClicked{
    
}
- (void)xlButtonClicked{
    BOOL isSelectDL = ![dlButton.titleLabel.text isEqualToString:@"行业大类"];
    if (isSelectDL) {
        //请求
    }else{
        hud_SuperVC.labelText = @"请先选择行业大类";
        hud_SuperVC.mode = MBProgressHUDModeText;
        [hud_SuperVC show:YES];
        [hud_SuperVC hide:YES afterDelay:2];
    }
    
}
- (void)mccButtonClicked{
    BOOL isSelectXL = ![xlButton.titleLabel.text isEqualToString:@"行业细类"];
    if (isSelectXL) {
        //请求
    }else{
        hud_SuperVC.labelText = @"请先选择行业细类";
        hud_SuperVC.mode = MBProgressHUDModeText;
        [hud_SuperVC show:YES];
        [hud_SuperVC hide:YES afterDelay:2];
    }

}

//    
//
//    //账号名称
//    UITextField *usernameTextField = [ViewModel createTextFieldWithFrame:CGRectMake(8, 16, 233, 30) Placeholder:@"账号名称" Font:[UIFont systemFontOfSize:12.0]];
//    usernameTextField.delegate = self;
//    [scrollView addSubview:usernameTextField];
//    
//    //结算卡号
//    UITextField *kaHaoTextField = [ViewModel createTextFieldWithFrame:CGRectMake(8, 145, 233, 30) Placeholder:@"结算卡号" Font:[UIFont systemFontOfSize:12.0]];
//    kaHaoTextField.delegate = self;
//    [scrollView addSubview:kaHaoTextField];
//    
//    //省（选择）
//    UIButton *shengButton =[ViewModel createButtonWithFrame:CGRectMake(8, 183, 77, 25) ImageNormalName:nil ImageSelectName:nil Title:@"省" Target:self Action:@selector(shengButtonClicked)];
//    shengButton.backgroundColor  = [UIColor lightGrayColor];
//    shengButton.layer.borderWidth = 1.0f;
//    [scrollView addSubview:shengButton];
//    
//    //市（选择）
//    UIButton *shiButton = [ViewModel createButtonWithFrame:CGRectMake(86, 183, 77, 25) ImageNormalName:nil ImageSelectName:nil Title:@"市" Target:self Action:@selector(shiButtonClicked)];
//    shiButton.backgroundColor  = [UIColor lightGrayColor];
//    [shiButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    shiButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    shiButton.layer.borderWidth = 1.0f;
//    [scrollView addSubview:shiButton];
//    
//    //结算卡开户行地址
//    UITextField *kaiHuTextField = [ViewModel createTextFieldWithFrame:CGRectMake(164, 181, 148, 30) Placeholder:@"结算卡开户行地址" Font:[UIFont systemFontOfSize:12.0]];
//    kaiHuTextField.delegate = self;
//    [scrollView addSubview:kaiHuTextField];
//    
//    //手机号
//    UITextField *phoneTextField = [ViewModel createTextFieldWithFrame:CGRectMake(8, 219, 233, 30) Placeholder:@"手机号" Font:[UIFont systemFontOfSize:12.0]];
//    phoneTextField.delegate = self;
//    [scrollView addSubview:phoneTextField];
//    
//    //发送验证码
//    UIButton *codeButton = [ViewModel createButtonWithFrame:CGRectMake(244, 219, 71, 28) ImageNormalName:nil ImageSelectName:nil Title:@"发送验证码" Target:nil Action:nil];
//    codeButton.layer.borderWidth = 1.0f;
//    [scrollView addSubview:codeButton];
//    
//    //验证码
//    UITextField *codeTextField = [ViewModel createTextFieldWithFrame:CGRectMake(8, 250, 87, 30) Placeholder:@"验证码" Font:[UIFont systemFontOfSize:12.0]];
//    codeTextField.delegate = self;
//    [scrollView addSubview:codeTextField];
//    
//    //验证手机
//    UIButton *phoneButton = [ViewModel createButtonWithFrame:CGRectMake(98, 251, 71, 28) ImageNormalName:nil ImageSelectName:nil Title:@"验证手机" Target:self Action:nil];
//    phoneButton.layer.borderWidth = 1.0f;
//    [scrollView addSubview:phoneButton];
//    
//    //商户邀请码
//    UITextField *shCodeTextField = [ViewModel createTextFieldWithFrame:CGRectMake(8, 282, 125, 30) Placeholder:@"商户邀请码" Font:[UIFont systemFontOfSize:12.0]];
//    shCodeTextField.delegate = self;
//    [scrollView addSubview:shCodeTextField];
//    
//    //(选填)
//    UILabel *textLabel = [ViewModel createLabelWithFrame:CGRectMake(149, 286, 42, 21) Font:[UIFont systemFontOfSize:12.0] Text:@"(选填)"];
//    textLabel.textColor = [UIColor lightGrayColor];
//    textLabel.text = @"(选填)";
//    [scrollView addSubview:textLabel];
//    
  
    
//}
//- (void)loadBasicInfoUI{
//    //商户名称
//    UITextField *shopNameTextField = [ViewModel createTextFieldWithFrame:CGRectMake(8, 22, 233, 30) Placeholder:@"请输入商户名称" Font:[UIFont systemFontOfSize:12.0]];
//    shopNameTextField.delegate = self;
//    [scrollView addSubview:shopNameTextField];
//    
//    //所属行业（选择）
//    hyButton = [[UIButton alloc] initWithFrame:CGRectMake(8 * WIDTH_SCALE, 71 * HEIGHT_SCALE, 77 * WIDTH_SCALE, 25 * HEIGHT_SCALE)];
//    hyButton.backgroundColor  = [UIColor lightGrayColor];
//    [hyButton setTitle:@"所属行业" forState:UIControlStateNormal];
//    [hyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    hyButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    hyButton.layer.borderWidth = 1.0f;
//    [hyButton addTarget:self action:@selector(hyButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:hyButton];
//    
//    //行业细类（选择）
//    xlButton = [[UIButton alloc] initWithFrame:CGRectMake(86 * WIDTH_SCALE, 71 * HEIGHT_SCALE, 77 * WIDTH_SCALE, 25 * HEIGHT_SCALE)];
//    xlButton.backgroundColor  = [UIColor lightGrayColor];
//    [xlButton setTitle:@"行业细类" forState:UIControlStateNormal];
//    [xlButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    xlButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    xlButton.layer.borderWidth = 1.0f;
//        [xlButton addTarget:self action:@selector(xlButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:xlButton];
//    
//    //mcc（选择）
//    mccButton = [[UIButton alloc] initWithFrame:CGRectMake(164 * WIDTH_SCALE, 71 * HEIGHT_SCALE, 77 * WIDTH_SCALE, 25 * HEIGHT_SCALE)];
//    mccButton.backgroundColor  = [UIColor lightGrayColor];
//    [mccButton setTitle:@"mcc" forState:UIControlStateNormal];
//    [mccButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    mccButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    mccButton.layer.borderWidth = 1.0f;
//    [mccButton addTarget:self action:@selector(mccButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:mccButton];
//    
//    //对公（口）
//    publicButton = [[UIButton alloc] initWithFrame:CGRectMake(255 * WIDTH_SCALE, 71 * HEIGHT_SCALE, 13 * WIDTH_SCALE, 13 * HEIGHT_SCALE)];
//    publicButton.backgroundColor = [UIColor clearColor];
//    publicButton.selected = YES;
//    [publicButton setBackgroundImage:[UIImage imageNamed:@"rememberPwd_button_normal"] forState:UIControlStateNormal];
//    [publicButton setBackgroundImage:[UIImage imageNamed:@"rememberPwd_button_select"] forState:UIControlStateSelected];
//    [publicButton addTarget:self action:@selector(publicButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:publicButton];
//    
//    //对公
//    UIButton *public1Button = [[UIButton alloc] initWithFrame:CGRectMake(276 * WIDTH_SCALE, 65 * HEIGHT_SCALE, 31 * WIDTH_SCALE, 25 * HEIGHT_SCALE)];
//    public1Button.backgroundColor  = [UIColor lightGrayColor];
//    [public1Button setTitle:@"对公" forState:UIControlStateNormal];
//    [public1Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    public1Button.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    public1Button.layer.borderWidth = 1.0f;
//    [public1Button addTarget:self action:@selector(publicButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:public1Button];
//    
//    //对私（口）
//    privateButton = [[UIButton alloc] initWithFrame:CGRectMake(255 * WIDTH_SCALE, 105 * HEIGHT_SCALE, 13 * WIDTH_SCALE, 13 * HEIGHT_SCALE)];
//    privateButton.backgroundColor = [UIColor clearColor];
//    [privateButton setBackgroundImage:[UIImage imageNamed:@"rememberPwd_button_normal"] forState:UIControlStateNormal];
//    [privateButton setBackgroundImage:[UIImage imageNamed:@"rememberPwd_button_select"] forState:UIControlStateSelected];
//    [privateButton addTarget:self action:@selector(privateButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:privateButton];
//    
//    //对私
//    UIButton *private1Button = [[UIButton alloc] initWithFrame:CGRectMake(276 * WIDTH_SCALE, 99 * HEIGHT_SCALE, 31 * WIDTH_SCALE, 25 * HEIGHT_SCALE)];
//    private1Button.backgroundColor  = [UIColor lightGrayColor];
//    [private1Button setTitle:@"对公" forState:UIControlStateNormal];
//    [private1Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    private1Button.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    private1Button.layer.borderWidth = 1.0f;
//    [private1Button addTarget:self action:@selector(privateButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:private1Button];
//    
//    
//    //账号名称
//    UITextField *usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(8 * WIDTH_SCALE, 116 * HEIGHT_SCALE, 233 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    usernameTextField.returnKeyType = UIReturnKeyDone;
//    usernameTextField.backgroundColor = [UIColor clearColor];
//    usernameTextField.borderStyle = UITextBorderStyleLine;
//    usernameTextField.font = [UIFont systemFontOfSize:12.0];
//    usernameTextField.placeholder = @"账号名";
//    usernameTextField.delegate = self;
//    [scrollView addSubview:usernameTextField];
//    
//    //结算卡号
//    UITextField *kaHaoTextField = [[UITextField alloc] initWithFrame:CGRectMake(8 * WIDTH_SCALE, 145 * HEIGHT_SCALE, 233 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    kaHaoTextField.returnKeyType = UIReturnKeyDone;
//    kaHaoTextField.backgroundColor = [UIColor clearColor];
//    kaHaoTextField.borderStyle = UITextBorderStyleLine;
//    kaHaoTextField.font = [UIFont systemFontOfSize:12.0];
//    kaHaoTextField.placeholder = @"结算卡号";
//    kaHaoTextField.delegate = self;
//    [scrollView addSubview:kaHaoTextField];
//    
//    //省（选择）
//    shengButton = [[UIButton alloc] initWithFrame:CGRectMake(8 * WIDTH_SCALE, 183 * HEIGHT_SCALE, 77 * WIDTH_SCALE, 25 * HEIGHT_SCALE)];
//    shengButton.backgroundColor  = [UIColor lightGrayColor];
//    [shengButton setTitle:@"省" forState:UIControlStateNormal];
//    [shengButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    shengButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    shengButton.layer.borderWidth = 1.0f;
//    [shengButton addTarget:self action:@selector(shengButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:shengButton];
//    
//    //市（选择）
//    shiButton = [[UIButton alloc] initWithFrame:CGRectMake(86 * WIDTH_SCALE, 183 * HEIGHT_SCALE, 77 * WIDTH_SCALE, 25 * HEIGHT_SCALE)];
//    shiButton.backgroundColor  = [UIColor lightGrayColor];
//    [shiButton setTitle:@"市" forState:UIControlStateNormal];
//    [shiButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    shiButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    shiButton.layer.borderWidth = 1.0f;
//    [shiButton addTarget:self action:@selector(shiButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:shiButton];
//    
//    //结算卡开户行地址
//    UITextField *kaiHuTextField = [[UITextField alloc] initWithFrame:CGRectMake(164 * WIDTH_SCALE, 181 * HEIGHT_SCALE, 148 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    kaiHuTextField.returnKeyType = UIReturnKeyDone;
//    kaiHuTextField.backgroundColor = [UIColor clearColor];
//    kaiHuTextField.borderStyle = UITextBorderStyleLine;
//    kaiHuTextField.font = [UIFont systemFontOfSize:12.0];
//    kaiHuTextField.placeholder = @"结算卡开户行地址";
//    kaiHuTextField.delegate = self;
//    [scrollView addSubview:kaiHuTextField];
//    
//    //手机号
//    UITextField *phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(8 * WIDTH_SCALE, 219 * HEIGHT_SCALE, 233 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    phoneTextField.returnKeyType = UIReturnKeyDone;
//    phoneTextField.backgroundColor = [UIColor clearColor];
//    phoneTextField.borderStyle = UITextBorderStyleLine;
//    phoneTextField.font = [UIFont systemFontOfSize:12.0];
//    phoneTextField.placeholder = @"手机号";
//    phoneTextField.delegate = self;
//    [scrollView addSubview:phoneTextField];
//    
//    //发送验证码
//    UIButton *codeButton = [[UIButton alloc] initWithFrame:CGRectMake(244 * WIDTH_SCALE, 219 * HEIGHT_SCALE, 71 * WIDTH_SCALE, 28 * HEIGHT_SCALE)];
//    codeButton.backgroundColor  = [UIColor lightGrayColor];
//    [codeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
//    [codeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    codeButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    codeButton.layer.borderWidth = 1.0f;
//    // [codeButton addTarget:self action:@selector(codeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:codeButton];
//    
//    //验证码
//    UITextField *codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(8 * WIDTH_SCALE, 250 * HEIGHT_SCALE, 87 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    codeTextField.returnKeyType = UIReturnKeyDone;
//    codeTextField.backgroundColor = [UIColor clearColor];
//    codeTextField.borderStyle = UITextBorderStyleLine;
//    codeTextField.font = [UIFont systemFontOfSize:12.0];
//    codeTextField.placeholder = @"验证码";
//    codeTextField.delegate = self;
//    [scrollView addSubview:codeTextField];
//    
//    //验证手机
//    UIButton *phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(98 * WIDTH_SCALE, 251 * HEIGHT_SCALE, 71 * WIDTH_SCALE, 28 * HEIGHT_SCALE)];
//    phoneButton.backgroundColor  = [UIColor lightGrayColor];
//    [phoneButton setTitle:@"验证手机" forState:UIControlStateNormal];
//    [phoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    phoneButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    phoneButton.layer.borderWidth = 1.0f;
//    // [phoneButton addTarget:self action:@selector(phoneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:phoneButton];
//    
//    //商户邀请码
//    UITextField *shCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(8 * WIDTH_SCALE, 282 * HEIGHT_SCALE, 125 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    shCodeTextField.returnKeyType = UIReturnKeyDone;
//    shCodeTextField.backgroundColor = [UIColor clearColor];
//    shCodeTextField.borderStyle = UITextBorderStyleLine;
//    shCodeTextField.font = [UIFont systemFontOfSize:12.0];
//    shCodeTextField.placeholder = @"商户邀请码";
//    shCodeTextField.delegate = self;
//    [scrollView addSubview:shCodeTextField];
//    
//    //(选填)
//    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(149 * WIDTH_SCALE, 286 * HEIGHT_SCALE, 42 * WIDTH_SCALE, 21 * HEIGHT_SCALE)];
//    textLabel.backgroundColor = [UIColor clearColor];
//    textLabel.textColor = [UIColor lightGrayColor];
//    textLabel.text = @"(选填)";
//    textLabel.font = [UIFont systemFontOfSize:12.0];
//    [scrollView addSubview:textLabel];
//    
//    webViewTag = 1;
//    [self loadWebAddressUI:webViewTag];
//}
//- (void)addWebButtonClicked{
//    webViewTag ++;
//    [self loadWebAddressUI:webViewTag];
//}
//- (void)deleteWebButtonClicked{
//    if (webViewTag > 1) {
//        webViewTag --;
//        [self loadWebAddressUI:webViewTag];
//    }
//    
//}
//
//- (void)loadWebAddressUI:(int)webTag{
//    
//    [superWebView removeFromSuperview];
//    superWebView = nil;
//    
//    superWebView = [[UIView alloc] init];
//    superWebView.backgroundColor = [UIColor clearColor];
//    superWebView_Height = webViewTag * 160 * HEIGHT_SCALE;
//    superWebView.frame = CGRectMake(0, 326 * HEIGHT_SCALE, 320 * WIDTH_SCALE, superWebView_Height);
//    [scrollView addSubview:superWebView];
//    
//    for (int i = 0 ; i < webTag; i ++) {
//        CGFloat webView_Y = 160 * i * HEIGHT_SCALE;
//        UIView *webView = [[UIView alloc] initWithFrame:CGRectMake(0, webView_Y, 320 * WIDTH_SCALE, 160 * HEIGHT_SCALE)];
//        webView.tag = 300 + i;
//        webView.backgroundColor = [UIColor clearColor];
//        [superWebView addSubview:webView];
//        
//        //网点1
//        UILabel *webLabel = [[UILabel alloc] initWithFrame:CGRectMake(8 * WIDTH_SCALE, 8 * HEIGHT_SCALE, 42 * WIDTH_SCALE, 21 * HEIGHT_SCALE)];
//        webLabel.backgroundColor = [UIColor clearColor];
//        webLabel.textColor = [UIColor blackColor];
//        webLabel.text = [NSString stringWithFormat:@"网点%d",(i + 1)];
//        webLabel.font = [UIFont systemFontOfSize:12.0];
//        [webView addSubview:webLabel];
//        //请填写网点地址或者获取
//        UITextField *addressTextField = [[UITextField alloc] initWithFrame:CGRectMake(58 * WIDTH_SCALE, 9 * HEIGHT_SCALE, 214 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//        addressTextField.returnKeyType = UIReturnKeyDone;
//        addressTextField.backgroundColor = [UIColor clearColor];
//        addressTextField.borderStyle = UITextBorderStyleLine;
//        addressTextField.font = [UIFont systemFontOfSize:12.0];
//        addressTextField.placeholder = @"请填写网点地址或者获取";
//        addressTextField.delegate = self;
//        [webView addSubview:addressTextField];
//        
//        //定位按钮
//        UIButton *locationButton = [[UIButton alloc] initWithFrame:CGRectMake(280 * WIDTH_SCALE, 9 * HEIGHT_SCALE, 32 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//        locationButton.backgroundColor  = [UIColor lightGrayColor];
//        [locationButton setTitle:@"位" forState:UIControlStateNormal];
//        [locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        locationButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//        locationButton.layer.borderWidth = 1.0f;
//        //    [locationButton addTarget:self action:@selector(locationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//        [webView addSubview:locationButton];
//        
//        //请填写机器序列号1
//        UITextField *xlh1TextField = [[UITextField alloc] initWithFrame:CGRectMake(58 * WIDTH_SCALE, 61 * HEIGHT_SCALE, 214 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//        xlh1TextField.returnKeyType = UIReturnKeyDone;
//        xlh1TextField.backgroundColor = [UIColor clearColor];
//        xlh1TextField.borderStyle = UITextBorderStyleLine;
//        xlh1TextField.font = [UIFont systemFontOfSize:12.0];
//        xlh1TextField.placeholder = @"请填写机器序列号或者拍摄";
//        xlh1TextField.delegate = self;
//        [webView addSubview:xlh1TextField];
//        
//        //序列号按钮1
//        UIButton *add1Button = [[UIButton alloc] initWithFrame:CGRectMake(280 * WIDTH_SCALE, 61 * HEIGHT_SCALE, 32 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//        add1Button.backgroundColor  = [UIColor lightGrayColor];
//        [add1Button setTitle:@"拍" forState:UIControlStateNormal];
//        [add1Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        add1Button.titleLabel.font = [UIFont systemFontOfSize:12.0];
//        add1Button.layer.borderWidth = 1.0f;
//        //    [add1Button addTarget:self action:@selector(add1ButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//        [webView addSubview:add1Button];
//        
//        
//        //请填写机器序列号2
//        UITextField *xlh2TextField = [[UITextField alloc] initWithFrame:CGRectMake(58 * WIDTH_SCALE, 94 * HEIGHT_SCALE, 214 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//        xlh2TextField.returnKeyType = UIReturnKeyDone;
//        xlh2TextField.backgroundColor = [UIColor clearColor];
//        xlh2TextField.borderStyle = UITextBorderStyleLine;
//        xlh2TextField.font = [UIFont systemFontOfSize:12.0];
//        xlh2TextField.placeholder = @"请填写机器序列号或者拍摄";
//        xlh2TextField.delegate = self;
//        [webView addSubview:xlh2TextField];
//        
//        //序列号按钮1
//        UIButton *add2Button = [[UIButton alloc] initWithFrame:CGRectMake(280 * WIDTH_SCALE, 94 * HEIGHT_SCALE, 32 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//        add2Button.backgroundColor  = [UIColor lightGrayColor];
//        [add2Button setTitle:@"拍" forState:UIControlStateNormal];
//        [add2Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        add2Button.titleLabel.font = [UIFont systemFontOfSize:12.0];
//        add2Button.layer.borderWidth = 1.0f;
//        //    [add2Button addTarget:self action:@selector(add2ButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//        [webView addSubview:add2Button];
//        
//        //请填写机器序列号3
//        UITextField *xlh3TextField = [[UITextField alloc] initWithFrame:CGRectMake(58 * WIDTH_SCALE, 127 * HEIGHT_SCALE, 214 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//        xlh3TextField.returnKeyType = UIReturnKeyDone;
//        xlh3TextField.backgroundColor = [UIColor clearColor];
//        xlh3TextField.borderStyle = UITextBorderStyleLine;
//        xlh3TextField.font = [UIFont systemFontOfSize:12.0];
//        xlh3TextField.placeholder = @"请填写机器序列号或者拍摄";
//        xlh3TextField.delegate = self;
//        [webView addSubview:xlh3TextField];
//        
//        //序列号按钮3
//        UIButton *add3Button = [[UIButton alloc] initWithFrame:CGRectMake(280 * WIDTH_SCALE, 127 * HEIGHT_SCALE, 32 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//        add3Button.backgroundColor  = [UIColor lightGrayColor];
//        [add3Button setTitle:@"拍" forState:UIControlStateNormal];
//        [add3Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        add3Button.titleLabel.font = [UIFont systemFontOfSize:12.0];
//        add3Button.layer.borderWidth = 1.0f;
//        //    [add3Button addTarget:self action:@selector(add3ButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//        [webView addSubview:add3Button];
//
//    }
//    
//    CGFloat endView_Y = (500 - 160)* HEIGHT_SCALE + superWebView_Height;
//    endView.frame = CGRectMake(0, endView_Y, 320 * WIDTH_SCALE, 145 * HEIGHT_SCALE);
//    [scrollView setContentSize:CGSizeMake(0, endView_Y + 145 * HEIGHT_SCALE)];
//}
//- (void)lastUI{
//    CGFloat endView_Y = 500 * HEIGHT_SCALE ;
//    [scrollView setContentSize:CGSizeMake(0, endView_Y + 145 * HEIGHT_SCALE)];
//    endView = [[UIView alloc] initWithFrame:CGRectMake(0, endView_Y, 320 * WIDTH_SCALE, 145 * HEIGHT_SCALE)];
//    endView.backgroundColor = [UIColor clearColor];
//    [scrollView addSubview:endView];
//    //新增网点
//    UIButton *addWebButton = [[UIButton alloc] initWithFrame:CGRectMake(60 * WIDTH_SCALE, 8 * HEIGHT_SCALE, 77 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    addWebButton.backgroundColor  = [UIColor lightGrayColor];
//    [addWebButton setTitle:@"新增网点" forState:UIControlStateNormal];
//    [addWebButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    addWebButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    addWebButton.layer.borderWidth = 1.0f;
//    [addWebButton addTarget:self action:@selector(addWebButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [endView addSubview:addWebButton];
//    
//    //删除网点
//    UIButton *deleteWebButton = [[UIButton alloc] initWithFrame:CGRectMake(182 * WIDTH_SCALE, 8 * HEIGHT_SCALE, 77 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    deleteWebButton.backgroundColor  = [UIColor lightGrayColor];
//    [deleteWebButton setTitle:@"删除网点" forState:UIControlStateNormal];
//    [deleteWebButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    deleteWebButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    deleteWebButton.layer.borderWidth = 1.0f;
//    [deleteWebButton addTarget:self action:@selector(deleteWebButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [endView addSubview:deleteWebButton];
//    
//    //口
//    protocolButton = [[UIButton alloc] initWithFrame:CGRectMake(39 * WIDTH_SCALE, 60 * HEIGHT_SCALE, 13 * WIDTH_SCALE, 13 * HEIGHT_SCALE)];
//    protocolButton.backgroundColor = [UIColor clearColor];
//    [protocolButton setBackgroundImage:[UIImage imageNamed:@"rememberPwd_button_normal"] forState:UIControlStateNormal];
//    [protocolButton setBackgroundImage:[UIImage imageNamed:@"rememberPwd_button_select"] forState:UIControlStateSelected];
//    [protocolButton addTarget:self action:@selector(protocolButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [endView addSubview:protocolButton];
//    
//    //同意并遵守
//    UILabel *agreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60 * WIDTH_SCALE, 56 * HEIGHT_SCALE, 77 * WIDTH_SCALE, 21 * HEIGHT_SCALE)];
//    agreeLabel.backgroundColor = [UIColor clearColor];
//    agreeLabel.textColor = [UIColor blackColor];
//    agreeLabel.text = @"同意并遵守";
//    agreeLabel.font = [UIFont systemFontOfSize:12.0];
//    [endView addSubview:agreeLabel];
//    
//    //快入通电子协议
//    UIButton *protocol1Button = [[UIButton alloc] initWithFrame:CGRectMake(120 * WIDTH_SCALE, 52 * HEIGHT_SCALE, 93 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    protocol1Button.backgroundColor  = [UIColor clearColor];
//    [protocol1Button setTitle:@"快入通电子协议" forState:UIControlStateNormal];
//    [protocol1Button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    protocol1Button.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    [protocol1Button addTarget:self action:@selector(protocol1ButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [endView addSubview:protocol1Button];
//    
//    //提交
//    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(48 * WIDTH_SCALE, 104 * HEIGHT_SCALE, 100 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    submitButton.backgroundColor  = [UIColor orangeColor];
//    [submitButton setTitle:@"提   交" forState:UIControlStateNormal];
//    [submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    submitButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    submitButton.layer.borderWidth = 1.0f;
//    [submitButton addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [endView addSubview:submitButton];
//    
//    //保存
//    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(170 * WIDTH_SCALE, 104 * HEIGHT_SCALE, 100 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    saveButton.backgroundColor  = [UIColor orangeColor];
//    [saveButton setTitle:@"保   存" forState:UIControlStateNormal];
//    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    saveButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    saveButton.layer.borderWidth = 1.0f;
//    [saveButton addTarget:self action:@selector(saveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [endView addSubview:saveButton];
//}
//- (void)saveButtonClicked{
//    HUD_SHInfoVC.labelText = @"保存成功";
//    HUD_SHInfoVC.mode = MBProgressHUDModeText;
//    [HUD_SHInfoVC show:YES];
//    [HUD_SHInfoVC hide:YES afterDelay:2];
//}
//- (void)submitButtonClicked{
//    HUD_SHInfoVC.labelText = @"提交成功";
//    HUD_SHInfoVC.mode = MBProgressHUDModeText;
//    [HUD_SHInfoVC show:YES];
//    [HUD_SHInfoVC hide:YES afterDelay:2];
//}
//- (void)protocol1ButtonClicked{
//    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
//    DZProtocolViewController *childController = [board instantiateViewControllerWithIdentifier: @"DZProtocolVC"];
//    [self.navigationController pushViewController:childController animated:YES];
//
//}
//
//#pragma mark -- private Methods
///**
// * 对公
// * @return void
// */
//- (void)publicButtonClicked{
//    publicButton.selected = YES;
//    privateButton.selected = NO;
//}
///**
// * 对私
// * @return void
// */
//- (void)privateButtonClicked{
//    publicButton.selected = NO;
//    privateButton.selected = YES;
//}
//
///**
// * 生产PickView
// * @return void
// */
//- (void)createPickerView{
//    selectView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 216 - 30 * HEIGHT_SCALE , 320 * WIDTH_SCALE, 216 + 30 * HEIGHT_SCALE)];
//    selectView.backgroundColor = [UIColor whiteColor];
//    selectView.layer.borderWidth = 1.0f;
//    [self.view addSubview:selectView];
//    
//    UIButton *cacelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    cacelButton.backgroundColor = [UIColor lightGrayColor];
//    [cacelButton setTitle:@"取消" forState:UIControlStateNormal];
//    [cacelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [cacelButton addTarget:self action:@selector(cacelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [selectView addSubview:cacelButton];
//    
//    UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectMake(230 * WIDTH_SCALE, 0, 100 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    okButton.backgroundColor = [UIColor lightGrayColor];
//    [okButton setTitle:@"完成" forState:UIControlStateNormal];
//    [okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [okButton addTarget:self action:@selector(okButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [selectView addSubview:okButton];
//    
//    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30 * HEIGHT_SCALE, 320 * WIDTH_SCALE, 216)];
//    pickerView.dataSource = self;
//    pickerView.delegate=self;
//    pickerView.showsSelectionIndicator=YES;
//    [selectView addSubview:pickerView];
//}
///**
// * 移除
// * @return void
// */
//- (void)cacelButtonClicked{
//    
//    [selectView removeFromSuperview];
//}
///**
// * 选择
// * @return void
// */
//- (void)okButtonClicked{
//    [selectView removeFromSuperview];
//    switch (pickButtonTag) {
//        case SuoShuHangYe:
//            [hyButton setTitle:currentPickerInfo forState:UIControlStateNormal];
//            break;
//        case HangYeXiLei:
//            [xlButton setTitle:currentPickerInfo forState:UIControlStateNormal];
//            break;
//        case MCC:
//            [mccButton setTitle:currentPickerInfo forState:UIControlStateNormal];
//            break;
//        case Sheng:
//            [shengButton setTitle:currentPickerInfo forState:UIControlStateNormal];
//            break;
//        case Shi:
//            [shiButton setTitle:currentPickerInfo forState:UIControlStateNormal];
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//}
//- (void)protocolButtonClicked{
//    if (protocolButton.selected) {
//        protocolButton.selected = NO;
//    }else{
//        protocolButton.selected = YES;
//    }
//}
//#pragma mark -- PickViewAndButton Methods
//- (void)hyButtonClicked{
//    pickButtonTag = SuoShuHangYe;
//    pickerArray = [[NSArray alloc] initWithObjects:@"金融业",@"医疗业",@"美容业", nil];
//    currentPickerInfo = pickerArray[0];
//    [self createPickerView];
//}
//- (void)xlButtonClicked
//{
//    pickButtonTag = HangYeXiLei;
//    pickerArray = [[NSArray alloc] initWithObjects:@"金融业1",@"金融类2",@"金融类3", nil];
//    currentPickerInfo = pickerArray[0];
//    [self createPickerView];
//}
//- (void)mccButtonClicked{
//    pickButtonTag = MCC;
//    pickerArray = [[NSArray alloc] initWithObjects:@"mcc",@"mca",@"mcb", nil];
//    currentPickerInfo = pickerArray[0];
//    [self createPickerView];
//}
//- (void)shengButtonClicked{
//    pickButtonTag = Sheng;
//    pickerArray = [[NSArray alloc] initWithObjects:@"北京市",@"河北省",@"山西省", nil];
//    currentPickerInfo = pickerArray[0];
//    [self createPickerView];
//}
//- (void)shiButtonClicked{
//    pickButtonTag = Shi;
//    pickerArray = [[NSArray alloc] initWithObjects:@"北京市",@"涿州市",@"太原市", nil];
//    currentPickerInfo = pickerArray[0];
//    [self createPickerView];
//}
//
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
//    return 1;
//}
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    return pickerArray.count;
//}
//-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    currentPickerInfo = pickerArray[row];
//    return [pickerArray objectAtIndex:row];
//}

#pragma mark -- UITextFieldDelegate 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == cardNumberTextField){
        [scrollView setContentOffset:CGPointMake(0, 30 * HEIGHT_SCALE)];
    }else{
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}
#pragma mark -- CustomNavBarDelegate
- (void)dealWithBackButtonClickedMethod{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"如果返回将不会保存商户信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"返回", nil];
    [alertView show];
}
- (void)dealWithSaveButtonClickedMethod{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
