//
//  UserCenterViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/9.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "UserCenterViewController.h"
#import "VersionDetailViewController.h"

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
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.title = @"用户中心";
    
    detailArray =[[NSArray alloc] initWithObjects:@"客服电话",@"版本信息", nil];
//    [userTableView reloadData];
    //头像
    photoImageView = [[UIImageView alloc ]initWithFrame:CGRectMake(MainWidth/2 - 60 , NAVIGATION_OUTLET_HEIGHT + 10, 120, 120)];
    photoImageView.image = [UIImage imageNamed:@"photo_icon_background"];
    [self.view addSubview:photoImageView];

    //手机号码
    telephoneLabel = [[UILabel alloc ]initWithFrame:CGRectMake(0, photoImageView.origin.y + photoImageView.size.height, MainWidth, 21)];
    telephoneLabel.font = [UIFont systemFontOfSize:12.0];
    telephoneLabel.textAlignment = NSTextAlignmentCenter;
    NSDictionary *userInfoDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfoData"];
    telephoneLabel.text = userInfoDic[@"phoneNo"];
    [self.view addSubview:telephoneLabel];

    //UITableView
    userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, telephoneLabel.origin.y + telephoneLabel.size.height +10, MainWidth, 80) style:UITableViewStylePlain];
    userTableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    userTableView.dataSource = self;
    userTableView.delegate = self;
    [self.view addSubview:userTableView];

    
    UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth/2 - MainWidth/4, MainHeight - 48 - 44 -20, MainWidth/2, 40)];
    [logoutButton addTarget:self action:@selector(logoutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    logoutButton.backgroundColor = RED_COLOR2;
    logoutButton.layer.masksToBounds = YES;
    [logoutButton.layer setCornerRadius:logoutButton.frame.size.height/2.0f];
    [self.view addSubview:logoutButton];
}

#pragma mark -- private Methods
- (void)logoutButtonClicked{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark -- UITableViewDataSource 代理方法 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return detailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        //cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text  = detailArray[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.detailTextLabel.text=@"010-3862927";
    }
    else if ( indexPath.row == 1 ){
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"V%@",version];
    }
   
    
    return cell;
}

#pragma mark --UITableViewDelegate 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"是否直接拨打客服电话:010-3862927" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
        [alertView show];
    }else{
        VersionDetailViewController *childController = [[VersionDetailViewController alloc]init];;
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
