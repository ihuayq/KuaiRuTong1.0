//
//  KuCunDetailViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/16.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "KuCunDetailViewController.h"
#import "KuCunSearchCell.h"
#import "KuCunDescViewController.h"
#import "SearchKCRequest.h"
@interface KuCunDetailViewController (){
    NSMutableArray *selectArray;
    UITableView *kuCunTableView;
    NSArray *kuCunDataArray;
}

@end

@implementation KuCunDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self searchKuCunData];
}
- (void)searchKuCunData{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *searchKuCunDic = [userDefaults objectForKey:@"SouSuoKuCun"];
     NSString *shopNameString = searchKuCunDic[@"shxm"];
    NSString *shopCodeString = searchKuCunDic[@"shbh"];
    NSString *machineCodeString = searchKuCunDic[@"xlh"];
    NSString *stateString = searchKuCunDic[@"state"];
    
    
    hud_SuperVC.mode = MBProgressHUDModeIndeterminate;
    hud_SuperVC.labelText = @"查询中...";
    [hud_SuperVC show:YES];
    SearchKCRequest *searchKCRequest = [[SearchKCRequest alloc] init];
    [searchKCRequest searchKCShopName:shopNameString AndShopCode:shopCodeString AndMachineCode:machineCodeString AndBangDingState:stateString completionBlock:^(NSDictionary *seachKCDic) {
        if([seachKCDic [@"status"] intValue] == 2){
            //没有网络
            hud_SuperVC.labelText = seachKCDic[@"Info"];
        }else if ([seachKCDic[@"status"] intValue] == 1){
            //查询失败
            hud_SuperVC.labelText = seachKCDic[@"Info"];
        }else{
            //查询成功
            hud_SuperVC.labelText = seachKCDic[@"Info"];
            kuCunDataArray = [[NSArray alloc] initWithArray:seachKCDic[@"kunCunData"]];
        }
        [hud_SuperVC hide:YES afterDelay:1];
        [kuCunTableView reloadData];
        NSLog(@"%@",seachKCDic);
        
        
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadBasicView];
}


- (void)loadBasicView{
   
    
    //标题栏
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"库存查询列表";
    customNavBar.Delegate = self;
    [self.view addSubview:customNavBar];
    
    kuCunTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 0, 0, 0) CellHeight:80.0 ScrollEnabled:YES];
    kuCunTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    kuCunTableView.frame = CGRectMake(0, -20, 320 * WIDTH_SCALE, HEIGHT - 60 * HEIGHT_SCALE - 20 );
    kuCunTableView.dataSource = self;
    kuCunTableView.delegate = self;
    [scrollView addSubview:kuCunTableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return kuCunDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"KuCunDetailCell";
    KuCunSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[KuCunSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary *oneDic = kuCunDataArray[indexPath.row];
    NSString *shmcString = oneDic[@"mercName"];
    NSString *wdmcString = [[oneDic[@"shop"] objectAtIndex:0] objectForKey:@"shopName"];
    NSString *machineCodeString = [[[[oneDic[@"shop"] objectAtIndex:0] objectForKey:@"term"] objectAtIndex:0] objectForKey:@"termNo"];
    cell.shmcLabel.text = shmcString;
    cell.wdmcLabel.text = wdmcString;
    cell.machineCodeLabel.text = machineCodeString;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    KuCunDescViewController *childController = [board instantiateViewControllerWithIdentifier: @"KuCunDescVC"];
    childController.kuCunDescData = kuCunDataArray[indexPath.row];
    [self.navigationController pushViewController:childController animated:YES];
    
}


#pragma mark -- CustomNavBarDelegate
- (void)dealWithBackButtonClickedMethod{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
