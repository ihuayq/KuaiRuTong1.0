//
//  QuestionSHViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/15.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "QuestionSHViewController.h"

#import "QuestionSHDetailViewController.h"
@interface QuestionSHViewController (){
    
    UITableView *searchTableView;
    UITableView *questionTableView;
    
    UITextField *nameTextField;
    UITextField *dateTextField;
    
    NSMutableArray *questonsArray;
    
    UIDatePicker *datePicker;
    UIView *dateSelectView;
}

@end

@implementation QuestionSHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicView];
    
}

- (void)loadBasicView{
    //nav
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"问题工作流程";
    customNavBar.Delegate = self;
    //搜索条件
    searchTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 0, 320, 40 * 3) CellHeight:40.0 ScrollEnabled:NO];
    searchTableView.dataSource = self;
    searchTableView.delegate = self;
    [scrollView addSubview:searchTableView];
    //结果
    questionTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 0, 0, 0) CellHeight:40.0 ScrollEnabled:YES];
    questionTableView.frame = CGRectMake(0, 150 * HEIGHT_SCALE, 320 * WIDTH_SCALE, scrollView.frame.size.height- 150* HEIGHT_SCALE);
    questionTableView.backgroundColor = ORANGE_COLOR;
    questionTableView.dataSource = self;
    questionTableView.delegate   = self;
    [scrollView addSubview:questionTableView];

//    //商户名称
//    nameTextField = [ViewModel createTextFieldWithFrame:CGRectMake(24, 103, 208, 30) Placeholder:@"请输入商户名称" Font:nil];
//    nameTextField.delegate = self;
//    [scrollView addSubview:nameTextField];
//    
//    //日期
//    
//    dateTextField = [[UITextField alloc] initWithFrame:CGRectMake(24 * WIDTH_SCALE, 163 * HEIGHT_SCALE, 167 * WIDTH_SCALE, 30 *HEIGHT_SCALE)];
//    dateTextField.enabled = NO;
//    dateTextField.backgroundColor = [UIColor clearColor];
//    dateTextField.borderStyle = UITextBorderStyleLine;
//    dateTextField.placeholder = @"手动选择日期";
//    [self.view addSubview:dateTextField];
//    
//    //日期按钮
//    UIButton *dateButton = [[UIButton alloc] initWithFrame:CGRectMake(24 * WIDTH_SCALE, 163 * HEIGHT_SCALE, 167 * WIDTH_SCALE , 30  * HEIGHT_SCALE)];
//    dateButton.backgroundColor = [UIColor clearColor];
//    [dateButton addTarget:self action:@selector(dateButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:dateButton];
//    
//    //日历按钮
//    UIButton *calenderButton = [[UIButton alloc] initWithFrame:CGRectMake(202 * WIDTH_SCALE, 163 * HEIGHT_SCALE , 30 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    calenderButton.backgroundColor = [UIColor redColor];
//    [calenderButton addTarget:self action:@selector(dateButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:calenderButton];
//    
//    //搜索按钮
//    UIButton *searchButton =  [[UIButton alloc] initWithFrame:CGRectMake(240 * WIDTH_SCALE, 163 * HEIGHT_SCALE, 64 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
//    searchButton.backgroundColor =[UIColor lightGrayColor];
//    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
//    searchButton.layer.masksToBounds = YES;
//    searchButton.layer.borderWidth = 1.0;
//    [searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:searchButton];
//    
//    //UITableView
//    questionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 218 * HEIGHT_SCALE, 320 * WIDTH_SCALE, HEIGHT - 218 * HEIGHT_SCALE) style:UITableViewStylePlain];
//    questionTableView.backgroundColor = [UIColor clearColor];
//    questionTableView.dataSource = self;
//    questionTableView.delegate = self;
//    [self.view addSubview:questionTableView];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return questonsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == searchTableView) {
        static NSString *cellIdentifier = @"Search1Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
   
        }
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1){
            
        }
       
        return cell;

    }else{
        static NSString *cellIdentifier = @"QuestionCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = [NSString stringWithFormat:@"商户名称: %@",questonsArray[indexPath.row]];
        return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *questionsDic = [[NSMutableDictionary alloc] init];
    [questionsDic setObject:questonsArray[indexPath.row] forKey:@"name"];
    [questionsDic setObject:@1 forKey:@"questionTag"];
    [questionsDic setObject:@"2016/06/30" forKey:@"time"];
    [questionsDic setObject:@"身份证照片不清晰。" forKey:@"desic"];
    
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    QuestionSHDetailViewController *childController = [board instantiateViewControllerWithIdentifier: @"QuestionSHDetailVC"];
    childController.questionsDic = questionsDic;
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
     questonsArray  = [[NSMutableArray alloc] initWithObjects:@"海科融通1",@"海科融通2",@"海科融通3",@"海科融通4",@"海科融通5",@"海科融通6",@"海科融通7",@"海科融通8", nil];
        [questionTableView reloadData];
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
