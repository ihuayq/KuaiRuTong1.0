//
//  CateViewController.m
//  top100
//
//  Created by Dai Cloud on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CateViewController.h"
#import "SubCateViewController.h"
#import "SHInfoTableViewCell.h"
#import "Globle.h"
#import "SHDataItem.h"
#import "BusinessSavedDAO.h"
#import "SHInfoViewController.h"
#import "BusinessInfoUpdateService.h"
#import "IssueLabelTableViewCell.h"
#import "ZipArchive.h"
#import "FCFileManager.h"

@interface CateViewController () <UIFolderTableViewDelegate,BusinessInfoUpdateServiceDelegate>{
    UIButton *uploadBtn;        //上传按钮
    UIButton *saveBtn;          //保存按钮
    
    int  nSelectIndex;
    
    SubCateViewController *subVc;
}

@property (strong, nonatomic) SubCateViewController *subVc;
@property (strong, nonatomic) NSDictionary *currentCate;


@end

@implementation CateViewController

@synthesize cates=_cates;
@synthesize subVc=_subVc;
@synthesize currentCate=_currentCate;
@synthesize tableView=_tableView;


-(NSArray *)cates
{
    if (_cates == nil){
        _cates = [Globle shareGloble].titleShDataArray;
    }
    
    return _cates;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    self.tableView =  [[UIFolderTableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT - 200 ) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    if (self.nType == 0) {
        BusinessSavedDAO *dao= [[BusinessSavedDAO alloc] init];
        self.SHData = [dao searchSHItemDAOFromDB:self.shopName];
    }
    else{
        [self displayOverFlowActivityView:@"加载问题数据"];
        [self.service downLoadWithMerName:self.shopName];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cates.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cate_cell";
    static NSString *cellNormal= @"normal_cell";
    static NSString *cellInfo= @"info_cell";
//    if ( indexPath.row == 0) {
//        IssueLabelTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellNormal];
//        if (cell == nil) {
//            cell = [[IssueLabelTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
//                                          reuseIdentifier:CellIdentifier];
//        }
//        cell.model = self.SHData;
//        return cell;
//    }
    if ( indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInfo];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:cellInfo];
           
            UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(MainWidth -40, 6,30,30)];
            img.image = [UIImage imageNamed:@"addInfo"];
            [cell.contentView addSubview:img];
            
            cell.textLabel.text = [self.cates objectAtIndex:indexPath.row];
        
        }

        return cell;
    }
    else if (indexPath.row == 8)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNormal];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:cellNormal];
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        uploadBtn = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth/4 - MainWidth/6,5,MainWidth/3,30)];
        [uploadBtn addTarget:self action:@selector(uploadBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [uploadBtn setTitle:@"上   传" forState:UIControlStateNormal];
        [uploadBtn.layer setMasksToBounds:YES];
        [uploadBtn.layer setCornerRadius:uploadBtn.frame.size.height/2.0f]; //设置矩形四个圆角半径
        uploadBtn.backgroundColor = ORANGE_COLOR;
        [cell.contentView  addSubview:uploadBtn];
        
        // MainHeight - 48 - NAVIGATION_OUTLET_HEIGHT
        saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth/2 + MainWidth/4 - MainWidth/6 , 5, MainWidth/3, 30)];
        [saveBtn addTarget:self action:@selector(saveBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [saveBtn setTitle:@"保 存 " forState:UIControlStateNormal];
        saveBtn.backgroundColor = ORANGE_COLOR;
        saveBtn.layer.masksToBounds = YES;
        [saveBtn.layer setCornerRadius:saveBtn.frame.size.height/2.0f];
        [cell.contentView addSubview:saveBtn];
            }
        return cell;
    }
    else
    {
        SHInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[SHInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        

        DLog(@"模块单元格(组：%i,行%i)",indexPath.section,indexPath.row);
        cell.title.text = [self.cates objectAtIndex:indexPath.row];
        }
        
        return cell;
    }
    
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ( indexPath.row == 0 ) {
        SHInfoViewController *vc = [[SHInfoViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.item = self.SHData;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if ( indexPath.row == 8 ) {
        
        return;
    }
    
    SHInfoTableViewCell *cell = (SHInfoTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    subVc = [[SubCateViewController alloc] init];
    subVc.cateVC = self;
    
    
    nSelectIndex = indexPath.row;
    if ( indexPath.row == 1 ) {
        subVc.imageData= self.SHData.photo_business_permit;
    }
    else if ( indexPath.row == 2 ) {
        subVc.imageData= self.SHData.photo_identifier_front;
    }
    else if ( indexPath.row == 3 ) {
        subVc.imageData= self.SHData.photo_identifier_back;
    }
    else if ( indexPath.row == 4 ) {
        subVc.imageData= self.SHData.photo_business_place;
    }
    else if ( indexPath.row == 5 ) {
        subVc.imageData= self.SHData.photo_bankcard_front;
    }
    else if ( indexPath.row == 6 ) {
        subVc.imageData= self.SHData.photo_bankcard_back;
    }
    else if ( indexPath.row == 7 ) {
        subVc.imageData= self.SHData.photo_contracts;
    }

    [cell changeArrowWithUp:YES];
    
    self.tableView.scrollEnabled = NO;
    UIFolderTableView *folderTableView = (UIFolderTableView *)tableView;
    [folderTableView openFolderAtIndexPath:indexPath WithContentView:subVc.view 
                                 openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                     // opening actions
                                     //[cell changeArrowWithUp:NO];
                                 } 
                                closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                    // closing actions
                                    [cell changeArrowWithUp:YES];
                                } 
                           completionBlock:^{
                               // completed actions
                               self.tableView.scrollEnabled = YES;
                           }];
    
}

-(CGFloat)tableView:(UIFolderTableView *)tableView xForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0) {
//        return 0.1;
//    }
    return 44;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
    
}

