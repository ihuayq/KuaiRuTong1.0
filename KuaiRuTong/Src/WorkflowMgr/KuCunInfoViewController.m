//
//  KuCunInfoViewController.m
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/26.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "KuCunInfoViewController.h"
#import "RETableViewManager.h"
#import "RETableViewOptionsController.h"

@interface KuCunInfoViewController ()<RETableViewManagerDelegate,KuCuDataServiceDelegate>{
    UITableView *tableView;
}

//@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) RETableViewManager *manager;
@property (strong, nonatomic) RETableViewSection *basicControlsSection;
@property (strong, nonatomic) RETableViewSection *buttonSection;

////库存查询
//@property (strong, readwrite, nonatomic) RETextItem *textKuCunInfoMerIDItem;
//@property (strong, readwrite, nonatomic) RETextItem *textKuCunInfoMerNameItem;
//@property (strong, readwrite, nonatomic) RETextItem *textKuCunInfoNetpointIDItem;
//@property (strong, readwrite, nonatomic) RETextItem *textKuCunInfoNetpointNameItem;
//@property (strong, readwrite, nonatomic) RETextItem *textKuCunInfoPosCodeItem;
//@property (strong, readwrite, nonatomic) RETextItem *textKuCunInfoPosStatusItem;
//@property (strong, readwrite, nonatomic) RETextItem *textKuCunInfoKuncunItem;
//@property (strong, readwrite, nonatomic) RETextItem *textKuCunInfoBindStatusItem;

@end

@implementation KuCunInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
     self.navigation.title =@"库存详情";
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT) style:UITableViewStyleGrouped];
    tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;

    [self.view addSubview:tableView];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:tableView delegate:self];
    
    self.basicControlsSection = [self addBaseSection];
    self.buttonSection = [self addButton];
}

- (RETableViewSection *)addBaseSection{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"搜索条件"];
    [self.manager addSection:section];
    
    [section addItem:[NSString stringWithFormat:@"商户编号:%@",self.model.shop_id]];
    [section addItem:[NSString stringWithFormat:@"商户名称:%@",self.model.shop_name]];
    [section addItem:[NSString stringWithFormat:@"网点编号:%@",self.model.netpoint_id]];
    [section addItem:[NSString stringWithFormat:@"网点名称:%@",self.model.netpoint_name]];
    [section addItem:[NSString stringWithFormat:@"机身序列号:%@",self.model.machine_code]];
    [section addItem:[NSString stringWithFormat:@"机身状态:%@",self.model.machine_status]];
    [section addItem:[NSString stringWithFormat:@"库存状态:%@",self.model.kucun_status]];
    [section addItem:[NSString stringWithFormat:@"绑定状态:%@",self.model.bind_status]];
    
    return section;
}


- (RETableViewSection *)addButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"解除绑定" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        //item.title = @"Pressed!";
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
        
        //[self touchSearchBtn];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
    return section;
}


- (KuCuDataService *)service
{
    if (!_service) {
        _service = [[KuCuDataService alloc] init];
        _service.delegate = self;
    }
    return _service;
}


-(void)deleteBindServiceResult:(KuCuDataService *)service
                       Result:(BOOL)isSuccess_
                     errorMsg:(NSString *)errorMsg;
{
    
    [self removeOverFlowActivityView];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    //需要回调刷新上一级界面
    if (self.block) {
        self.block(self.index);
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
