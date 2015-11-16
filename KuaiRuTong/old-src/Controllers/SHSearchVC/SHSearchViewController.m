//
//  SHSearchViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/12.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "SHSearchViewController.h"
#import "SHSearchCell.h"
#import "SHDetailViewController.h"
@interface SHSearchViewController (){
    UITableView *searchTableView;
}

@end

@implementation SHSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicView];
    // Do any additional setup after loading the view.
}

/**
 *  加载基础视图
 *  @return
 */
- (void)loadBasicView{
    //标题栏
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"商户查询结果";
    
    //UITableView
    searchTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 0, 0, 0) CellHeight:67.0 ScrollEnabled:YES];
    searchTableView.frame = CGRectMake(0, 60 * HEIGHT_SCALE + 20, 320 * WIDTH_SCALE, HEIGHT - 60 * HEIGHT_SCALE - 20 );
    searchTableView.dataSource = self;
    searchTableView.delegate   = self;
    [self.view addSubview:searchTableView];
}

#pragma mark -- UITableViewDataSource 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SHSearchCell";
    SHSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[SHSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.shmcLabel.text = [NSString stringWithFormat:@"商户名称:%@",_resultsArray[indexPath.row][@"mercName"] ];
    cell.shbhLabel.text = _resultsArray[indexPath.row][@"mercNum"];
    cell.shlbLabel.text = _resultsArray[indexPath.row][@"mercMcc"];
    cell.shztLabel.text = _resultsArray[indexPath.row][@"mercSta"];
    return cell;
}
#pragma mark -- UITableViewDelegate 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    SHDetailViewController *childController = [board instantiateViewControllerWithIdentifier: @"SHDetailVC"];
    NSLog(@"resultarray -== %@",_resultsArray);
    childController.resultsDic = _resultsArray[indexPath.row];
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
