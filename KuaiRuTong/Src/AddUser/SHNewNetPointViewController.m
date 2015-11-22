//
//  NewNetPointViewController.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/18.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "SHNewNetPointViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "LocationPickerViewController.h"
#import "CodeTableViewCell.h"

typedef NS_ENUM(int, EditState){
    NormalState = 0,
    InsertState ,
    DeleteState
};

@interface SHNewNetPointViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>{
    EditState editState;
    
    NSMutableArray *codeList;
    NSMutableArray *arrayTitle;
    
    
    UIButton *addressBtn;
    NSString *strCityInfo;
    UITextField *addressTextField;
    
    
    UIButton * deletebtn;
    UIButton * addbtn;
    
}

@end

@implementation SHNewNetPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    //self.navigation.rightTitle = @"保存";
    self.navigation.title = @"新增网点";
    
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT)
                                                                  style:UITableViewStyleGrouped];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.tableView.scrollEnabled = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //[self.tableView setEditing:YES];
    [self.view addSubview:self.tableView];
    
    
    // MainHeight - 48 - NAVIGATION_OUTLET_HEIGHT
    UIButton* saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth/2 - MainWidth/4, MainHeight - SCREEN_BODY_HEIGHT -280 , MainWidth/2, 40)];
    [saveBtn addTarget:self action:@selector(saveNetPointInfo) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitle:@"保   存" forState:UIControlStateNormal];
    saveBtn.backgroundColor = ORANGE_COLOR;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn.layer setCornerRadius:saveBtn.frame.size.height/2.0f];
    [self.view addSubview:saveBtn];

    arrayTitle = [NSMutableArray arrayWithArray:@[@"地址",@"机身序列号"]];
    codeList = [NSMutableArray arrayWithArray:@[@""]];
}


-(void)previousToViewController
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)saveNetPointInfo{
    //详细地址信息
    if ([strCityInfo isEmptyOrWhitespace]) {
        [self presentCustomDlg:@"请选择城市信息"];
        return;
    }
    
    //主要城市区位置信息
    if ([addressTextField.text isEmptyOrWhitespace]) {
        [self presentCustomDlg:@"请输入详细地址信息"];
        return;
    }
    
    if ([codeList[codeList.count - 1] isEmptyOrWhitespace]) {
        [self presentCustomDlg:@"请输入机器码"];
        return;
    }
    
    //机身序列号查找
//    for (NSIndexPath* indexPath in [self.tableView indexPathsForVisibleRows])
//    {
//        if (indexPath.section != 0) {
//            CodeTableViewCell * cell = (CodeTableViewCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
//        }
//    }
    NSString *codeString = [codeList componentsJoinedByString:@","];//分隔符
    DLog(@"THE POS INFO IS %@",codeString);
    
    
    [self dismissViewControllerAnimated:NO completion:nil];
    //保存机器信息
    if (self.block) {
        
        DLog(@"THE NETWORK INFO IS %@",[NSString stringWithFormat:@"%@,%@;%@",strCityInfo,addressTextField.text,codeString]);
        self.block([NSString stringWithFormat:@"%@,%@",strCityInfo,addressTextField.text],codeString);
    }
   
    
}


#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return [codeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ) {
        
        static NSString *cellIdentifier = @"InfoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            //cell.showsReorderControl =YES;
        }
        
        if (indexPath.row == 0){
            addressBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, MainWidth, 40)];
            [addressBtn addTarget:self action:@selector(selectBtn) forControlEvents:UIControlEventTouchUpInside];
            [addressBtn setTitle:@"XX省 XX市 XX区" forState:UIControlStateNormal];
            addressBtn.backgroundColor = [UIColor clearColor];
            [addressBtn setTitleColor:[UIColor light_Gray_Color]forState:UIControlStateNormal];
            addressBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;//设置文字位置，现设为居左，默认的是居中
            addressBtn.contentEdgeInsets = UIEdgeInsetsMake(0,6,0, 0);
            [cell.contentView addSubview:addressBtn];
            
        }else if (indexPath.row == 1){
            //详细地址
            addressTextField = [[UITextField  alloc ]initWithFrame:CGRectMake(10, 0, MainWidth, 40)];
            addressTextField.borderStyle = UITextBorderStyleNone;
            addressTextField.textAlignment = NSTextAlignmentLeft;
            addressTextField.placeholder = @"请输入详细地址";
            addressTextField.font = [UIFont systemFontOfSize:20.0];
            [cell.contentView addSubview:addressTextField];
        }
        
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"codeCell";
        CodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[CodeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.showsReorderControl =YES;
        }
        //弱类型才可以再块中进行改变
        __weak NSMutableArray *dataWeak = codeList;
        //具体声明块方法，将text修改后的值，传递回Data中
        cell.onTextEntered = ^(NSString * enteredString){
            [dataWeak setObject:enteredString atIndexedSubscript:indexPath.row];
        };
        
        return cell;
        
