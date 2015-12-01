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
#import "LocationPickerVC.h"
#import "LocationPickerViewController.h"
#import "DAContextMenuCell.h"
#import "BusinessInfoCellPart.h"
#import "SHNewNetPointViewController.h"
#import "MccPickViewController.h"
#import "SHDataItem.h"

//typedef NS_ENUM(int, PickerViewTag){
//    SuoShuHangYe = 500,
//    HangYeXiLei,
//    MCC,
//    DepartmentPickerTag,
//    Sheng,
//    Shi,
//};

@interface SHInfoViewController () <CityAndMccInfoDelegate>{
    UITextField *shopNameTextField;
    
    UITextField *bussinessKindTextField;
    NSString *strSelectCategory;
    NSString *strSelectSubCategory;
    NSString *strSelectMccCode;
    
    UITextField *accountNameTextField;
    UITextField *cardNumberTextField;
    
    UITextField *cityLocationInfoTextField;
    NSString *strSelectProvice;
    NSString *strSelectCity;
    NSString *strSelectArea;
    NSString *cityLocationInfoText;
    
    UITextField *addressTextField;
    UITextField *inviteCodeTextField;
    
    CGFloat current_Y;
    
    NSMutableArray *chooseArray;
    UIButton* uploadBtn;
    UIButton* bussinessKindBtn;
    
    NSMutableArray *arrayTitle;
    //分组信息
    NSMutableArray *group;
    NSMutableArray *addressList;
    NSMutableArray *codeList;
    
    
    UIButton * deletebtn;
    
}
    
@property (strong, nonatomic) NSString *areaValue,*cityValue;

@property (strong, nonatomic) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic,strong) UIButton *addWDButton;
//已经添加的网点数据的数量
@property(nonatomic,assign) int nNetAddressCount;
    

@end

@implementation SHInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    self.navigation.rightTitle = @"保存";
    self.navigation.title = @"新增商户";
 
    [self initGroup];
    [self loadBasicView];
    [self initViewData];
}

- (void) initGroup {
    addressList = [NSMutableArray arrayWithArray:@[]];
    codeList = [NSMutableArray arrayWithArray:@[]];
    group=[[NSMutableArray alloc] init];
    arrayTitle = [NSMutableArray arrayWithArray:@[@"商户名称",@"种类",@"账户名称",@"结算卡号",@"城市",@"街道/门牌号",@"邀请码(选填)",@"添加网点"]];
    
    for (NSString *av in arrayTitle) {
        BusinessInfoCellPart *contact0=[BusinessInfoCellPart initWithPlacehold:@""];
        BusinessInfoCellGroup *group0=[BusinessInfoCellGroup initWithDetail:av andContacts:[NSMutableArray arrayWithObjects:contact0, nil]];
        [group addObject:group0];
    }
}

-(void)loadBasicView{
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT - 180)
                                                                  style:UITableViewStyleGrouped];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.tableView.scrollEnabled = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//        infoTableView.userInteractionEnabled = YES;
//        infoTableView.backgroundColor = [UIColor clearColor];
//        infoTableView.backgroundView = nil;
    [self.view addSubview:self.tableView];
    
    
    _addWDButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.tableView.size.width, 40)];
    //_addWDButton.backgroundColor = RED_COLOR1;
    [_addWDButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _addWDButton.layer.masksToBounds = YES;
    [_addWDButton addTarget:self action:@selector(addNetPiontInfo) forControlEvents:UIControlEventTouchUpInside];
    [_addWDButton setTitle:@"添加网点" forState:UIControlStateNormal];
    _addWDButton.layer.cornerRadius = 5.0;
    self.tableView.tableFooterView = _addWDButton;
    
//    if (self.isLoadJson == YES) {
        [self displayOverFlowActivityView:@"更新Mcc数据" maxShowTime:120];
        [self.service beginRequest];
//    }
    
}

-(void)initViewData{
    if(self.item){
        strSelectCategory = self.item.industry;
        strSelectSubCategory = self.item.industry_subclass;
        strSelectMccCode = self.item.mcc;
        
        strSelectProvice = self.item.bank_province;
        strSelectCity = self.item.bank_city;

        codeList = [NSMutableArray arrayWithArray:[self.item.pos_code componentsSeparatedByString:@";"]];
        addressList = [NSMutableArray arrayWithArray:[self.item.branch_add componentsSeparatedByString:@";"]];
        
    }
}


