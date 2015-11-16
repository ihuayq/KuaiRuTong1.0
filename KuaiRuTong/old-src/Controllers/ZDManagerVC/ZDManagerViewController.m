//
//  ZDManagerViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/11.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "ZDManagerViewController.h"
#import "DeviceManager.h"
#import "SHAndWorkViewController.h"
#import "KuCunViewController.h"
#import "ZBJRKViewController.h"
@interface ZDManagerViewController (){
    NSArray *zdManagerArray;
    UITableView *zdTableView;
}


@end

@implementation ZDManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicData];
    [self loadBasicView];
}
/**
 *  加载基础数据
 *  @return void
 */
- (void)loadBasicData{
    zdManagerArray = [[NSArray alloc] initWithObjects:@"终端绑定",@"库存查询",@"自备机入库", nil];
}
/**
 *  加载基础视图
 *  @return void
 */
- (void)loadBasicView{
    self.view.backgroundColor = [UIColor whiteColor];
    //标题栏
    CustomNavBar *customNavBar = [[CustomNavBar alloc] initWithFrame:CGRectMake(0, 0, 320 * WIDTH_SCALE, 60 * HEIGHT_SCALE + 20)];
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"商户管理";
    customNavBar.Delegate = self;
    [self.view addSubview:customNavBar];
    //UITableView
    zdTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60 * HEIGHT_SCALE + 20, 320 * WIDTH_SCALE, 40.0 * 3 * HEIGHT_SCALE ) style:UITableViewStylePlain];
    zdTableView.scrollEnabled = NO;
    zdTableView.backgroundColor = [UIColor clearColor];
    zdTableView.rowHeight = 40.0f * HEIGHT_SCALE;
    zdTableView.dataSource = self;
    zdTableView.delegate = self;
    [self.view addSubview:zdTableView];
    
}
#pragma mark -- UITableViewDataSource 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return zdManagerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text  = zdManagerArray[indexPath.row];
    return cell;
}

#pragma mark --UITableViewDelegate 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row == 0) {
            UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
            SHAndWorkViewController *childController = [board instantiateViewControllerWithIdentifier: @"SHAndWorkVC"];
            [self.navigationController pushViewController:childController animated:YES];
        }else if (indexPath.row == 1){
            
            UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
            KuCunViewController *childController = [board instantiateViewControllerWithIdentifier: @"KuCunVC"];
            [self.navigationController pushViewController:childController animated:YES];
        }else{
            UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
            ZBJRKViewController *childController = [board instantiateViewControllerWithIdentifier: @"ZBJRKVC"];
            [self.navigationController pushViewController:childController animated:YES];
        }
}

#pragma mark -- CustomNavBarDelegate 代理方法
- (void)dealWithBackButtonClickedMethod{
    [self.navigationController popViewControllerAnimated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
