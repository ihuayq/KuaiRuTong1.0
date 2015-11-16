//
//  SHManagerViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/11.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "SHManagerViewController.h"
#import "DeviceManager.h"
#import "SHAndWorkViewController.h"
#import "SHAndWork1ViewController.h"
#import "QuestionSHViewController.h"
#import "PendSHViewController.h"
@interface SHManagerViewController (){
    NSArray *shManagerArray;
    UITableView *shTableView;
}

@end

@implementation SHManagerViewController

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
    shManagerArray = [[NSArray alloc] initWithObjects:@"商户查询",@"工作查询",@"问题工作流程",@"待处理流程", nil];
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
    shTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60 * HEIGHT_SCALE + 20, 320 * WIDTH_SCALE, 40.0 * 4 * HEIGHT_SCALE ) style:UITableViewStylePlain];
    shTableView.scrollEnabled = NO;
    shTableView.backgroundColor = [UIColor clearColor];
    shTableView.rowHeight = 40.0f * HEIGHT_SCALE;
    shTableView.dataSource = self;
    shTableView.delegate = self;
    [self.view addSubview:shTableView];

}
#pragma mark -- UITableViewDataSource 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return shManagerArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text  = shManagerArray[indexPath.row];
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
        SHAndWork1ViewController *childController = [board instantiateViewControllerWithIdentifier: @"SHAndWork1VC"];
        [self.navigationController pushViewController:childController animated:YES];
    }else if (indexPath.row == 2){
        UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
        QuestionSHViewController *childController = [board instantiateViewControllerWithIdentifier: @"QuestionSHVC"];
        [self.navigationController pushViewController:childController animated:YES];
    }else if (indexPath.row == 3){
        
        UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
        PendSHViewController *childController = [board instantiateViewControllerWithIdentifier: @"PendSHVC"];
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
