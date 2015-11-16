//
//  SHDetailViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/12.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "SHDetailViewController.h"
#import "DeviceManager.h"
#import "ZDBDViewController.h"

@interface SHDetailViewController (){
    UITableView *shTableView;
    NSArray *shArray;
    NSArray *shInfosArray;
    UITableView *wdTableView;
}

@end

@implementation SHDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicData];
    [self loadBasicView];
}

- (void)loadBasicData{
    shArray = [[NSArray alloc] initWithObjects:@"商户编号",@"商户名称",@"商户类别",@"商户状态", nil];
    NSString *bianhao = _resultsDic[@"mercNum"] == nil ? @"" : _resultsDic[@"mercNum"];
    NSString *leibie  = _resultsDic[@"mercMcc"] == nil ? @"" : _resultsDic[@"mercMcc"];
    NSString *zhuangtai = _resultsDic[@"mercSta"] == nil ? @"" : _resultsDic[@"mercSta"];
    NSString *mingcheng = _resultsDic[@"mercName"] == nil ? @"" : _resultsDic[@"mercName"];
    shInfosArray = [[NSArray alloc] initWithObjects:bianhao,mingcheng,leibie,zhuangtai, nil];
    
    [shTableView reloadData];
}
/**
 *  加载基础视图
 *  @return
 */
- (void)loadBasicView{
    //标题栏
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"商户详情";
    
    //商户
    shTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 0, 0, 0) CellHeight:44.0 ScrollEnabled:NO];
    shTableView.frame = CGRectMake(0 , 20 + 60 *HEIGHT_SCALE ,320 * WIDTH_SCALE,44 * shArray.count * HEIGHT_SCALE);
    shTableView.dataSource = self;
    shTableView.delegate   = self;
    [self.view addSubview:shTableView];
    //网点
    wdTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 0, 0, 0) CellHeight:90.0 ScrollEnabled:YES];
    wdTableView.frame = CGRectMake(0 , 20 + 60 * HEIGHT_SCALE + 44 *shArray.count * HEIGHT_SCALE,320 * WIDTH_SCALE,HEIGHT - (60 + 44 *shArray.count )* HEIGHT_SCALE );
    wdTableView.dataSource = self;
    wdTableView.delegate   = self;
    [self.view addSubview:wdTableView];
    

}

#pragma mark -- UITableViewDataSource 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == shTableView) {
        return shArray.count;
    }else{
        return [[_resultsDic objectForKey:@"shop"] count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == shTableView) {
        static NSString *cellIdentifier = @"Cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = shArray[indexPath.row];
        cell.detailTextLabel.text = shInfosArray[indexPath.row];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        return cell;
    }else{
        static NSString *cellIdentifier = @"Cell2";
        WDSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[WDSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.Delegate = self;
        }
        NSDictionary *cell2InfoDictionary = [[_resultsDic objectForKey:@"shop"] objectAtIndex:indexPath.row];
        cell.nameLabel.text = cell2InfoDictionary[@"shopName"];
        cell.addressLabel.text = cell2InfoDictionary[@"shopAddress"];
        return cell;
    }
    
}

#pragma mark -- CustomNavBarDelegate 代理方法
- (void)addButtonDelegate{
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    ZDBDViewController *childController = [board instantiateViewControllerWithIdentifier: @"ZDBDVC"];
    [self.navigationController pushViewController:childController animated:YES];
}

#pragma mark -- CustomNavBarDelegate 代理方法
- (void)dealWithBackButtonClickedMethod{
    [self.navigationController popViewControllerAnimated:YES];
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
