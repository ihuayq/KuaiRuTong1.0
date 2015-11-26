//
//  PendSHViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/15.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "PendSHViewController.h"
#import "DeviceManager.h"
#import "MBProgressHUD.h"
#import "NewBusinessViewController.h"
@interface PendSHViewController (){
    UITextField *nameTextField;
    UITextField *dateTextField;
    MBProgressHUD *HUD_PendSHVC;
    NSMutableArray *pendArray;
    UITableView *pendTableView;
    UIDatePicker *datePicker;
    UIView *dateSelectView;
}


@end

@implementation PendSHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self loadBasicView];
}
- (void)loadBasicView{
    //hud
    HUD_PendSHVC = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    HUD_PendSHVC.mode = MBProgressHUDModeText;
    [self.navigationController.view addSubview:HUD_PendSHVC];
    //标题栏
    CustomNavBar *customNavBar = [[CustomNavBar alloc] initWithFrame:CGRectMake(0, 0, 320 * WIDTH_SCALE, 60 * HEIGHT_SCALE + 20)];
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"待处理流程";
    customNavBar.Delegate = self;
    [self.view addSubview:customNavBar];
    
    
    //商户名称
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(24 * WIDTH_SCALE , 103 *HEIGHT_SCALE, 208 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
    nameTextField.returnKeyType = UIReturnKeyDone;
    nameTextField.backgroundColor = [UIColor clearColor];
    nameTextField.borderStyle = UITextBorderStyleLine;
    nameTextField.placeholder = @"请输入商户名称";
    nameTextField.delegate = self;
    [self.view addSubview:nameTextField];
    
    //日期
    dateTextField = [[UITextField alloc] initWithFrame:CGRectMake(24 * WIDTH_SCALE, 163 * HEIGHT_SCALE, 167 * WIDTH_SCALE, 30 *HEIGHT_SCALE)];
    dateTextField.enabled = NO;
    dateTextField.backgroundColor = [UIColor clearColor];
    dateTextField.borderStyle = UITextBorderStyleLine;
    dateTextField.placeholder = @"手动选择日期";
    [self.view addSubview:dateTextField];
    
    //日期按钮
    UIButton *dateButton = [[UIButton alloc] initWithFrame:CGRectMake(24 * WIDTH_SCALE, 163 * HEIGHT_SCALE, 167 * WIDTH_SCALE , 30  * HEIGHT_SCALE)];
    dateButton.backgroundColor = [UIColor clearColor];
    [dateButton addTarget:self action:@selector(dateButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dateButton];
    
    //日历按钮
    UIButton *calenderButton = [[UIButton alloc] initWithFrame:CGRectMake(202 * WIDTH_SCALE, 163 * HEIGHT_SCALE , 30 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
    calenderButton.backgroundColor = [UIColor redColor];
    [calenderButton addTarget:self action:@selector(dateButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:calenderButton];
    
    //搜索按钮
    UIButton *searchButton =  [[UIButton alloc] initWithFrame:CGRectMake(240 * WIDTH_SCALE, 163 * HEIGHT_SCALE, 64 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
    searchButton.backgroundColor =[UIColor lightGrayColor];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.layer.masksToBounds = YES;
    searchButton.layer.borderWidth = 1.0;
    [searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    //UITableView
    pendTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 218 * HEIGHT_SCALE, 320 * WIDTH_SCALE, HEIGHT - 218 * HEIGHT_SCALE) style:UITableViewStylePlain];
    pendTableView.backgroundColor = [UIColor clearColor];
    pendTableView.dataSource = self;
    pendTableView.delegate = self;
    [self.view addSubview:pendTableView];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return pendArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"PendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"商户名称: %@",pendArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    NewBusinessViewController *childController = [board instantiateViewControllerWithIdentifier:@"NewBusinessVC"];
    //childController.pendingType = @"yes";
    [self.navigationController pushViewController:childController animated:YES];
}


- (void)dateButtonClicked{
    [dateSelectView removeFromSuperview];
    dateSelectView = nil;
    
    dateSelectView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 180, 320 * WIDTH_SCALE, 180)];
    dateSelectView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:dateSelectView];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80 * WIDTH_SCALE, 20)];
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [dateSelectView addSubview:cancelButton];
    
    UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectMake(240 * WIDTH_SCALE, 0, 80 * WIDTH_SCALE, 20)];
    okButton.backgroundColor = [UIColor grayColor];
    [okButton setTitle:@"确认" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [dateSelectView addSubview:okButton];
    
    //年份控件
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 20, 320 * WIDTH_SCALE, 162)];
    datePicker.date = [NSDate date];
    datePicker.backgroundColor = [UIColor lightGrayColor];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.layer.borderWidth = 1.5f;
    [dateSelectView addSubview:datePicker];
}

- (void)cancelButtonClicked{
    [dateSelectView removeFromSuperview];
    dateSelectView = nil;
}

/**
 * 获取当前时间
 * @return NSString 返回当前日期
 */
- (NSString *)dealWithDate:(NSDate *)date{
    
    NSCalendar *calendar1 = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar1 components:unitFlags fromDate:date];
    int year  = (int)[dateComponent year];
    int month = (int)[dateComponent month];
    int day   = (int)[dateComponent day];
    NSString *dateStr = [NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
    
    return dateStr;
}

- (void)okButtonClicked{
    [dateSelectView removeFromSuperview];
    dateSelectView = nil;
    NSDate *selectedDate = [datePicker date];
    NSString *dealWithDateString = [self dealWithDate:selectedDate];
    dateTextField.text = dealWithDateString;
}

#pragma mark -- UITextFieldDelegate 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [dateSelectView removeFromSuperview];
    dateSelectView = nil;
    return YES;
}



- (void)searchButtonClicked{
    [dateSelectView removeFromSuperview];
    dateSelectView = nil;
    //    if ([nameTextField.text isEqualToString:@""] || (nameTextField.text == nil)||[dateTextField.text isEqualToString:@""]||(dateTextField == nil)) {
    //        HUD_QuestionSHVC.labelText = @"请输入完整信息";
    //        HUD_QuestionSHVC.mode = MBProgressHUDModeText;
    //        [HUD_QuestionSHVC show:YES];
    //        [HUD_QuestionSHVC hide:YES afterDelay:2];
    //    }else{
    pendArray  = [[NSMutableArray alloc] initWithObjects:@"待处理事件1",@"待处理事件2",@"待处理事件3",@"待处理事件4",@"待处理事件5",@"待处理事件6",@"待处理事件7",@"待处理事件8", nil];
    [pendTableView reloadData];
    //    }
    
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
