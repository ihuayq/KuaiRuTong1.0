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


@interface NewMachineToStorageViewController ()<RETableViewManagerDelegate>{
    UITableView *tableView;
}

@property (strong, nonatomic) RETableViewManager *manager;
@property (strong, nonatomic) RETableViewSection *basicControlsSection;
@property (strong, nonatomic) RETableViewSection *buttonSection;



@property (strong, nonatomic) RETableViewItem *itemCode;
@property (strong, nonatomic) REPickerItem  *itemManufacturer;
@property (strong, nonatomic) RETableViewItem *itemTerminalType;
@property (strong, nonatomic) RETableViewItem *itemVersion;
@property (strong, nonatomic) RETableViewItem *itemNum;

//{"termCopInf":["银点","实达","魔方","深圳华智融科技有限公司","王八","福建鑫诺","福建新大陆支付技术有限公司","虹堡科技股份有限公司","杭州百富电子技术有限公司","深圳新国都技术股份有限公司","深圳华智融科技有限公司","惠尔丰","福建联迪","锦弘霖"],"terminalType":["拨号POS(非键盘)","拨号POS(键盘)","移动POS"]}

@end

@implementation NewMachineToStorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    self.navigation.rightTitle = @"扫码";
    self.navigation.title =@"自备机入库";
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT) style:UITableViewStyleGrouped];
    tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:tableView];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:tableView delegate:self];
    
    self.basicControlsSection = [self addBaseSection];
    
//    [self displayOverFlowActivityView:@"加载数据"];
//    [self.service beginSeachDetailByPosCode:self.model.machine_code];
    
}

- (RETableViewSection *)addBaseSection{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@""];
    [self.manager addSection:section];
    
    for (NSInteger i = 1; i <= 5; i++) {
        RETableViewItem *item = [RETableViewItem itemWithTitle:[NSString stringWithFormat:@"Section 1, Item %li", (long) i] accessoryType:UITableViewCellAccessoryNone selectionHandler:nil];
        item.editingStyle = UITableViewCellEditingStyleDelete;
        item.deletionHandler = ^(RETableViewItem *item) {
            NSLog(@"Item removed: %@", item.title);
        };
        [section addItem:item];
    }
    
    
    self.itemManufacturer = [REPickerItem itemWithTitle:@"Picker" value:@[@"Item 12", @"Item 23"] placeholder:nil options:@[@[@"Item 11", @"Item 12", @"Item 13"], @[@"Item 21", @"Item 22", @"Item 23", @"Item 24"]]];
    self.itemManufacturer.onChange = ^(REPickerItem *item){
        NSLog(@"Value: %@", item.value);
    };
    
//    [section addItem:[NSString stringWithFormat:@"商户编号:%@",self.service.model.shop_id]];
//    [section addItem:[NSString stringWithFormat:@"商户名称:%@",self.service.model.shop_name]];
//    [section addItem:[NSString stringWithFormat:@"网点编号:%@",self.service.model.netpoint_id]];
//    [section addItem:[NSString stringWithFormat:@"网点名称:%@",self.service.model.netpoint_name]];
//    [section addItem:[NSString stringWithFormat:@"机身序列号:%@",self.service.model.machine_code]];
//    [section addItem:[NSString stringWithFormat:@"机身状态:%@",self.service.model.machine_status]];
//    [section addItem:[NSString stringWithFormat:@"库存状态:%@",self.service.model.kucun_status]];
//    [section addItem:[NSString stringWithFormat:@"绑定状态:%@",self.service.model.bind_status]];
    
    return section;
}


- (RETableViewSection *)addButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"解除绑定" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        //item.title = @"Pressed!";
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
    return section;
}

@end
