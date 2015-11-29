//
//  UpdatePosTermianlToNetPointViewController.m
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/29.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "UpdatePosTermianlToNetPointViewController.h"

#import "RETableViewManager.h"
#import "RETableViewOptionsController.h"
#import "SNReaderViewController.h"


@interface UpdatePosTermianlToNetPointViewController ()<RETableViewManagerDelegate,SNReaderDelegate,SHSearchDataServiceDelegate>{
    
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) RETableViewManager *manager;
@property (strong, nonatomic) RETableViewSection *basicControlsSection;
@property (strong, nonatomic) RETableViewSection *buttonSection;



@property (strong, nonatomic) RETextItem  *itemMerCode; //商户编号
@property (strong, nonatomic) RETextItem  *itemShopName;//网点名称
@property (strong, nonatomic) RETextItem  *itemTerminalNo; //机身序列号
@property (strong, nonatomic) RETextItem  *itemBindPhone;//绑定电话


@end

@implementation UpdatePosTermianlToNetPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    self.navigation.rightTitle = @"扫码";
    self.navigation.title =@"终端绑定";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.sectionHeaderHeight = 0.1;
    
    [self.view addSubview:self.tableView];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    self.basicControlsSection = [self addBaseSection];
    self.buttonSection = [self addButton];
    
}

- (RETableViewSection *)addBaseSection{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@""];
    section.headerHeight = 0.1;
    [self.manager addSection:section];
    
    
    self.itemMerCode = [RETextItem itemWithTitle:@"商户编号" value:nil placeholder:@"请输入商户编号"]; //商户编号
    self.itemShopName = [RETextItem itemWithTitle:@"网点名称" value:nil placeholder:@"请输入网点名称"];//网点名称
    self.itemTerminalNo = [RETextItem itemWithTitle:@"机身序列号" value:nil placeholder:@"请输入机身序列号"]; //机身序列号
    self.itemBindPhone = [RETextItem itemWithTitle:@"绑定电话" value:nil placeholder:@"请输入绑定电话"];//绑定电话
    
    [section addItem:self.itemMerCode];
    [section addItem:self.itemShopName];
    [section addItem:self.itemTerminalNo];
    [section addItem:self.itemBindPhone];
    
    return section;
}

//扫描条形码
-(void)rightButtonClickEvent{
    SNReaderViewController *readerViewController = [[SNReaderViewController alloc] init];
    readerViewController.snDelegate = self;
    //readerViewController.isServicePay = YES;
    [self presentModalViewController:readerViewController animated:YES];
}

#pragma mark ----------------------------- bar code reader call back

- (void)readerView:(ZBarReaderView *)view
    didReadSymbols:(ZBarSymbolSet *)symbols
         fromImage:(UIImage *)image
{
    ZBarSymbol *symbol = nil;
    
    for (symbol in symbols)
    {
        break;
    }
    
    NSString *zbarString = symbol.data;
    self.itemTerminalNo.value = zbarString;
    [self.tableView  reloadData];
    
    [self dismissModalViewControllerAnimated: YES];
}


- (RETableViewSection *)addButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"确认绑定" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        //item.title = @"Pressed!";
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
        [self setRequestEnterMachineInfo];
        
        
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
    return section;
}

//{
//    "code": "",		返回编码
//    "msg":"",	返回信息
//}
//地址：http://192.168.13.30:8080/self/jsp/mobileTermShopBound.action
//测试数据：{"name":"agesales","network_name":"adsadsadsadadgag","shop_num":"M8000057","binding_phone":"123456789","pos_num":"tyu36643212"}


-(void)setRequestEnterMachineInfo{
    
    
    NSMutableDictionary *enterPosPostDic = [[NSMutableDictionary alloc] init];
    [enterPosPostDic setObject:self.itemShopName.value      forKey:@"network_name"];
    [enterPosPostDic setObject:self.itemMerCode.value      forKey:@"shop_num"];
    [enterPosPostDic setObject:self.itemBindPhone.value      forKey:@"binding_phone"];
    [enterPosPostDic setObject:self.itemTerminalNo.value      forKey:@"pos_num"];


    [self displayOverFlowActivityView:@"正在绑定"];
    [self.service beginBindWithPara:enterPosPostDic];
}

- (SHSearchDataService *)service
{
    if (!_service) {
        _service = [[SHSearchDataService alloc] init];
        _service.delegate = self;
    }
    return _service;
}



-(void)upLoadMachineInfoServiceResult:(SHSearchDataService *)service
                               Result:(BOOL)isSuccess_
                             errorMsg:(NSString *)errorMsg{
    [self removeOverFlowActivityView];
    
    if (isSuccess_ == YES) {

        [self.tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
