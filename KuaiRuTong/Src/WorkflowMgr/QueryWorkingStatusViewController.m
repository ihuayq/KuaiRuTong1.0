//
//  QueryWorkingStatusViewController.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/25.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "QueryWorkingStatusViewController.h"
#import "TimeLineViewControl.h"
#import "RETableViewManager.h"
#import "RETableViewOptionsController.h"

@interface QueryWorkingStatusViewController (){
    UITableView *tableView;
}

@property (strong, nonatomic) RETableViewManager *manager;

@property (strong, readwrite, nonatomic) RETextItem *statusItem;
@property (strong, readwrite, nonatomic) RETextItem *shopIDItem;
@property (strong, readwrite, nonatomic) RETextItem *shopNameItem;
@property (strong, readwrite, nonatomic) RETextItem *processIDItem;

@end

@implementation QueryWorkingStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    self.navigation.title = @"查询结果";
    
    
    

    
    [self displayOverFlowActivityView:@"加载数据"];
    [self.service beginUploadByShopName:self.shop_name withShopCode:self.shop_code];
    //[section addItem:timeline];
}


-(void)getSearchServiceResult:(WorkingStatusDataService *)service
                       Result:(BOOL)isSuccess_
                     errorMsg:(NSString *)errorMsg{
    
    [self removeOverFlowActivityView];
    
    if (isSuccess_ == YES) {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, 80*2+20) style:UITableViewStyleGrouped];
        tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 80;
        [self.view addSubview:tableView];
        
        self.manager = [[RETableViewManager alloc] initWithTableView:tableView delegate:self];
        
        
        RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@""];
        section.headerHeight = 0.1;
        section.footerHeight = 0.1;
        [self.manager addSection:section];
        
        [section addItem:[NSString stringWithFormat:@"表单状态 %@",self.service.formStatus]];
        [section addItem:[NSString stringWithFormat:@"商户编号 %@",self.service.mercNum]];
        [section addItem:[NSString stringWithFormat:@"商户名 %@",self.service.mercName]];
        [section addItem:[NSString stringWithFormat:@"任务流水号 %@",self.service.processId]];
        
        NSString *dataOpera = [NSString stringWithFormat:@"运营审核 %@",self.service.operation];
        NSString *dataSales = [NSString stringWithFormat:@"销售 %@",self.service.sales];
        NSString *dataInrecodr = [NSString stringWithFormat:@"运营补录 %@",self.service.inrecodr];
        NSString *dataSuccess = [NSString stringWithFormat:@"审核通过 %@",self.service.success];
        
        NSArray *times = @[@"sun",@"mon",@"tue",@"wed"];
        NSArray *descriptions = @[dataOpera,dataSales,dataInrecodr,dataSuccess];
        TimeLineViewControl *timeline = [[TimeLineViewControl alloc] initWithTimeArray:times
                                                               andTimeDescriptionArray:descriptions
                                                                      andCurrentStatus:self.service.pos
                                                                              andFrame:CGRectMake(10, NAVIGATION_OUTLET_HEIGHT + 180 + 10, MainWidth - 30, 200)];
        //timeline.center = self.view.center;
        [self.view addSubview:timeline];
    }
}

- (WorkingStatusDataService *)service
{
    if (!_service) {
        _service = [[WorkingStatusDataService alloc] init];
        _service.delegate = self;
    }
    return _service;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
