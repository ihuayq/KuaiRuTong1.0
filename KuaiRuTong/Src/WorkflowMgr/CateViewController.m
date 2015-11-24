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
    
    BusinessSavedDAO *dao= [[BusinessSavedDAO alloc] init];
    self.SHData = [dao searchSHItemDAOFromDB:self.shopName];
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
    
    if ( indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNormal];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:CellIdentifier];
           
            UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(MainWidth -40, 6,30,30)];
            img.image = [UIImage imageNamed:@"addInfo"];
            [cell.contentView addSubview:img];
        
        }
        cell.textLabel.text = [self.cates objectAtIndex:indexPath.row];
        
        return cell;
    }
    else if (indexPath.row == 8)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNormal];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:CellIdentifier];
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
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
        return cell;
    }
    else
    {
        SHInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[SHInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        cell.title.text = [self.cates objectAtIndex:indexPath.row];
        
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

-(void)uploadBtnMethod{
    [self displayOverFlowActivityView];
    [self.service beginUpload:self.SHData];
}

-(void)saveBtnMethod{
    BusinessSavedDAO *saveDAO = [[BusinessSavedDAO alloc]init];
    if ([saveDAO writeProductToDB:self.SHData]) {
        [self displayOverFlowActivityView:@"保存成功" maxShowTime:0.1];
    }
    else{
        [self displayOverFlowActivityView:@"保存失败" maxShowTime:0.1];
    }
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
    
//    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"login", nil];
//    NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
//    for (int i=0;i<[self.navigationController.viewControllers count] ; i++)
//    {
//        UIViewController * Vc = [self.navigationController.viewControllers objectAtIndex:i];
//        DLog(@"CONTROLLER IS %@",Vc);
//        if([Vc isKindOfClass:[SubCateViewController class]])
//        {
////            settingNaturalManInfoViewController* info=[self.navigationController.viewControllers objectAtIndex:i];
////            [self.navigationController popToViewController:info
////                                                  animated:NO];
//            DLog(@"CONTROLLER IS %@",Vc);
//
//        }
//    }
    
//    UIViewController * Vc = [self appRootViewController];
//    DLog(@"CONTROLLER IS %@",Vc);
//    self.imageData = imageData;
//    self.image.image = [UIImage imageWithData:self.imageData];
//    [self.view bringSubviewToFront:self.image];
    //    NSString *nameString =  [NSString stringWithFormat:@"%ld.jpg",(long)currentPhotoTag];
    //    DLog(@"The pic name is%@",nameString);
    //
    //    BOOL success = [FCFileManager createFileAtPath:nameString withContent:imageData];
    //    if (success) {
    //        DLog(@"The pic create success :%b",success);
    //
    //        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //        [photosArray replaceObjectAtIndex:(currentPhotoTag) withObject:@"yes"];
    //        [userDefaults setObject:photosArray forKey:@"photosTempArray"];
    //        [userDefaults synchronize];
    //        //[self.navigationController popViewControllerAnimated:YES];
    //
    //        [newTableView reloadData];
    //    }
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
