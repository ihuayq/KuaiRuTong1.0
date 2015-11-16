//
//  KuCunDescViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/9/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "KuCunDescViewController.h"
#import "RemoveBindingRequest.h"
@interface KuCunDescViewController (){
    UITableView *descTableView;
    UIButton *jieBangBtn;
    NSArray *descArray;
    NSArray *descInfoArray;
    NSString *machineCodeString;
}

@end

@implementation KuCunDescViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self loadBasicData];
    [self loadBasicView];
   
}
/**
 *  加载基础数据
 */
- (void)loadBasicData{
    descArray = [[NSArray alloc] initWithObjects:@"商户编号",@"商户名称",@"网点编号",@"网点名称",@"机身序列号",@"机具状态",@"绑定状态", nil];
    NSString *shbhString = _kuCunDescData[@"mercNum"];
    NSString *shmcString = _kuCunDescData[@"mercName"];
    NSDictionary *wangDianDic = [_kuCunDescData[@"shop"] objectAtIndex:0];
    NSString *wdbhString = wangDianDic[@"shopNum"];
    NSString *wdmcString = wangDianDic[@"shopName"];
    NSDictionary *machineDic = [wangDianDic[@"term"] objectAtIndex:0];
    NSString *machineStateString = machineDic[@"termStatus"];
    machineCodeString = machineDic[@"termNo"];
    NSString *bangDingString = machineDic[@"boundStatus"];
    descInfoArray = [[NSArray alloc] initWithObjects:shbhString,shmcString,wdbhString,wdmcString,machineCodeString,machineStateString,bangDingString, nil];
    [descTableView reloadData];
}
/**
 *  加载基础视图
 */
- (void)loadBasicView{
    //标题栏
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"库存查询详情";
    customNavBar.Delegate = self;
    [self.view addSubview:customNavBar];
    
    descTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 0, 0, 0) CellHeight:30.0 ScrollEnabled:NO];
    descTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    descTableView.backgroundColor = [UIColor redColor];
    descTableView.frame = CGRectMake(0, -20, 320 * WIDTH_SCALE, 30 * descArray.count );
    descTableView.dataSource = self;
    descTableView.delegate = self;
    [scrollView addSubview:descTableView];
    
    //商户查询按钮
    jieBangBtn = [ViewModel createButtonWithFrame:CGRectMake(0, 327, 320, 30) ImageNormalName:nil ImageSelectName:nil Title:@"解除绑定" Target:self Action:@selector(jieBangBtnClickedMethod)];
    jieBangBtn.backgroundColor = RED_COLOR1;
    [scrollView addSubview:jieBangBtn];

}
- (void)jieBangBtnClickedMethod{
    machineCodeString = @"re4553";
    
    jieBangBtn.backgroundColor = [UIColor lightGrayColor];
    jieBangBtn.userInteractionEnabled = NO;
    hud_SuperVC.mode = MBProgressHUDModeIndeterminate;
    hud_SuperVC.labelText = @"解绑中...";
    [hud_SuperVC show:YES];
    RemoveBindingRequest *removeBindingRequest = [[RemoveBindingRequest alloc] init];
    [removeBindingRequest removeBindingMachineCode:machineCodeString completionBlock:^(NSDictionary *removeBindingDic) {
        if([removeBindingDic [@"status"] intValue] == 2){
            //没有网络
            hud_SuperVC.labelText = removeBindingDic[@"Info"];
        }else if ([removeBindingDic[@"status"] intValue] == 1){
            //解绑失败
            hud_SuperVC.labelText = removeBindingDic[@"Info"];
        }else{
            //解绑成功
            hud_SuperVC.labelText = removeBindingDic[@"Info"];
           
        }
        [hud_SuperVC hide:YES afterDelay:1];
        
        NSLog(@"%@",removeBindingDic);
    }];
    
}
- (void)hudWasHidden:(MBProgressHUD *)hud{
    if ([hud.labelText isEqualToString:@"解绑成功"]) {
         [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return descArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"KuCunDescCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = descArray[indexPath.row];
    cell.detailTextLabel.text = descInfoArray[indexPath.row];
    return cell;
}


#pragma mark -- CustomNavBarDelegate
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
