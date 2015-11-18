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


//typedef NS_ENUM(int, PickerViewTag){
//    SuoShuHangYe = 500,
//    HangYeXiLei,
//    MCC,
//    DepartmentPickerTag,
//    Sheng,
//    Shi,
//};

@interface SHInfoViewController ()<HZAreaPickerDelegate,DropDownChooseDelegate,DropDownChooseDataSource>{
    //TPKeyboardAvoidingTableView *tableView;
    //UITableView *infoTableView;
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
    UIButton* bussinessKindBtn;
    
    NSMutableArray *arrayTitle;
    //分组信息
    NSMutableArray *group;
    NSMutableArray *addressList;
    
    
    UIButton * deletebtn;
    
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
 
    
    
    [self initGroup];
    [self loadBasicView];
}

-(void)loadBasicView{
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT -  240)
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
    
    //footerView = [[FMLoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.size.width, 70)];
    //self.tableView.tableFooterView = footerView;
//   [self.tableView setEditing:YES];

}

- (void) initGroup {
    addressList = [NSMutableArray arrayWithArray:@[]];
    group=[[NSMutableArray alloc] init];
    arrayTitle = [NSMutableArray arrayWithArray:@[@"商户名称",@"种类",@"账户名称",@"结算卡号",@"城市",@"街道/门牌号",@"邀请码(选填)",@"添加网点"]];

    for (NSString *av in arrayTitle) {
        BusinessInfoCellPart *contact0=[BusinessInfoCellPart initWithPlacehold:@""];
        BusinessInfoCellGroup *group0=[BusinessInfoCellGroup initWithDetail:av andContacts:[NSMutableArray arrayWithObjects:contact0, nil]];
        [group addObject:group0];
    }
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
    }
    
    //添加信息
    if (indexPath.section == group.count - 1) {
        cell.textLabel.text = addressList[indexPath.row];
    }
    else{
        [self loadUIForCell:cell AtSection:indexPath.section];
    }

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
            [self displayOverFlowActivityView:@"无法删除" maxShowTime:(CGFloat)0.5];
            return;
        }
        
        NSUInteger row = [indexPath row]; //获取当前行
        [addressList removeObjectAtIndex:row]; //在数据中删除当前对象
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];//数组执行删除操作
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
        [cell.contentView addSubview:shopNameTextField];
    }else if(section == 1){
        bussinessKindBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, MainWidth, 40)];
        [bussinessKindBtn addTarget:self action:@selector(selectBusinessKindBtn) forControlEvents:UIControlEventTouchUpInside];
        [bussinessKindBtn setTitle:@"行业大类 行业细分 mcc" forState:UIControlStateNormal];
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
        [cell.contentView addSubview:accountNameTextField];
    }else if (section == 3){
        //结算卡号
        cardNumberTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, MainWidth, 40) Placeholder:@"请输入结算卡号" Font:[UIFont systemFontOfSize:20.0]];
        cardNumberTextField.borderStyle = UITextBorderStyleNone;
        cardNumberTextField.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:cardNumberTextField];
    }else if (section == 4){
        uploadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, MainWidth, 40)];
        [uploadBtn addTarget:self action:@selector(selectBtn) forControlEvents:UIControlEventTouchUpInside];
        [uploadBtn setTitle:@"XX省 XX市 XX区" forState:UIControlStateNormal];
        uploadBtn.backgroundColor = [UIColor clearColor];
        [uploadBtn setTitleColor:[UIColor light_Gray_Color]forState:UIControlStateNormal];
        uploadBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;//设置文字位置，现设为居左，默认的是居中
        uploadBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
        [cell.contentView addSubview:uploadBtn];
        
    }else if (section == 5){
        //详细地址
        addressTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, MainWidth, 40) Placeholder:@"请输入详细地址" Font:[UIFont systemFontOfSize:20.0]];
        addressTextField.borderStyle = UITextBorderStyleNone;
        addressTextField.textAlignment = NSTextAlignmentLeft;
        
        [cell.contentView addSubview:addressTextField];
    }else if (section == 6){
        //商户邀请码
        inviteCodeTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, MainWidth, 40) Placeholder:@"请输入商户邀请码(选填)" Font:[UIFont systemFontOfSize:20.0]];
        inviteCodeTextField.borderStyle = UITextBorderStyleNone;
        inviteCodeTextField.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:inviteCodeTextField];
    }
//    else if (section == 7){
//        //商户邀请码
//        UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 4, MainWidth, 40)];
//        [moreBtn addTarget:self action:@selector(addNetPiontInfo) forControlEvents:UIControlEventTouchUpInside];
//        [moreBtn setTitle:@"添加网点" forState:UIControlStateNormal];
//        moreBtn.backgroundColor = [UIColor clearColor];
//        [moreBtn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
//        [cell.contentView addSubview:moreBtn];
//    }
}

//省市区选择器
-(void)selectBtn{
    LocationPickerViewController *locationPickerVC = [[LocationPickerViewController alloc] init];
    locationPickerVC.block = ^(NSString *strProvice,NSString *strCity,NSString *strArea){
        [uploadBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@", strProvice,strCity,strArea] forState:UIControlStateNormal];
    };
    [self presentViewController:locationPickerVC animated:NO completion:nil];
}

//mcc种类选择器
-(void)selectBusinessKindBtn{
    
}

//网点信息编辑器
-(void)addNetPiontInfo{
    if (addressList.count == 3) {
        //[self presentCustomDlg:@"最多添加三个"];
        return;
    }
    
    SHNewNetPointViewController *vc = [[SHNewNetPointViewController alloc] init];
    vc.block = ^(NSString *strAddress){
        if (![strAddress isEmpty]) {
            [addressList addObject:strAddress];
            [self.tableView reloadData];
        }
    };
    [self presentViewController:vc animated:NO completion:nil];
}

@end
