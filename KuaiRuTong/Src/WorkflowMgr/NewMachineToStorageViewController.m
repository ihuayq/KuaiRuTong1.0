//
//  NewMachineToStorageViewController.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/27.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "NewMachineToStorageViewController.h"
#import "RETableViewManager.h"
#import "RETableViewOptionsController.h"
#import "SNReaderViewController.h"


@interface NewMachineToStorageViewController ()<RETableViewManagerDelegate,SNReaderDelegate,NewMachineDataServiceDelegate>{
    
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) RETableViewManager *manager;
@property (strong, nonatomic) RETableViewSection *basicControlsSection;
@property (strong, nonatomic) RETableViewSection *buttonSection;



@property (strong, nonatomic) RETextItem    *itemPosCode; //机身序列号
@property (strong, nonatomic) REPickerItem  *itemManufacturer;//厂商名称
@property (strong, nonatomic) REPickerItem  *itemTerminalType; //机具类型
@property (strong, nonatomic) REPickerItem  *itemVersion;//机具型号
@property (strong, nonatomic) RETextItem    *itemNum;//机具数量

//{"termCopInf":["银点","实达","魔方","深圳华智融科技有限公司","王八","福建鑫诺","福建新大陆支付技术有限公司","虹堡科技股份有限公司","杭州百富电子技术有限公司","深圳新国都技术股份有限公司","深圳华智融科技有限公司","惠尔丰","福建联迪","锦弘霖"],"terminalType":["拨号POS(非键盘)","拨号POS(键盘)","移动POS"]}

@end

@implementation NewMachineToStorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    self.navigation.rightTitle = @"扫码";
    self.navigation.title =@"自备机入库";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.sectionHeaderHeight = 0.1;
    
    [self.view addSubview:self.tableView];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    self.basicControlsSection = [self addBaseSection];
    self.buttonSection = [self addButton];
    
//    [self displayOverFlowActivityView:@"加载数据"];
//    [self.service beginSeachDetailByPosCode:self.model.machine_code];
    
}

- (RETableViewSection *)addBaseSection{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@""];
    section.headerHeight = 0.1;
    [self.manager addSection:section];
    
    self.itemPosCode = [RETextItem itemWithTitle:@"机身序列号" value:nil placeholder:@"请输入机身序列号"]; //机身序列号
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(0, 0, 60, 30)];
    [button addTarget:self action:@selector(touchCheckButton) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"验证" forState:UIControlStateNormal];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:button.frame.size.height/2.0f];
    self.itemPosCode.accessoryView = button;
    
    self.itemManufacturer = [REPickerItem itemWithTitle:@"厂商机型" value:@[@"魔方"] placeholder:nil options:@[@[@"魔方", @"深圳华智融科技有限公司", @"福建新大陆支付技术有限公司"]]];
    self.itemManufacturer.onChange = ^(REPickerItem *item){
        NSLog(@"Value: %@", item.value);
        weakSelf.itemVersion.value = @[@"点击1"];
        weakSelf.itemVersion.options = @[@[@"点击1",@"点击2"]];
        
        [weakSelf.tableView  reloadData];
    };
    
    self.itemTerminalType = [REPickerItem itemWithTitle:@"机具类型" value:@[@"拨号POS(非键盘)"] placeholder:nil options:@[@[@"拨号POS(非键盘)", @"拨号POS(键盘)", @"移动POS"]]];
    self.itemTerminalType.onChange = ^(REPickerItem *item){
        NSLog(@"Value: %@", item.value);
    };

    self.itemVersion= [REPickerItem itemWithTitle:@"型号类型" value:@[@"测试"] placeholder:nil options:@[@[@"测试"]]];
    self.itemVersion.onChange = ^(REPickerItem *item){
        NSLog(@"Value: %@", item.value);
    };//机具型号
    
    self.itemNum = [RETextItem itemWithTitle:@"机具数量" value:nil placeholder:@"请输入机具数量"];;//机具数量
    
    [section addItem:self.itemPosCode];
    [section addItem:self.itemManufacturer];
    [section addItem:self.itemTerminalType];
    [section addItem:self.itemVersion];
    [section addItem:self.itemNum];

    return section;
}

-(void)touchCheckButton{
    
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
    self.itemPosCode.value = zbarString;
    [self.tableView  reloadData];
    
    [self dismissModalViewControllerAnimated: YES];
}


- (RETableViewSection *)addButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"确认入库" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        //item.title = @"Pressed!";
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
        [self setRequestEnterMachineInfo];
       
        
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
    return section;
}

-(void)setRequestEnterMachineInfo{
    
    //{"name":"agesales","pos_serial_number":"lo666","factory":"杭州百富电子技术有限公司","pos_type":"移动POS","pos_model":"WP-70","pos_number":"1"
    NSMutableDictionary *enterPosPostDic = [[NSMutableDictionary alloc] init];
    [enterPosPostDic setObject:self.itemPosCode      forKey:@"pos_serial_number"];
    [enterPosPostDic setObject:self.itemManufacturer      forKey:@"factory"];
    [enterPosPostDic setObject:self.itemTerminalType      forKey:@"pos_type"];
    [enterPosPostDic setObject:self.itemVersion      forKey:@"pos_model"];
    [enterPosPostDic setObject:self.itemNum      forKey:@"pos_number"];
    
    [self displayOverFlowActivityView:@"正在绑定"];
    [self.service beginUploadByShopName:enterPosPostDic];
}

- (NewMachineDataService *)service
{
    if (!_service) {
        _service = [[NewMachineDataService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

-(void)getManufacturerStorageServiceResult:(NewMachineDataService *)service
                                    Result:(BOOL)isSuccess_
                                  errorMsg:(NSString *)errorMsg{
    
}

-(void)checkPosCodeServiceResult:(NewMachineDataService *)service
                             Result:(BOOL)isSuccess_
                           errorMsg:(NSString *)errorMsg{
    [self removeOverFlowActivityView];
    
    if (isSuccess_ == YES) {
        [self.tableView reloadData];
    }
    
}

-(void)upLoadMachineInfoServiceResult:(NewMachineDataService *)service
                               Result:(BOOL)isSuccess_
                             errorMsg:(NSString *)errorMsg{
    [self removeOverFlowActivityView];
    
    if (isSuccess_ == YES) {
        
        [self.tableView reloadData];
    }
    
}

@end
