//
//  NewBusinessViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/9.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "NewBusinessViewController.h"
#import "ShowImageViewController.h"
#import "SHInfoViewController.h"
#import "NewSHCell.h"
@interface NewBusinessViewController (){
    UITableView *newTableView;  //新建商户列表信息
    NSArray *titlesArray;       //标题数组
    NSInteger currentPhotoTag;  //当前图片标识
    UIButton *uploadBtn;        //上传按钮
    UIButton *saveBtn;          //保存按钮
    NSMutableArray *photosArray;       //相片是否保存数组
}

@end

@implementation NewBusinessViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"photosTempArray"] isKindOfClass:[NSArray class]]) {
        photosArray = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"photosTempArray"]];

    }else{
        photosArray = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < 8; i ++) {
            [photosArray addObject:@"no"];
        }
        [userDefaults setObject:photosArray forKey:@"photosTempArray"];
        [userDefaults synchronize];
        
    }
    [newTableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicData];
    [self loadBasicView];
}
- (void)loadBasicData{
     titlesArray = [[NSArray alloc] initWithObjects:@"商户信息填写",@"营业执照",@"身份证证面",@"身份证反面",@"店面照",@"结算卡正面",@"结算卡反面",@"合同照片", nil];
    [newTableView reloadData];
}

- (void)loadBasicView{
  
    if ([_pendingType isEqualToString:@"yes"]) {
        customNavBar.backView.hidden = NO;
        customNavBar.Delegate = self; 
    }else{
        customNavBar.backView.hidden = YES;
    }
    
    newTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 0, 320, 352) CellHeight:44.0 ScrollEnabled:YES];
    newTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    newTableView.dataSource = self;
    newTableView.delegate  = self;
    [scrollView addSubview:newTableView];
    
    
    uploadBtn = [ViewModel createButtonWithFrame:CGRectMake(40, 370, 100, 40) ImageNormalName:nil ImageSelectName:nil Title:@"上   传" Target:self Action:@selector(uploadBtnMethod)];
    uploadBtn.layer.masksToBounds = YES;
    uploadBtn.layer.cornerRadius = 5.0;
    uploadBtn.backgroundColor = ORANGE_COLOR;
    [scrollView addSubview:uploadBtn];

    saveBtn = [ViewModel createButtonWithFrame:CGRectMake(180, 370, 100, 40) ImageNormalName:nil ImageSelectName:nil Title:@"保   存" Target:self Action:@selector(saveBtnMethod)];
    saveBtn.backgroundColor = ORANGE_COLOR;
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 5.0;
    [scrollView addSubview:saveBtn];
    [scrollView setContentSize:CGSizeMake(0, 500 * HEIGHT_SCALE)];
}
#pragma --PrivateMethods
/**
 *  上传方法
 */
- (void)uploadBtnMethod{
    
}
/**
 *  保存方法
 */
- (void)saveBtnMethod{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"yes" forKey:@"isSaveNewBussinss"];
    [userDefaults synchronize];
    hud_SuperVC.labelText = @"保存成功";
    [hud_SuperVC show:YES];
    [hud_SuperVC hide:YES afterDelay:2];
}
#pragma --UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"NewSHCell";
    NewSHCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[NewSHCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.cunButton.hidden = YES;
        cell.titleLabel.text = titlesArray[indexPath.row];
        cell.intoInfoView.hidden = NO;
    }else{
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.cunButton.hidden = NO;
        cell.intoInfoView.hidden = YES;
        cell.titleLabel.text = titlesArray[indexPath.row];
        if ([[photosArray objectAtIndex:(indexPath.row - 1)] isEqualToString:@"yes"]) {
            cell.cunButton.selected = YES;
        }else{
            cell.cunButton.selected = NO;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
        SHInfoViewController *childController = [board instantiateViewControllerWithIdentifier: @"SHInfoVC"];
        [self.navigationController pushViewController:childController animated:YES];
    }else{
        UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
        ShowImageViewController *childController = [board instantiateViewControllerWithIdentifier: @"ShowImageVC"];
        childController.navTitle = titlesArray[indexPath.row];
        childController.currentPhotoTag = indexPath.row;
        childController.isTakePhoto = NO;
        [self.navigationController pushViewController:childController animated:YES];
    }
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
