//
//  WorkSearchViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/15.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "WorkSearchViewController.h"
#import "DeviceManager.h"
@interface WorkSearchViewController (){
    NSArray *workArray;
    NSArray *workInfoArray;
    NSArray *biaoDanArray;
    NSArray *biaoDanStateArray;
    NSArray *biaoDanDateArray;
    UITableView *workTableView;
    UITableView *biaoDanTableView;
}

@end

@implementation WorkSearchViewController

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
    workArray = [[NSArray alloc] initWithObjects:@"任务流水号",@"处理状态",@"商户编号",@"商户名称", nil];
    NSString *swlshString = _searchWorkData[@"processId"] == nil ? @"" :_searchWorkData[@"processId"];
    NSString *clztString = _searchWorkData[@"proceStatus"] == nil ? @"" :_searchWorkData[@"proceStatus"];
    NSString *shbhString =  _searchWorkData[@"mercNum"] == nil ? @"" :_searchWorkData[@"mercNum"];
    NSString *shmcString = _searchWorkData[@"mercName"] == nil ? @"" :_searchWorkData[@"mercName"];
    workInfoArray = [[NSArray alloc] initWithObjects:swlshString,clztString,shbhString,shmcString, nil];
    [workTableView reloadData];
    
    
    biaoDanArray = [[NSArray alloc] initWithObjects:@"销售",@"运营补录",@"运营审核",@"审核通过",@"成功" ,nil];
    
    NSString *xsDateString = [[_searchWorkData objectForKey:@"date"] objectForKey:@"sales"];
    NSString *yyblDateString = [[_searchWorkData objectForKey:@"date"] objectForKey:@"inrecodr"];
    NSString *yyshDateString = [[_searchWorkData objectForKey:@"date"] objectForKey:@"operation"];
    NSString *shtgDateString = [[_searchWorkData objectForKey:@"date"] objectForKey:@"success"];
    NSString *cgDateString = [[_searchWorkData objectForKey:@"date"] objectForKey:@"success"];
    biaoDanDateArray = [[NSArray alloc] initWithObjects:xsDateString,yyblDateString,yyshDateString,shtgDateString,cgDateString, nil];
    
    NSString *stateString = [_searchWorkData objectForKey:@"formStatus"];
    NSString *xsStateString = @"no";
    NSString *yyblStateString = @"no";
    NSString *yyshStateString = @"no";
    NSString *shtgStateString = @"no";
    NSString *cgStateString = @"no";
    if ([stateString isEqualToString:@"sales"]) {
       xsStateString = @"yes";
       yyblStateString = @"no";
       yyshStateString = @"no";
       shtgStateString = @"no";
       cgStateString = @"no";
        
    }else if ([stateString isEqualToString:@"inrecodr"]){
        xsStateString = @"yes";
        yyblStateString = @"yes";
        yyshStateString = @"no";
        shtgStateString = @"no";
        cgStateString = @"no";
        
    }else if ([stateString isEqualToString:@"operation"]){
        xsStateString = @"yes";
        yyblStateString = @"yes";
        yyshStateString = @"yes";
        shtgStateString = @"no";
        cgStateString = @"no";
        
    }else if ([stateString isEqualToString:@"success"]){
        xsStateString = @"yes";
        yyblStateString = @"yes";
        yyshStateString = @"yes";
        shtgStateString = @"yes";
        cgStateString = @"yes";
        
    }
    biaoDanStateArray = [[NSArray alloc] initWithObjects:xsStateString,yyblStateString,yyshStateString,shtgStateString,cgStateString, nil];
    
    [biaoDanTableView reloadData];
}
/**
 *  加载基础视图
 *  @return void
 */
