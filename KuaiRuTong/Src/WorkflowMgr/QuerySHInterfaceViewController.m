//
//  QuerySHInterfaceViewController.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/25.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "QuerySHInterfaceViewController.h"
#import "SHSearchDataService.h"
#import "SHSearchResultCell.h"
#import "SHResultData.h"
#import "SHDetailInfoViewController.h"

@interface QuerySHInterfaceViewController ()<UITableViewDataSource,UITableViewDelegate,SHSearchDataServiceDelegate>{
    
    NSMutableArray *dataArray;
    
}

@property(nonatomic,strong) UITableView *tableView;
@end

@implementation QuerySHInterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"商户查询结果";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth,MainHeight - SCREEN_BODY_HEIGHT ) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
    //self.tableView.scrollEnabled = YES;
    self.tableView.sectionHeaderHeight = 0.1;
    //self.tableView.sectionFooterHeight = 0.1;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    [self.view addSubview:self.tableView];
    
    [self displayOverFlowActivityView:@"加载商户数据"];
    [self.service beginUploadByShopName:self.shop_name withShopCode:self.shop_code andPosCode:self.pos_code];
}


- (SHSearchDataService *)service
{
    if (!_service) {
        _service = [[SHSearchDataService alloc] init];
        _service.delegate = self;
    }
    return _service;
}


-(void)getSearchServiceResult:(SHSearchDataService *)service
                       Result:(BOOL)isSuccess_
                     errorMsg:(NSString *)errorMsg{
    
    [self removeOverFlowActivityView];
    
    dataArray = self.service.responseArray;
    [self.tableView reloadData];
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
    SHSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[SHSearchResultCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier];
    }
    cell.model = [dataArray objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHDetailInfoViewController *vc = [[SHDetailInfoViewController alloc] init];
    SHResultData *data = [dataArray objectAtIndex:indexPath.row];
    vc.strMerNo = data.mercNum;

    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