- (CityAndMccInfoService *)service
{
    if (!_service) {
        _service = [[CityAndMccInfoService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

-(void)getCityAndMccInfoServiceResult:(CityAndMccInfoService *)service
                               Result:(BOOL)isSuccess_
                             errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];

}




#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return group.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BusinessInfoCellGroup *Cells= group[section];

    if (section == group.count - 1) {
        return addressList.count;
    }
    return Cells.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"InfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.showsReorderControl =YES;
        [self loadUIForCell:cell AtSection:indexPath.section];
    }
    
    //添加信息
    if (indexPath.section == group.count - 1) {
        cell.textLabel.text = addressList[indexPath.row];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == group.count - 1) {
        
        //修改入口
        SHNewNetPointViewController *vc = [[SHNewNetPointViewController alloc] init];
        vc.strPosCodeInfo = codeList[indexPath.row];
        
        NSMutableArray  *array = [NSMutableArray arrayWithArray:[addressList[indexPath.row] componentsSeparatedByString:@","]];
        vc.strAddressInfo = array[array.count - 1];
        [array removeObjectAtIndex:array.count - 1];
        vc.strCityInfo = [array componentsJoinedByString:@","];;
        
        vc.block = ^(NSString *strAddress,NSString *strPosCodeInfo){
            if (![strAddress isEmpty]) {
                addressList[indexPath.row] = strAddress;
                codeList[indexPath.row] = strPosCodeInfo;
                [self.tableView reloadData];
            }
        };
        [self presentViewController:vc animated:NO completion:nil];
    }
    
}

//定制标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, MainWidth, 20.0)];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    headerLabel.frame = CGRectMake(10.0, 4.0, 300.0, 20.0);
    headerLabel.text = arrayTitle[section];
    
    if (section == group.count - 1) {
        deletebtn = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth - 120, 0, 120, 20)];
        [deletebtn addTarget:self action:@selector(noteDelete) forControlEvents:UIControlEventTouchUpInside];
        [deletebtn setTitle:@"删除" forState:UIControlStateNormal];
        deletebtn.backgroundColor = [UIColor clearColor];
        [deletebtn setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateNormal];
        [customView addSubview:deletebtn];
    }
    
    [customView addSubview:headerLabel];
    return customView;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( indexPath.section == group.count - 1 ){
        return YES;
    }
    return NO;
}

//确认编辑类型
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


//添加行的删除
- (void)noteDelete
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

//删除掉cell方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (addressList.count == 1) {
            [self presentCustomDlg:@"无法删除"];
            return;
        }
        
        NSUInteger row = [indexPath row]; //获取当前行
        [addressList removeObjectAtIndex:row]; //在数据中删除当前对象
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 25;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}


#pragma PrivateMethods
- (void)loadUIForCell:(UITableViewCell *)cell AtSection:(NSInteger)section{
    
    if (section == 0) {
        //商户名称
        shopNameTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, MainWidth, 40) Placeholder:@"请输入商户名称" Font:[UIFont systemFontOfSize:20.0]];
        shopNameTextField.borderStyle = UITextBorderStyleNone;
        shopNameTextField.textAlignment = NSTextAlignmentLeft;
        if (self.item.shop_name) {
            shopNameTextField.text = self.item.shop_name;
        }
        [cell.contentView addSubview:shopNameTextField];
        
    }else if(section == 1){
        bussinessKindBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, MainWidth, 40)];
        [bussinessKindBtn addTarget:self action:@selector(selectBusinessKindBtn) forControlEvents:UIControlEventTouchUpInside];
        if ( strSelectCategory && strSelectSubCategory && strSelectMccCode ) {
            [bussinessKindBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@", strSelectCategory,strSelectSubCategory,strSelectMccCode] forState:UIControlStateNormal];
        }
        else{
            [bussinessKindBtn setTitle:@"行业大类 行业细分 mcc" forState:UIControlStateNormal];
        }
        
        bussinessKindBtn.backgroundColor = [UIColor clearColor];
        [bussinessKindBtn setTitleColor:[UIColor light_Gray_Color]forState:UIControlStateNormal];
        bussinessKindBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;//设置文字位置，现设为居左，默认的是居中
        bussinessKindBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
        [cell.contentView addSubview:bussinessKindBtn];

    }else if (section == 2){
        //账户名称
        accountNameTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, MainWidth, 40) Placeholder:@"请输入账户名称" Font:[UIFont systemFontOfSize:20.0]];
        accountNameTextField.borderStyle = UITextBorderStyleNone;
        accountNameTextField.textAlignment = NSTextAlignmentLeft;
        accountNameTextField.text = self.item.account_name;
        [cell.contentView addSubview:accountNameTextField];
        
    }else if (section == 3){
        //结算卡号
        cardNumberTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, MainWidth, 40) Placeholder:@"请输入结算卡号" Font:[UIFont systemFontOfSize:20.0]];
        cardNumberTextField.borderStyle = UITextBorderStyleNone;
        cardNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
        cardNumberTextField.textAlignment = NSTextAlignmentLeft;
        cardNumberTextField.text = self.item.bank_card_num;
        [cell.contentView addSubview:cardNumberTextField];
        
    }else if (section == 4){
        uploadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, MainWidth, 40)];
        [uploadBtn addTarget:self action:@selector(selectBtn) forControlEvents:UIControlEventTouchUpInside];

        if (self.item.bank_province && self.item.bank_city) {
            [uploadBtn setTitle:[NSString stringWithFormat:@"%@ %@", self.item.bank_province,self.item.bank_city] forState:UIControlStateNormal];
        }else{
            [uploadBtn setTitle:@"XX省 XX市 " forState:UIControlStateNormal];
        }
        
        uploadBtn.backgroundColor = [UIColor clearColor];
        [uploadBtn setTitleColor:[UIColor light_Gray_Color]forState:UIControlStateNormal];
        uploadBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;//设置文字位置，现设为居左，默认的是居中
        uploadBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
        [cell.contentView addSubview:uploadBtn];
        
    }else if (section == 5){
        //详细地址
        addressTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, MainWidth,40) Placeholder:@"请输入详细地址" Font:[UIFont systemFontOfSize:20.0]];
        addressTextField.borderStyle = UITextBorderStyleNone;
        addressTextField.textAlignment = NSTextAlignmentLeft;
        addressTextField.text = self.item.bank_add;
        
        [cell.contentView addSubview:addressTextField];
    }else if (section == 6){
        //商户邀请码
        inviteCodeTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, MainWidth, 40) Placeholder:@"请输入商户邀请码(选填)" Font:[UIFont systemFontOfSize:20.0]];
        inviteCodeTextField.borderStyle = UITextBorderStyleNone;
        inviteCodeTextField.textAlignment = NSTextAlignmentLeft;
        inviteCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
        inviteCodeTextField.text = self.item.invitation_code;
        [cell.contentView addSubview:inviteCodeTextField];
    }
}