- (void)loadBasicView{
    //标题栏
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"工作查询";
 
    workTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 0, 0, 0) CellHeight:40.0 ScrollEnabled:NO];
    workTableView.frame = CGRectMake(0, 5 * HEIGHT_SCALE, 320 * WIDTH_SCALE,  40 * workArray.count * HEIGHT_SCALE);
    workTableView.dataSource = self;
    workTableView.delegate = self;
    [scrollView addSubview:workTableView];
    
    //表单状态
    UILabel *biaoDanStateLabel = [ViewModel createLabelWithFrame:CGRectMake(0, 0, 0, 0) Font:[UIFont systemFontOfSize:20] Text:@"表单状态"];
    biaoDanStateLabel.frame = CGRectMake(15,  15 * HEIGHT_SCALE + 40 * workArray.count * HEIGHT_SCALE, 320 * WIDTH_SCALE,  40 * HEIGHT_SCALE);
    [scrollView addSubview:biaoDanStateLabel];
    //分割线
    UIView *line = [ViewModel createViewWithFrame:CGRectMake(0, 0, 0, 0)];
    CGFloat lineHeight = 15 * HEIGHT_SCALE + 40 * workArray.count * HEIGHT_SCALE + 40 * HEIGHT_SCALE;
    line.frame = CGRectMake(10,  lineHeight,  300 * WIDTH_SCALE,  1 * HEIGHT_SCALE);
    line.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:line];
    
    //竖线
    UIView *line2 = [ViewModel createViewWithFrame:CGRectMake(0, 0, 0, 0)];
    line2.frame = CGRectMake(32 * WIDTH_SCALE, (lineHeight + 20 * HEIGHT_SCALE), 1 * WIDTH_SCALE, (50* 4 *HEIGHT_SCALE));
    line2.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:line2];
    
    for (int i = 0; i < 5; i ++) {
        UIView *dianV = [ViewModel createViewWithFrame:CGRectMake(0,0,0,0)];
        dianV.tag = 200 + i;
        dianV.frame = CGRectMake(25 * WIDTH_SCALE, (lineHeight + 20 * HEIGHT_SCALE) + (50* i *HEIGHT_SCALE), 15 * WIDTH_SCALE, 15 * HEIGHT_SCALE);
        dianV.backgroundColor = [UIColor lightGrayColor];
        dianV.layer.cornerRadius = dianV.frame.size.width / 2.0;
        dianV.clipsToBounds = YES;
        [scrollView addSubview:dianV];
        
    }
    
    biaoDanTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 0, 0, 0) CellHeight:50.0 ScrollEnabled:NO];
    biaoDanTableView.frame = CGRectMake(50 * WIDTH_SCALE, lineHeight + 1 * HEIGHT_SCALE, 250 * WIDTH_SCALE,  50 * 5 * HEIGHT_SCALE);
    biaoDanTableView.dataSource = self;
    biaoDanTableView.delegate = self;
    [scrollView addSubview:biaoDanTableView];
    
    

    
    
}
- (void)imageViewControllerBigAnimation:(UIView *)customView{
    [UIView animateWithDuration:0 animations:^{
        customView.backgroundColor = [UIColor greenColor];
        customView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    }];
}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == workTableView) {
         return workArray.count;
    }else{
        return 5;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == workTableView) {
        static NSString *cellIdentifier = @"WorkSearchCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = workArray[indexPath.row];
        cell.detailTextLabel.text = workInfoArray [indexPath.row];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
        return cell;
    }else{
        static NSString *cellIdentifier = @"BiaoDanCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = biaoDanArray[indexPath.row];
        cell.detailTextLabel.text = biaoDanDateArray [indexPath.row];
        if ([biaoDanStateArray[indexPath.row] isEqualToString:@"no"]) {
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor blackColor];

        }else{
            cell.textLabel.textColor = [UIColor greenColor];
            cell.detailTextLabel.textColor = [UIColor greenColor];
            UIView *customView = (UIView *)[scrollView viewWithTag:200 + indexPath.row];
            [self imageViewControllerBigAnimation:customView];
        }
       
        
        
        return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
