//
//  QueryKuCunViewController.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/26.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "QueryKuCunViewController.h"
#import "QueryKuCunTableViewCell.h"
#import "KuCunInfoViewController.h"

@interface QueryKuCunViewController ()<UITableViewDataSource,UITableViewDelegate,KuCuDataServiceDelegate>{
    
    NSMutableArray *dataArray;
    
}

@property(nonatomic,strong) UITableView *tableView;
@end

@implementation QueryKuCunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"库存查询结果";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth,44*8 +10 ) style:UITableViewStylePlain];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = 44.0;
    [self.view addSubview:self.tableView];
    
    [self displayOverFlowActivityView:@"加载数据"];
    [self.service beginUploadByShopName:self.shop_name withShopCode:self.shop_code andPosCode:self.pos_code andPosStatus:self.pos_status];
}


- (KuCuDataService *)service
{
    if (!_service) {
        _service = [[KuCuDataService alloc] init];
        _service.delegate = self;
    }
    return _service;
}


-(void)getSearchServiceResult:(KuCuDataService *)service
                       Result:(BOOL)isSuccess_
                     errorMsg:(NSString *)errorMsg;
{
    
    [self removeOverFlowActivityView];
    
    if (isSuccess_ == YES) {
        dataArray = self.service.responseArray;
        [self.tableView reloadData];
    }

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * dentifier = @"cell";
    QueryKuCunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[QueryKuCunTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier];
    }
    cell.model = [dataArray objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KuCunInfoViewController *vc = [[KuCunInfoViewController alloc] init];
    vc.index = indexPath.row;
    vc.model = [dataArray objectAtIndex:indexPath.row];
    
    vc.block = ^(int index){
        [dataArray removeObjectAtIndex:index];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
