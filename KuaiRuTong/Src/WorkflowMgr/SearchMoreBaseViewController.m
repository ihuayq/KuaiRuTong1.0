//
//  SearchMoreBaseViewController.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/23.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "SearchMoreBaseViewController.h"
#import "RETableViewManager.h"
#import "RETableViewOptionsController.h"
#import "QuerySHInterfaceViewController.h"
#import "QueryWorkingStatusViewController.h"
#import "QueryKuCunViewController.h"
#import "CateViewController.h"

@interface SearchMoreBaseViewController ()<RETableViewManagerDelegate>{
    UITableView *tableView;
}

//@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) RETableViewManager *manager;
@property (strong, nonatomic) RETableViewSection *basicControlsSection;
@property (strong, nonatomic) RETableViewSection *buttonSection;
@property (strong, nonatomic) RETableViewSection *baseSHQueqySection;
@property (strong, nonatomic) RETableViewSection *baseWokingStatusQueqySection;
@property (strong, nonatomic) RETableViewSection *baseKuCunQuerySection;


//@property (strong, readwrite, nonatomic) RETextItem *fullLengthFieldItem;
@property (strong, readwrite, nonatomic) RETextItem *textItem;
//@property (strong, readwrite, nonatomic) RENumberItem *numberItem;
//@property (strong, readwrite, nonatomic) RETextItem *passwordItem;
//@property (strong, readwrite, nonatomic) REBoolItem *boolItem;
//@property (strong, readwrite, nonatomic) REFloatItem *floatItem;
@property (strong, readwrite, nonatomic) REDateTimeItem *dateTimeItem;


//商户查询
@property (strong, readwrite, nonatomic) RETextItem *textSHQueqyIDItem;
@property (strong, readwrite, nonatomic) RETextItem *textSHQueqyNameItem;
@property (strong, readwrite, nonatomic) RETextItem *textSHQueqyMachineCodeItem;

//工作状态查询
@property (strong, readwrite, nonatomic) RETextItem *textWorkingStatusQueryIDItem;
@property (strong, readwrite, nonatomic) RETextItem *textWorkingStatusQueryNameItem;


//库存查询
@property (strong, readwrite, nonatomic) RETextItem *textKuCunQueryIDItem;
@property (strong, readwrite, nonatomic) RETextItem *textKuCunQueryNameItem;
@property (strong, readwrite, nonatomic) RETextItem *textKuCunQueryPosCodeItem;
@property (strong, readwrite, nonatomic) RETextItem *textKuCunQueryPosStatusItem;


@end

@implementation SearchMoreBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTitle];
    
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT) style:UITableViewStyleGrouped];
    tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:tableView delegate:self];
    if ( self.nSearchType == USER_QUERY) {
        self.baseSHQueqySection = [self addBaseSHQueqySection];
    }
    else if (self.nSearchType == WOKR_STATAS) {
        self.baseWokingStatusQueqySection = [self addBaseWorkingStatusQueqySection];
    }
    else if( self.nSearchType == STOCK_QUERY ){
        self.baseKuCunQuerySection = [self addBaseKuCunQueqySection];
    }
    else
    {
        //问题查询
        self.basicControlsSection = [self addBasicControls];
    }

    self.buttonSection = [self addButton];
}

-(void)initTitle{
    NSString *str = @"";
    switch (self.nSearchType) {
        case USER_QUERY:
        {
            str = @"商户查询";
            break;
        }
            
        case WOKR_STATAS:
        {
            str = @"工作状态查询";
            break;
        }
        case WAIT_FLOW:
        {
            str = @"待处理流程查询";
            break;
        }
        case ERROR_FLOW:
        {
            str = @"问题流程查询";
            break;
        }
        case STOCK_QUERY:
        {
            str = @"库存查询";
            break;
        }
        case SELFMACHINE_REC:
        {
            str = @"自备机入库查询";
            break;
        }
        default:break;
    }
    
    self.navigation.title = str;
}


- (RETableViewSection *)addBaseSHQueqySection{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"搜索条件"];
    [self.manager addSection:section];

    self.textSHQueqyIDItem = [RETextItem itemWithTitle:@"商户编号" value:nil placeholder:@"请输入商户编号"];
    self.textSHQueqyNameItem = [RETextItem itemWithTitle:@"商户名称" value:nil placeholder:@"请输入商户名"];
    self.textSHQueqyMachineCodeItem = [RETextItem itemWithTitle:@"机身序列号" value:nil placeholder:@"请输入机身序列号"];
    
    [section addItem:self.textSHQueqyIDItem];
    [section addItem:self.textSHQueqyNameItem];
    [section addItem:self.textSHQueqyMachineCodeItem];
    
    return section;
}


- (RETableViewSection *)addBaseWorkingStatusQueqySection{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"搜索条件"];
    [self.manager addSection:section];

    self.textWorkingStatusQueryIDItem = [RETextItem itemWithTitle:@"商户编号" value:nil placeholder:@"请输入商户编号"];
    self.textWorkingStatusQueryNameItem = [RETextItem itemWithTitle:@"商户名称" value:nil placeholder:@"请输入商户名"];
    
    [section addItem:self.textWorkingStatusQueryIDItem];
    [section addItem:self.textWorkingStatusQueryNameItem];
    
    return section;
}


