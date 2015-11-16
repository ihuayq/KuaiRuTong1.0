//
//  AddWebViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/9/28.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import "AddWebViewController.h"

@interface AddWebViewController (){
    UITableView *webTableView;
    UITableView *xlhTableView;
    UITextField *addressTextField;
    UIButton *shengButton;
    UIButton *shiButton;
    UIButton *xianButton;
    NSMutableArray *xlhArray ;
    NSString *currentXLHCode;
}

@end

@implementation AddWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicView];
    xlhArray = [[NSMutableArray alloc] init];
    currentXLHCode = @"";
    [xlhArray addObject:currentXLHCode];
    [xlhTableView reloadData];
}
- (void)loadBasicView{
    //navBar
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = @"新增网点";
    customNavBar.Delegate = self;
    //webTableView
    webTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 5, 320, 80) CellHeight:40 ScrollEnabled:NO];
    webTableView.dataSource = self;
    webTableView.delegate = self;
    [scrollView addSubview:webTableView];
    
    //xlhTableView
    xlhTableView = [ViewModel createTableViewWithFrame:CGRectMake(0, 0, 0, 0) CellHeight:40 ScrollEnabled:YES];
    xlhTableView.frame = CGRectMake(0,85 * HEIGHT_SCALE, 320 * WIDTH_SCALE,scrollView.frame.size.height - 125 * HEIGHT_SCALE  );
    xlhTableView.dataSource = self;
    xlhTableView.delegate = self;
    [scrollView addSubview:xlhTableView];
    //保存按钮
    UIButton *saveButton = [ViewModel createButtonWithFrame:CGRectMake(0, 0, 0, 0) ImageNormalName:nil ImageSelectName:nil Title:@"保 存" Target:self Action:@selector(saveButtonClicked)];
    saveButton.frame = CGRectMake(0, scrollView.frame.size.height - 40 * HEIGHT_SCALE, 320 * WIDTH_SCALE, 40 * HEIGHT_SCALE);
    saveButton.backgroundColor = RED_COLOR1;
    [scrollView addSubview:saveButton];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == webTableView){
        return 2;
    }else{
        return xlhArray.count;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == webTableView) {
        static NSString *cellIdentifier = @"BasicCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        if (indexPath.row == 0) {
            //省（选择）
            shengButton = [ViewModel createButtonWithFrame:CGRectMake(10, 5, 90, 30) ImageNormalName:nil ImageSelectName:nil Title:@"省" Target:self Action:@selector(shengButtonClicked)];
            shengButton.backgroundColor  = [UIColor lightGrayColor];
            [shengButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            shengButton.layer.masksToBounds = YES;
            shengButton.layer.cornerRadius = 5.0f;
            [cell.contentView addSubview:shengButton];
            //市（选择）
            shiButton = [ViewModel createButtonWithFrame:CGRectMake(110, 5, 90, 30) ImageNormalName:nil ImageSelectName:nil Title:@"市" Target:self Action:@selector(shiButtonClicked)];
            shiButton.backgroundColor  = [UIColor lightGrayColor];
            [shiButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            shiButton.layer.masksToBounds = YES;
            shiButton.layer.cornerRadius = 5.0f;
            [cell.contentView addSubview:shiButton];
            //县（选择）
            xianButton = [ViewModel createButtonWithFrame:CGRectMake(210, 5, 90, 30) ImageNormalName:nil ImageSelectName:nil Title:@"县" Target:self Action:@selector(xianButtonClicked)];
            xianButton.backgroundColor  = [UIColor lightGrayColor];
            [xianButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            xianButton.layer.masksToBounds = YES;
            xianButton.layer.cornerRadius = 5.0f;
            [cell.contentView addSubview:xianButton];

        }else if (indexPath.row == 1){
            //详细地址
            addressTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, 270, 40) Placeholder:@"输入网点详细地址" Font:[UIFont systemFontOfSize:20.0]];
            addressTextField.borderStyle = UITextBorderStyleNone;
            addressTextField.textAlignment = NSTextAlignmentLeft;
            addressTextField.delegate = self;
            [cell.contentView addSubview:addressTextField];
            //定位
            UIButton *locationButton = [ViewModel createButtonWithFrame:CGRectMake(280, 0, 40, 40) ImageNormalName:nil ImageSelectName:nil Title:nil Target:self Action:@selector(locationButtonClicked)];
            locationButton.backgroundColor = RED_COLOR1;
            [cell.contentView addSubview:locationButton];
        }
        return cell;
    }else{
        static NSString *cellIdentifier = @"XLHCell";
        MachineCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[MachineCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.Delegate = self;
        }
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((tableView == xlhTableView)&&(xlhArray.count != 1)) {
        return YES;
    }else{
        return NO;
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [xlhArray removeObjectAtIndex:indexPath.row];
        [xlhTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [tableView reloadData];
}
#pragma mark -- MachineCodeCellDelegate
- (void)addButtonForCell:(MachineCodeCell *)cell{

    [xlhArray addObject:currentXLHCode];
    [xlhTableView reloadData];
}
- (void)writeTextFieldForCell:(MachineCodeCell *)cell AndText:(NSString *)text{
    NSIndexPath *indexPath = [xlhTableView indexPathForCell:cell];
    NSInteger row = indexPath.row;
    [xlhArray replaceObjectAtIndex:row withObject:text];
    [xlhTableView reloadData];
    
}
- (void)locationButtonClicked{
    
}
- (void)shengButtonClicked{
    
}
- (void)shiButtonClicked{
    
}
- (void)xianButtonClicked{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)saveButtonClicked{
    
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
