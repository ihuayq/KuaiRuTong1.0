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

#import "TPKeyboardAvoidingTableView.h"
#import "FMLoadMoreFooterView.h"
#import "HZAreaPickerView.h"
#import "DropDownListView.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"


typedef NS_ENUM(int, PickerViewTag){
    SuoShuHangYe = 500,
    HangYeXiLei,
    MCC,
    DepartmentPickerTag,
    Sheng,
    Shi,
};

@interface SHInfoViewController ()<HZAreaPickerDelegate,DropDownChooseDelegate,DropDownChooseDataSource>{
    //TPKeyboardAvoidingTableView *infoTableView;
    UITableView *infoTableView;
    FMLoadMoreFooterView *footerView;
                   
    UITableView *webTableView;
    
    UITextField *shopNameTextField;
    UITextField *bussinessKindTextField;
    UITextField *accountNameTextField;
    UITextField *cardNumberTextField;
    
    UITextField *cityLocationInfoTextField;
    UITextField *addressTextField;
    UITextField *inviteCodeTextField;
    
    CGFloat current_Y;
    
    NSMutableArray *chooseArray;
    
    UIButton* uploadBtn;
    
    
    NSMutableArray *arrayTitle;
}
    
@property (strong, nonatomic) NSString *areaValue,*cityValue;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;
    

@end

@implementation SHInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    self.navigation.rightTitle = @"保存";
    self.navigation.title = @"新增商户";
 
    [self loadBasicView];
    
    arrayTitle = [NSMutableArray arrayWithArray:@[@"商户名称",@"种类",@"账户名称",@"结算卡号",@"城市",@"街道/门牌号",@"邀请码(选填)",@"添加网点"]];
}

-(void)loadBasicView{
//    chooseArray = [NSMutableArray arrayWithArray:@[
//                                                   @[@"原创",@"电视剧",@"动漫",@"电影",@"综艺",@"音乐",@"纪实",@"搞笑",@"游戏",@"娱乐",@"资讯",@"汽车",@"科技",@"体育",@"时尚",@"生活",@"健康",@"教育",@"曲艺",@"旅游",@"美容",@"母婴",@"财经",@"网络剧",@"微电影",@"女性",@"其他1",@"其他2",@"其他3",@"其他4",@"其他5",],
//                                                   @[@"人气最旺",@"最新发布",@"收藏最多",@"打分最高",@"评论最狠",@"土豆推荐",@"清晰视频序",],
//                                                   ]];
    
    
//    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,0,MainWidth, 40) dataSource:self delegate:self];
//    dropDownView.mSuperView = cell.contentView;
//    [cell.contentView addSubview:dropDownView];

    infoTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT)
                                                                style:UITableViewStyleGrouped];
    
//    infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT)
//                                                                 style:UITableViewStyleGrouped];
    [infoTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    //[infoTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    infoTableView.scrollEnabled = YES;
//    infoTableView.userInteractionEnabled = YES;
//    infoTableView.backgroundColor = [UIColor clearColor];
//    infoTableView.backgroundView = nil;
    infoTableView.delegate = self;
    infoTableView.dataSource = self;
    infoTableView.tableFooterView = [UIView new];
    footerView = [[FMLoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, infoTableView.size.width, 70)];
    infoTableView.tableFooterView = footerView;
    [self.view addSubview:infoTableView];
}


#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 + self.nNetAddressCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"InfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [self loadUIForCell:cell AtRow:indexPath.section];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 20.0)];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 20.0);
    headerLabel.text = arrayTitle[section];
    
    [customView addSubview:headerLabel];
    
    return customView;
}

//#pragma mark 返回每组头标题名称
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSLog(@"生成组（组%i）名称",section);
//    return arrayTitle[section];
//}


#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
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
        DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,0,MainWidth, 40) dataSource:self delegate:self];
        //dropDownView.mSuperView = cell.contentView;
        dropDownView.mSuperView = infoTableView;
        [cell.contentView addSubview:dropDownView];
        
        //商户名称
//        bussinessKindTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, 320, 40) Placeholder:@"行业大类/行业细类/mcc" Font:[UIFont systemFontOfSize:20.0]];
//        bussinessKindTextField.borderStyle = UITextBorderStyleNone;
//        bussinessKindTextField.textAlignment = NSTextAlignmentLeft;
//        bussinessKindTextField.delegate = self;
//        [cell.contentView addSubview:bussinessKindTextField];

    }else if (row == 2){
        //账户名称
        accountNameTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, 320, 40) Placeholder:@"请输入账户名称" Font:[UIFont systemFontOfSize:20.0]];
        accountNameTextField.borderStyle = UITextBorderStyleNone;
        accountNameTextField.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:accountNameTextField];
    }else if (row == 3){
        //结算卡号
        cardNumberTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, 320, 40) Placeholder:@"请输入结算卡号" Font:[UIFont systemFontOfSize:20.0]];
        cardNumberTextField.borderStyle = UITextBorderStyleNone;
        cardNumberTextField.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:cardNumberTextField];
    }else if (row == 4){
        uploadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 320, 40)];
        [uploadBtn addTarget:self action:@selector(selectBtn) forControlEvents:UIControlEventTouchUpInside];
        [uploadBtn setTitle:@"XX省 XX市 XX区" forState:UIControlStateNormal];
        uploadBtn.backgroundColor = [UIColor clearColor];
        [uploadBtn setTitleColor:[UIColor light_Gray_Color]forState:UIControlStateNormal];
        uploadBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;//设置文字位置，现设为居左，默认的是居中
        uploadBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
        [cell.contentView addSubview:uploadBtn];
        
    }else if (row == 5){
        //详细地址
        addressTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, 320, 40) Placeholder:@"请输入详细地址" Font:[UIFont systemFontOfSize:20.0]];
        addressTextField.borderStyle = UITextBorderStyleNone;
        addressTextField.textAlignment = NSTextAlignmentLeft;
        
        [cell.contentView addSubview:addressTextField];
    }else if (row == 6){
        //商户邀请码
        inviteCodeTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, 320, 40) Placeholder:@"请输入商户邀请码(选填)" Font:[UIFont systemFontOfSize:20.0]];
        inviteCodeTextField.borderStyle = UITextBorderStyleNone;
        inviteCodeTextField.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:inviteCodeTextField];
    }
}

-(void)selectBtn{
    
    [[infoTableView TPKeyboardAvoiding_findFirstResponderBeneathView:infoTableView] resignFirstResponder];
    
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
    
    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
    [self.locatePicker showInView:self.view];
    
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        [uploadBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district] forState:UIControlStateNormal];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}

#pragma mark -- UITextFieldDelegate 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //[textField resignFirstResponder];
    [self.locatePicker resignFirstResponder];
    
    return YES;
}

#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    if (section == 0) {
        NSString *  sub = [[chooseArray objectAtIndex:section] objectAtIndex:index];
    }else{
        NSString * sub = [[chooseArray objectAtIndex:section] objectAtIndex:index];
    }
}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [chooseArray count];
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}

-(NSString *)titleInSection:(NSInteger)section index:(NSInteger)index
{
    return chooseArray[section][index];
}

-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}


#pragma mark -- UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 1) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

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