- (BusinessInfoUpdateService *)service
{
    if (!_service) {
        _service = [[BusinessInfoUpdateService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

//上传接口
-(void)uploadBtnMethod{
    [self displayOverFlowActivityView];
    [self.service beginUpload:self.SHData];
}

//保存
-(void)saveBtnMethod{
    BusinessSavedDAO *saveDAO = [[BusinessSavedDAO alloc]init];
    if ([saveDAO writeProductToDB:self.SHData]) {
        [self displayOverFlowActivityView:@"保存成功" maxShowTime:0.1];
    }
    else{
        [self displayOverFlowActivityView:@"保存失败" maxShowTime:0.1];
    }
}

//获取问题信息接口
-(void)getIssuedBusinessInfoServiceResult:(BusinessInfoUpdateService *)service
                                   Result:(BOOL)isSuccess_
                                 errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    self.SHData = self.service.issueData;
//    [self.tableView reloadData];
    
    [self displayOverFlowActivityView:@"获取问题图片"];
    [self.service downLoadFileWithFlowID:self.service.issueData.flowId];
    
    
}

-(void)getBusinessInfoUpdateServiceResult:(BusinessInfoUpdateService *)service
                                   Result:(BOOL)isSuccess_
                                 errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    [self presentCustomDlg:errorMsg];
}

-(void)getIssuedBusinessPictureServiceResult:(BusinessInfoUpdateService *)service
                                      Result:(BOOL)isSuccess_
                                    errorMsg:(NSString *)errorMsg{
    [self removeOverFlowActivityView];
    [self presentCustomDlg:@"下载成功"];
    
    
    NSString* docPath = [FCFileManager pathForDocumentsDirectory];
    //NSString *zipPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/zipfile.zip"];
    NSString *zipPath = [NSString stringWithFormat:@"%@/zipfile.zip",docPath];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
//    NSString *zipPath = [path stringByAppendingPathComponent:@"zipfile.zip"];
    //check if file exist and returns YES or NO
    BOOL testFileExists = [FCFileManager existsItemAtPath:@"zipfile.zip"];
    NSLog(@"File Exist %d",testFileExists);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        ZipArchive *za = [[ZipArchive alloc] init];
        if ([za UnzipOpenFile: zipPath])
        {
            BOOL ret = [za UnzipFileTo:path overWrite: YES];
            if (NO == ret){} [za UnzipCloseFile];

        
            NSString *image1FilePath = [path stringByAppendingPathComponent:@"1.png"];
            self.SHData.photo_business_permit = [NSData dataWithContentsOfFile:image1FilePath options:0 error:nil];
        
            NSString *image2FilePath = [path stringByAppendingPathComponent:@"2.png"];
            self.SHData.photo_identifier_front = [NSData dataWithContentsOfFile:image2FilePath options:0 error:nil];
            
            NSString *image3FilePath = [path stringByAppendingPathComponent:@"3.png"];
            self.SHData.photo_identifier_back = [NSData dataWithContentsOfFile:image3FilePath options:0 error:nil];
            
            NSString *image4FilePath = [path stringByAppendingPathComponent:@"4.png"];
            self.SHData.photo_business_place = [NSData dataWithContentsOfFile:image4FilePath options:0 error:nil];
            
            NSString *image5FilePath = [path stringByAppendingPathComponent:@"5.png"];
            self.SHData.photo_bankcard_front = [NSData dataWithContentsOfFile:image5FilePath options:0 error:nil];
            
            NSString *image6FilePath = [path stringByAppendingPathComponent:@"6.png"];
            self.SHData.photo_bankcard_back = [NSData dataWithContentsOfFile:image6FilePath options:0 error:nil];
            
            NSString *image7FilePath = [path stringByAppendingPathComponent:@"7.png"];
            self.SHData.photo_contracts = [NSData dataWithContentsOfFile:image7FilePath options:0 error:nil];
            
            
        }
        else
        {
                NSLog(@"Error saving file ");
        }
    });
}

-(void)selectPhotoGroup:(UIButton *)btn
{
    //实例化Controller
    UIImagePickerController*picker;
    if (!picker) {
        picker = [[UIImagePickerController alloc]init];
        //设置代理
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

-(void)selectCamera:(UIButton *)btn
{
    //实例化Controller
    UIImagePickerController*picker;
    if (!picker) {
        picker = [[UIImagePickerController alloc]init];
        //设置代理
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
    
    //开启相机模式之前需要判断相机是否可用
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
}

#pragma mark -- UIImagePickerControllerDelegate 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *photoImages=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    NSData *imageData = UIImageJPEGRepresentation(photoImages, 0.5);
    
    
    if ( nSelectIndex == 1 ) {
        self.SHData.photo_business_permit = imageData;
    }
    else if ( nSelectIndex == 2 ) {
        self.SHData.photo_identifier_front= imageData;
    }
    else if ( nSelectIndex == 3 ) {
        self.SHData.photo_identifier_back= imageData;
    }
    else if ( nSelectIndex == 4 ) {
        self.SHData.photo_business_place= imageData;
    }
    else if ( nSelectIndex == 5 ) {
        self.SHData.photo_bankcard_front= imageData;
    }
    else if ( nSelectIndex == 6 ) {
        self.SHData.photo_bankcard_back= imageData;
    }
    else if ( nSelectIndex == 7 ) {
        self.SHData.photo_contracts= imageData;
    }

    subVc.imageData = imageData;
//    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"212",@"image", nil];
//    NSNotification *notification =[NSNotification notificationWithName:@"helloPic" object:nil userInfo:dict];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end
