//
//  QuestionSHDetailViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/15.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "QuestionSHDetailViewController.h"
#import "DeviceManager.h"
#import "ImageInfoViewController.h"
@interface QuestionSHDetailViewController (){
    NSArray *titlesArray;
    UITableView *detailTableView;
}

@end

@implementation QuestionSHDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicData];
    [self loadBasicView];
    
}

- (void)loadBasicData{
    titlesArray = [[NSArray alloc] initWithObjects:@"营业执照照片",@"身份证正面照",@"身份证反面照",@"店面照",@"结算卡正面",@"结算卡反面",@"商户信息", nil];
    [detailTableView reloadData];
}

- (void)loadBasicView{
    //标题栏
    CustomNavBar *customNavBar = [[CustomNavBar alloc] initWithFrame:CGRectMake(0, 0, 320 * WIDTH_SCALE, 60 * HEIGHT_SCALE + 20)];
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = _questionsDic[@"name"];
    customNavBar.Delegate = self;
    [self.view addSubview:customNavBar];
    
    //商户名称
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 93, 288, 21)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor grayColor];
    nameLabel.text = [NSString stringWithFormat:@"商户名称: %@",_questionsDic[@"name"]];
    [self.view addSubview:nameLabel];
    
    //申请时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 122, 288, 21)];
    timeLabel.backgroundColor = [UIColor clearColor];
       timeLabel.textColor = [UIColor grayColor];
    timeLabel.text = [NSString stringWithFormat:@"申请时间: %@",_questionsDic[@"time"]];
    [self.view addSubview:timeLabel];
    
    //审批备注
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 151, 288, 21)];
    descLabel.backgroundColor =[UIColor clearColor];
       descLabel.textColor = [UIColor grayColor];
    descLabel.text = [NSString stringWithFormat:@"审批备注: %@",_questionsDic[@"desic"]];
    [self.view addSubview:descLabel];
    
    //UITableView
    CGFloat height = (44 * titlesArray.count * HEIGHT_SCALE) > (HEIGHT - 200 * HEIGHT_SCALE) ? (HEIGHT - 200 * HEIGHT_SCALE) : (44 * titlesArray.count * HEIGHT_SCALE);
    detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, 320, height) style:UITableViewStylePlain];
    detailTableView.backgroundColor = [UIColor clearColor];
    detailTableView.dataSource = self;
    detailTableView.delegate = self;
    [self.view addSubview:detailTableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"DetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == [_questionsDic[@"questionTag"] integerValue]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (照片有误请重新上传)", titlesArray[indexPath.row]];
        cell.textLabel.textColor = [UIColor redColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.textLabel.text = titlesArray[indexPath.row];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSMutableDictionary *imageInfoDic = [[NSMutableDictionary alloc] init];
    [imageInfoDic setObject:titlesArray[indexPath.row] forKey:@"title"];
    if (indexPath.row == [_questionsDic[@"questionTag"] integerValue]) {
         [imageInfoDic setObject:@"yes" forKey:@"questionType"];
        UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
        ImageInfoViewController *childController = [board instantiateViewControllerWithIdentifier: @"ImageInfoVC"];
        childController.imageInfoDic = imageInfoDic;
        [self.navigationController pushViewController:childController animated:YES];
    }else{
        [imageInfoDic setObject:@"no" forKey:@"questionType"];
    }
    
   
    
  
}
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