- (RETableViewSection *)addBaseKuCunQueqySection{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"搜索条件"];
    [self.manager addSection:section];
    
    self.textKuCunQueryIDItem = [RETextItem itemWithTitle:@"商户编号" value:nil placeholder:@"请输入商户编号"];
    self.textKuCunQueryNameItem = [RETextItem itemWithTitle:@"商户名称" value:nil placeholder:@"请输入商户名"];
    self.textKuCunQueryPosCodeItem = [RETextItem itemWithTitle:@"机身序列号" value:nil placeholder:@"请输入机具序列号"];
    self.textKuCunQueryPosStatusItem = [RETextItem itemWithTitle:@"机具状态" value:nil placeholder:@"请输入机具状态"];
    
    [section addItem:self.textKuCunQueryIDItem];
    [section addItem:self.textKuCunQueryNameItem];
    [section addItem:self.textKuCunQueryPosCodeItem];
    [section addItem:self.textKuCunQueryPosStatusItem];
    
    return section;
}


- (RETableViewSection *)addBasicControls
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"搜索条件"];
    [self.manager addSection:section];
    
    self.textItem = [RETextItem itemWithTitle:@"商户" value:nil placeholder:@"请输入商户名"];

    self.dateTimeItem = [REDateTimeItem itemWithTitle:@"日期" value:[NSDate date] placeholder:@"请输入日期" format:@"MM/dd/yyyy" datePickerMode:UIDatePickerModeDate];
    self.dateTimeItem.onChange = ^(REDateTimeItem *item){
        NSLog(@"Value: %@", item.value.description);
    };
    
    self.dateTimeItem.inlineDatePicker = YES;
    
    [section addItem:self.textItem];
    [section addItem:self.dateTimeItem];

    return section;
}

#pragma mark -
#pragma mark Button Example

- (RETableViewSection *)addButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"搜索" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        //item.title = @"Pressed!";
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
        
        [self touchSearchBtn];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
    return section;
}


-(void)touchSearchBtn{
    //商户查询
    if ( self.nSearchType == USER_QUERY) {
        
        if ((self.textSHQueqyIDItem.value == nil) &&
            (self.textSHQueqyNameItem.value == nil)&&
            (self.textSHQueqyMachineCodeItem.value == nil)
            ) {
            
            [self presentCustomDlg:@"请输入搜索条件"];
            return;
        }
        
        if ([self.textSHQueqyIDItem.value isEmptyOrWhitespace] &&
            [self.textSHQueqyNameItem.value isEmptyOrWhitespace] &&
            [self.textSHQueqyMachineCodeItem.value isEmptyOrWhitespace]
        ) {
           
            [self presentCustomDlg:@"请输入搜索条件"];
            return;
        }
        
        QuerySHInterfaceViewController *vc = [[QuerySHInterfaceViewController alloc] init];
        vc.shop_code = (self.textSHQueqyIDItem.value== nil ? @"":self.textSHQueqyIDItem.value);
        vc.shop_name= (self.textSHQueqyNameItem.value == nil ? @"":self.textSHQueqyNameItem.value);
        vc.pos_code = (self.textSHQueqyMachineCodeItem.value== nil ? @"":self.textSHQueqyMachineCodeItem.value);
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    //工作状态
    else if (self.nSearchType == WOKR_STATAS){
        if ((self.textWorkingStatusQueryIDItem.value == nil) &&
            (self.textWorkingStatusQueryNameItem.value == nil)
            ) {
            
            [self presentCustomDlg:@"请输入搜索条件"];
            return;
        }
        
        if ([self.textWorkingStatusQueryIDItem.value isEmptyOrWhitespace] &&
            [self.textWorkingStatusQueryNameItem.value isEmptyOrWhitespace]
            ) {
            
            [self presentCustomDlg:@"请输入搜索条件"];
            return;
        }
        

        QueryWorkingStatusViewController *vc = [[QueryWorkingStatusViewController alloc] init];
//        vc.shop_code = (self.textSHQueqyIDItem.value== nil ? @"":self.textSHQueqyIDItem.value);
//        vc.shop_name= (self.textSHQueqyNameItem.value == nil ? @"":self.textSHQueqyNameItem.value);
//        vc.pos_code = (self.textSHQueqyMachineCodeItem.value== nil ? @"":self.textSHQueqyMachineCodeItem.value);
        [self.navigationController pushViewController:vc animated:YES];
    }
    //库存查询
    else if (self.nSearchType == STOCK_QUERY){
        
        if ((self.textKuCunQueryIDItem.value == nil) &&
            (self.textKuCunQueryNameItem.value == nil) &&
            (self.textKuCunQueryPosCodeItem.value == nil) &&
            (self.textKuCunQueryPosStatusItem.value == nil)
            ) {
            
            [self presentCustomDlg:@"请输入搜索条件"];
            return;
        }
        
        if ([self.textKuCunQueryIDItem.value isEmptyOrWhitespace] &&
            [self.textKuCunQueryNameItem.value isEmptyOrWhitespace] &&
            [self.textKuCunQueryPosCodeItem.value isEmptyOrWhitespace] &&
            [self.textKuCunQueryPosStatusItem.value isEmptyOrWhitespace]
            ) {
            
            [self presentCustomDlg:@"请输入搜索条件"];
            return;
        }
        QueryKuCunViewController *vc = [[QueryKuCunViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (self.nSearchType == ERROR_FLOW)
    {
        CateViewController *vc = [[CateViewController alloc] init];
        
//        SHDataItem * model = [array objectAtIndex:indexPath.row];
//        vc.shopName = model.shop_name;
        vc.nType = 1;
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 0) {
        return 2;
    }
    else{
        return 1;
    } 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