//        if (indexPath.row == 0){
//            //商户邀请码
//            UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 4, MainWidth, 40)];
//            [moreBtn addTarget:self action:@selector(addNetPiontInfo) forControlEvents:UIControlEventTouchUpInside];
//            [moreBtn setTitle:@"填写机身序列号" forState:UIControlStateNormal];
//            moreBtn.backgroundColor = [UIColor clearColor];
//            [moreBtn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
//            [cell.contentView addSubview:moreBtn];
//        }
    }
    
    return  nil;
}

//省市区选择器
-(void)selectBtn{
    LocationPickerViewController *locationPickerVC = [[LocationPickerViewController alloc] init];
    locationPickerVC.block = ^(NSString *strProvice,NSString *strCity,NSString *strArea){
        //城市信息选择器
        if (strProvice.isEmpty || strCity.isEmpty || strArea.isEmpty) {
            strCityInfo = @"";
        }else{
            strCityInfo = [NSString stringWithFormat:@"%@,%@,%@", strProvice,strCity,strArea];
        }
        
        [addressBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@", strProvice,strCity,strArea] forState:UIControlStateNormal];
    };
    [self presentViewController:locationPickerVC animated:NO completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, MainWidth, 20.0)];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    headerLabel.frame = CGRectMake(10.0, 4.0, 300.0, 20.0);
    headerLabel.text = arrayTitle[section];
    
    [customView addSubview:headerLabel];
    
    if (section == 1) {
        deletebtn = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth - 60, 0, 60, 20)];
        [deletebtn addTarget:self action:@selector(noteDelete) forControlEvents:UIControlEventTouchUpInside];
        [deletebtn setTitle:@"编辑" forState:UIControlStateNormal];
        deletebtn.backgroundColor = [UIColor clearColor];
        [deletebtn setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateNormal];
        [customView addSubview:deletebtn];
        
        
//        addbtn = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth -120, 0, 60, 20)];
//        [addbtn addTarget:self action:@selector(noteAdd) forControlEvents:UIControlEventTouchUpInside];
//        [addbtn setTitle:@"添加" forState:UIControlStateNormal];
//        addbtn.backgroundColor = [UIColor clearColor];
//        [addbtn setTitleColor:[UIColor light_Gray_Color] forState:UIControlStateNormal];
//        [customView addSubview:addbtn];
    }
    
    return customView;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( indexPath.section == 1 ){
        return YES;
    }
    return NO;
}

//确认编辑类型
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editState == InsertState) {
        return UITableViewCellEditingStyleInsert;
    }
    else if(editState == DeleteState){
       return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}


//添加行的删除
- (void)noteDelete
{
    if (self.tableView.editing == YES) {
        self.tableView.editing = NO;
        return;
    }
    
    UIActionSheet *sheetImage = [[UIActionSheet alloc]initWithTitle:@"请选择编辑模式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"添加",@"减少", nil];
    [sheetImage showInView:[UIApplication sharedApplication].keyWindow];
}

//插入删除掉cell方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (codeList.count == 1) {
            [self displayOverFlowActivityView:@"不能再删除了，亲" maxShowTime:(CGFloat)0.5];
            return;
        }

        NSUInteger row = [indexPath row]; //获取当前行
        [codeList removeObjectAtIndex:row]; //在数据中删除当前对象
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];//数组执行删除操作
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert){
        if (codeList.count == 3) {
            [self displayOverFlowActivityView:@"限制添加三行，亲" maxShowTime:(CGFloat)0.5];
            return;
        }
        
        [codeList addObject:@""];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}

#pragma mark -- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 2) {
        editState = NormalState;
        return;
    }
    if (buttonIndex == 1) {
        editState = DeleteState;
    }
    else if (buttonIndex == 0) {
        editState = InsertState;
    }
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

@end
