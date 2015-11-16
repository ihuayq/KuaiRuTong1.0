//
//  UserCenterViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/9.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "UserCenterViewController.h"
#import "VersionDetailViewController.h"
#import "RWDBManager.h"
#import "FileManager.h"
#import "UIImageView+WebCache.h"

@interface UserCenterViewController (){
   
    NSArray *detailArray;
    UITableView *userTableView ;
    UIImageView *photoImageView;
    UILabel *telephoneLabel;
}

@end

@implementation UserCenterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadBasicView];
    [self loadBasicData];
}

/**
 *  加载基础数据
 *  @return void
 */
- (void)loadBasicData{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfoDic = [userDefaults objectForKey:@"UserInfoData"];
    customNavBar.titleLabel.text = userInfoDic[@"name"];
    telephoneLabel.text = userInfoDic[@"phoneNo"];
    
    
    detailArray =[[NSArray alloc] initWithObjects:@"客服电话",@"版本信息", nil];
    [userTableView reloadData];
}
/**
 *  加载基础视图
 *  @return void
 */
- (void)loadBasicView{
    scrollView.frame = CGRectMake(0, 20 + 60 * HEIGHT_SCALE, 320 * WIDTH_SCALE, HEIGHT - 60 * HEIGHT_SCALE - 20 - 49);
    customNavBar.backView.hidden = YES;
    
    //头像
    photoImageView = [ViewModel createImageViewWithFrame:CGRectMake(100, 50, 120, 120) ImageName:nil];
    photoImageView.image = [UIImage imageNamed:@"photo_icon_background"];
   [scrollView addSubview:photoImageView];
    
    //手机号码
    telephoneLabel = [ViewModel createLabelWithFrame:CGRectMake(0, 180, 320, 21) Font:nil Text:nil];
    telephoneLabel.font = [UIFont systemFontOfSize:12.0];
    telephoneLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:telephoneLabel];

    //UITableView
    userTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 210, 320, 80) CellHeight:40.0 ScrollEnabled:NO];
    userTableView.dataSource = self;
    userTableView.delegate = self;
    [scrollView addSubview:userTableView];
    
    //注销按钮
    UIButton *logoutButton = [ViewModel createButtonWithFrame:CGRectMake(0, 380, 320, 50) ImageNormalName:nil ImageSelectName:nil Title:@"退出登录" Target:self Action:@selector(logoutButtonClicked)];
    logoutButton.backgroundColor = RED_COLOR2;
    [scrollView addSubview:logoutButton];
    
    [scrollView setContentSize:CGSizeMake(0, 430)];

}

#pragma mark -- private Methods
- (void)logoutButtonClicked{
    [self.navigationController popToRootViewControllerAnimated:NO];
}


- (void)btnClicked{
    VersionDetailViewController *versionDetailVC = [[VersionDetailViewController alloc] init];
    [self.navigationController pushViewController:versionDetailVC animated:NO];
}  


#pragma mark -- UITableViewDataSource 代理方法 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return detailArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
     
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12.0];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    cell.textLabel.text  = detailArray[indexPath.row];
    return cell;
}
#pragma mark --UITableViewDelegate 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"是否直接拨打客服电话:010-3862927" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
        [alertView show];
    }else{
        UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
        VersionDetailViewController *childController = [board instantiateViewControllerWithIdentifier: @"VersionDetailVC"];
        [self.navigationController pushViewController:childController animated:YES];
    }
}
#pragma mark -- UIAlertViewDelegate 代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://13701051410"]];//打电话  
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
