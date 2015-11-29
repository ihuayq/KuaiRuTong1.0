//
//  SHDetailInfoViewController.m
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/29.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "SHDetailInfoViewController.h"
#import "RETableViewManager.h"
#import "RETableViewOptionsController.h"
#import "SHResultData.h"


@interface SHDetailInfoViewController ()<RETableViewManagerDelegate,SHSearchDataServiceDelegate>{
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

@implementation SHDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    self.navigation.title =@"库存详情";
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT) style:UITableViewStyleGrouped];
    tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:tableView];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:tableView delegate:self];
    
    [self displayOverFlowActivityView:@"加载数据"];
    //[self.service beginSeachDetailByPosCode:self.model.machine_code];
    
}

- (RETableViewSection *)addBaseSection{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@""];
    [self.manager addSection:section];
    [section addItem:[NSString stringWithFormat:@"商户编号:%@",self.service.detailData.mercNum]];
    [section addItem:[NSString stringWithFormat:@"商户名称:%@",self.service.detailData.mercName]];
    [section addItem:[NSString stringWithFormat:@"网点状态:%@",self.service.detailData.mercSta]];


    
//    NSMutableArray *shopArray = [[NSMutableArray alloc]init];
    NSArray *dataArray = [[NSArray alloc] initWithArray:self.service.detailData.shopArray];
    for (NSDictionary *mod in dataArray) {
        RETableViewSection *sectionOne = [RETableViewSection sectionWithHeaderTitle:@"网点信息"];
        [self.manager addSection:sectionOne];
        
        //网点名称，可以增机器
        RETableViewItem *item = [RETableViewItem itemWithTitle:[NSString stringWithFormat:@"网点名称:%@",self.service.detailData.mercNum]];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
        [button setFrame:CGRectMake(0, 0, 60, 30)];
        [button addTarget:self action:@selector(touchAddButton) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"增机" forState:UIControlStateNormal];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:button.frame.size.height/2.0f];
        item.accessoryView = button;
        
        [section addItem:[NSString stringWithFormat:@"网点地址:%@",self.service.detailData.mercName]];
    }
    
//        SHShopData *shopData = [[SHShopData alloc]init];
//        shopData.shopAddress = mod[@"shopAddress"];
//        shopData.shopName = mod[@"shopName"];
//        shopData.coun = mod[@"coun"];
//        shopData.city = mod[@"city"];
//        shopData.provn = mod[@"provn"];
//        shopData.serialNos = mod[@"serialNos"];
//        [shopArray addObject:shopData];
    
    return section;
}


- (SHSearchDataService *)service
{
    if (!_service) {
        _service = [[SHSearchDataService alloc] init];
        _service.delegate = self;
    }
    return _service;
}


-(void)getSHDetailDataServiceResult:(SHSearchDataService *)service
                             Result:(BOOL)isSuccess_
                           errorMsg:(NSString *)errorMsg{
    
    [self removeOverFlowActivityView];
    
    self.basicControlsSection = [self addBaseSection];

    [tableView reloadData];
    
}




//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    KuCunInfoViewController *vc = [[KuCunInfoViewController alloc] init];
//    vc.index = indexPath.row;
//    vc.model = [dataArray objectAtIndex:indexPath.row];
//    
//    vc.block = ^(int index){
//        [dataArray removeObjectAtIndex:index];
//        [self.tableView reloadData];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