//省市区选择器
-(void)selectBtn{
    LocationPickerViewController *locationPickerVC = [[LocationPickerViewController alloc] init];
    locationPickerVC.block = ^(NSString *strProvice,NSString *strCity,NSString *strArea){
        //城市信息选择器
        strSelectProvice = strProvice;
        strSelectCity = strCity;
        strSelectArea = strArea;

        [uploadBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@", strProvice,strCity,strArea] forState:UIControlStateNormal];
    };
    [self presentViewController:locationPickerVC animated:NO completion:nil];
}

//mcc种类选择器
-(void)selectBusinessKindBtn{
    MccPickViewController*locationPickerVC = [[MccPickViewController alloc] init];
    locationPickerVC.pickerDic = self.service.pickerDic;
    locationPickerVC.block = ^(NSString *strCategory,NSString *strSubCategory,NSString *strMccCode){
        strSelectCategory = strCategory;
        strSelectSubCategory = strSubCategory;
        strSelectMccCode = strMccCode;

        [bussinessKindBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@", strCategory,strSubCategory,strMccCode] forState:UIControlStateNormal];
    };
    [self presentViewController:locationPickerVC animated:NO completion:nil];
}

//网点信息编辑器
-(void)addNetPiontInfo{
    if (addressList.count == 3) {
        [self presentCustomDlg:@"最多添加三个"];
        return;
    }
    
    SHNewNetPointViewController *vc = [[SHNewNetPointViewController alloc] init];
    vc.block = ^(NSString *strAddress,NSString *strPosCodeInfo){
        if (![strAddress isEmpty]) {
            [addressList addObject:strAddress];
            [codeList addObject:strPosCodeInfo];
            [self.tableView reloadData];
        }
    };
    [self presentViewController:vc animated:NO completion:nil];
}


-(void)previousToViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

//保存
-(void)rightButtonClickEvent
{
    //商户名
    if ([shopNameTextField.text isEmptyOrWhitespace]) {
        [self presentCustomDlg:@"商户名称为空"];
        return;
    }
    
    //行业种类

    
    //账号名称
    if ([accountNameTextField.text isEmptyOrWhitespace]) {
        [self presentCustomDlg:@"账号名称为空"];
        return;
    }
    
    //结算卡号
    if ([cardNumberTextField.text isEmptyOrWhitespace]) {
        [self presentCustomDlg:@"结算卡号为空"];
        return;
    }
    
    //城市位置
    if ([cityLocationInfoText isEmptyOrWhitespace]) {
        [self presentCustomDlg:@"未选择省市信息"];
        return;
    }
    //详细地址
    if ([addressTextField.text isEmptyOrWhitespace]) {
        [self presentCustomDlg:@"地址为空"];
        return;
    }
    
//    //邀请码
//    if ([inviteCodeTextField.text isEmptyOrWhitespace]) {
//        [self presentCustomDlg:@"邀请码为空"];
//        return;
//    }
    
    //网点数据
    if ( addressList.count == 0) {
        [self presentCustomDlg:@"请添加网点地址"];
        return;
    }

    //SHDataItem *item =  [[SHDataItem alloc] init];
    self.item.shop_name = shopNameTextField.text;
    self.item.industry = strSelectCategory;
    self.item.industry_subclass = strSelectSubCategory;
    self.item.mcc = strSelectMccCode;
    
    self.item.account_name = accountNameTextField.text;
    self.item.bank_card_num = cardNumberTextField.text;
    self.item.pub_pri = @"1";
    self.item.invitation_code = inviteCodeTextField.text;
    self.item.bank_province = strSelectProvice;
    self.item.bank_city = strSelectCity;
    self.item.bank_add = addressTextField.text;
    //网点信息
    NSString *allCodeString = [codeList componentsJoinedByString:@";"];
    NSString *allAddressString = [addressList componentsJoinedByString:@";"];
    self.item.pos_code = allCodeString;
    self.item.branch_add = allAddressString;

    [self.navigationController popViewControllerAnimated:YES];
}

@end
