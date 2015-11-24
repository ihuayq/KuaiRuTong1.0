//
//  NewBusinessViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/9.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "NewBusinessViewController.h"
//#import "ShowImageViewController.h"
#import "SHInfoViewController.h"
#import "NewSHCell.h"
#import "FileManager.h"
#import "BusinessInfoUpdateService.h"
#import "FCFileManager.h"
#import "ZipArchive.h"
#import "BusinessSavedDAO.h"

static NSArray *titlesArray = nil;

@interface NewBusinessViewController ()<UIImagePickerControllerDelegate,BusinessInfoUpdateServiceDelegate>{
    UITableView *newTableView;  //新建商户列表信息
    NSInteger currentPhotoTag;  //当前图片标识
    UIButton *uploadBtn;        //上传按钮
    UIButton *saveBtn;          //保存按钮
    
    NSMutableArray *photosArray;       //相片是否保存数组
    
    UIImage *photoImages;
    
    NSMutableDictionary *businessTextInfoDic;       //商户详细文字信息
    
}

@end

@implementation NewBusinessViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    if (titlesArray  == nil) {
        titlesArray = [[NSArray alloc] initWithObjects:@"商户信息填写",@"营业执照",@"身份证证面",@"身份证反面",@"店面照",@"结算卡正面",@"结算卡反面",@"合同照片", nil];
    }
    
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
    
    photosArray[0] = @"no";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.title = @"添加商户";

    newTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth,44*8 +10 ) style:UITableViewStylePlain];
    newTableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    newTableView.dataSource = self;
    newTableView.delegate  = self;
    newTableView.scrollEnabled = YES;
    newTableView.rowHeight = 44.0;
    [self.view addSubview:newTableView];
    
    uploadBtn = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth/4 - MainWidth/6,newTableView.origin.y + newTableView.size.height + 10,MainWidth/3,40)];
    //[cancelButton setFrame:CGRectMake(40,MainHeight -200, MainWidth-2*40, 40)];
    [uploadBtn addTarget:self action:@selector(uploadBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [uploadBtn setTitle:@"上   传" forState:UIControlStateNormal];
    [uploadBtn.layer setMasksToBounds:YES]; 
    [uploadBtn.layer setCornerRadius:uploadBtn.frame.size.height/2.0f]; //设置矩形四个圆角半径
    uploadBtn.backgroundColor = ORANGE_COLOR;
    [self.view  insertSubview:uploadBtn aboveSubview:newTableView];

    // MainHeight - 48 - NAVIGATION_OUTLET_HEIGHT
    saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth/2 + MainWidth/4 - MainWidth/6 , newTableView.origin.y + newTableView.size.height + 10, MainWidth/3, 40)];
    [saveBtn addTarget:self action:@selector(saveBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitle:@"保   存" forState:UIControlStateNormal];
    saveBtn.backgroundColor = ORANGE_COLOR;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn.layer setCornerRadius:uploadBtn.frame.size.height/2.0f];
    [self.view insertSubview:saveBtn aboveSubview:newTableView];

}


- (BusinessInfoUpdateService *)service
{
    if (!_service) {
        _service = [[BusinessInfoUpdateService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (SHDataItem *)shData
{
    if (!_shData) {
        _shData = [[SHDataItem alloc] init];
    }
    return _shData;
}

-(void)getCityAndMccInfoServiceResult:(BusinessInfoUpdateService *)service
                               Result:(BOOL)isSuccess_
                             errorMsg:(NSString *)errorMsg
{
    
}


#pragma --PrivateMethods

//- (void) viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    dispatch_queue_t queue = dispatch_get_global_queue(
//                                                       DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        NSURL *url = [NSURL URLWithString:@"http://www.icodeblog.com/wp-content/uploads/2012/08/zipfile.zip"];
//        NSError *error = nil;
//        NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
//        
//        if(!error)
//        {
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//            NSString *path = [paths objectAtIndex:0];
//            NSString *zipPath = [path stringByAppendingPathComponent:@"zipfile.zip"];
//            
//            [data writeToFile:zipPath options:0 error:&error];
//            
//            if(!error)
//            {
//                ZipArchive *za = [[ZipArchive alloc] init];
//                if ([za UnzipOpenFile: zipPath]) {
//                    BOOL ret = [za UnzipFileTo: path overWrite: YES];
//                    if (NO == ret){} [za UnzipCloseFile];
//                    
//                    NSString *imageFilePath = [path stringByAppendingPathComponent:@"photo.png"];
//                    NSString *textFilePath = [path stringByAppendingPathComponent:@"text.txt"];
//                    NSData *imageData = [NSData dataWithContentsOfFile:imageFilePath options:0 error:nil];
//                    UIImage *img = [UIImage imageWithData:imageData];
//                    NSString *textString = [NSString stringWithContentsOfFile:textFilePath encoding:NSASCIIStringEncoding error:nil];
//                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        self.imageView.image = img;
//                        self.label.text = textString;
//                    });
//                }
//            }
//            else
//            {
//                NSLog(@"Error saving file %@",error);
//            }
//        }
//        else
//        {
//            NSLog(@"Error downloading zip file: %@", error);
//        }
//        
//    });
//}
//
//- (IBAction)zipFilesButtonPressed:(id)sender
//{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docspath = [paths objectAtIndex:0];
//    paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *cachePath = [paths objectAtIndex:0];
//    
//    NSString *zipFile = [docspath stringByAppendingPathComponent:@"newzipfile.zip"];
//    
//    ZipArchive *za = [[ZipArchive alloc] init];
//    [za CreateZipFile2:zipFile];
//    
//    NSString *imagePath = [cachePath stringByAppendingPathComponent:@"photo.png"];
//    NSString *textPath = [cachePath stringByAppendingPathComponent:@"text.txt"];
//    
//    [za addFileToZip:imagePath newname:@"NewPhotoName.png"];
//    [za addFileToZip:textPath newname:@"NewTextName.txt"];
//    
//    BOOL success = [za CloseZipFile2];
//    
//    NSLog(@"Zipped file with result %d",success);
//    
//}
#pragma private
-(BOOL)checkDataValid{
    //check if file exist and returns YES or NO
    for (int i = 1 ;i < photosArray.count ; i++) {
        BOOL testFileExists = [FCFileManager existsItemAtPath:[NSString stringWithFormat:@"%d.jpg",i]];
        if (!testFileExists) {
            
            DLog(@"The pic %i is not exist!",i);
            //检查图片的
            [self presentCustomDlg:@"缺失图片"];
            return NO;
        }
    }
    
//    //上传数据
//    if (businessTextInfoDic.count == 0) {
//        [self presentCustomDlg:@"商户详细信息缺失"];
//        return  NO;
//    }
    
    return YES;
}

/**
 *  上传方法
 */
- (void)uploadBtnMethod{

    if (![self checkDataValid]) {
        return;
    }
    
    //NSArray*ls = [FCFileManager listDirectoriesInDirectoryAtPath: [FCFileManager pathForDocumentsDirectory]];
    //DLog(@"The path list is %@!", [FCFileManager pathForDocumentsDirectory]);
    NSString* docPath = [FCFileManager pathForDocumentsDirectory];
    
    ZipArchive *za = [[ZipArchive alloc] init];
    [za CreateZipFile2: [NSString stringWithFormat:@"%@/zipfile.zip",docPath]];
    
    for (int i = 1 ;i < photosArray.count ; i++) {
        [za addFileToZip:[NSString stringWithFormat:@"%@/%d.jpg",docPath,i] newname:[NSString stringWithFormat:@"new_%d.jpg",i]];
    }
    
    BOOL success = [za CloseZipFile2];
    NSLog(@"Zipped file with result %d",success);
    
    
//    NSNumber *fileSize = [FCFileManager sizeOfFileAtPath:@"zipfile.zip"];
//    DLog(@"The size is %@!", fileSize);
    
    NSMutableDictionary *infoDic = [[NSMutableDictionary alloc] init];
    //商户名
    [infoDic setObject:self.shData.shop_name forKey:@"shop_name"];
    //mcc
    [infoDic setObject:self.shData.industry forKey:@"industry"];
    [infoDic setObject:self.shData.industry_subclass forKey:@"industry_subclass"];
    [infoDic setObject:self.shData.mcc forKey:@"mcc"];
    [infoDic setObject:self.shData.account_name forKey:@"account_name"];
    //邀请码
    [infoDic setObject:self.shData.pub_pri forKey:@"pub_pri"];
    [infoDic setObject:self.shData.invitation_code forKey:@"invitation_code"];
    //银行卡信息
    [infoDic setObject:self.shData.bank_card_num forKey:@"bank_card_num"];
    [infoDic setObject:self.shData.bank_province forKey:@"bank_province"];
    [infoDic setObject:self.shData.bank_city forKey:@"bank_city"];
    [infoDic setObject:self.shData.bank_add forKey:@"bank_add"];
    //手机号
    [infoDic setObject:@"" forKey:@"phone_num"];
    [infoDic setObject:@"" forKey:@"phone_verify"];
    //网点信息
    [infoDic setObject:self.shData.pos_code forKey:@"pos_code"];
    [infoDic setObject:self.shData.branch_add  forKey:@"branch_add"];

    //推销员登陆名
    [infoDic setObject: @"Test-办事处销售陈玉洁" forKey:@"name"];
    
    [self displayOverFlowActivityView];
    [self.service beginUpload:infoDic filePath:@"zipfile.zip"];
}

/**
 *  保存方法
 */
- (void)saveBtnMethod{
    if (![self checkDataValid]) {
        return;
    }
    
    self.shData.photo_business_permit = [FCFileManager readFileAtPathAsData:@"1.jpg"];
    self.shData.photo_identifier_front =  [FCFileManager readFileAtPathAsData:@"2.jpg"];
    self.shData.photo_identifier_back = [FCFileManager readFileAtPathAsData:@"3.jpg"];
    self.shData.photo_business_place = [FCFileManager readFileAtPathAsData:@"4.jpg"];
    self.shData.photo_bankcard_front = [FCFileManager readFileAtPathAsData:@"5.jpg"];
    self.shData.photo_bankcard_back = [FCFileManager readFileAtPathAsData:@"6.jpg"];
    self.shData.photo_contracts =[FCFileManager readFileAtPathAsData:@"7.jpg"];
    
    BusinessSavedDAO *saveDAO = [[BusinessSavedDAO alloc]init];
    if ([saveDAO writeProductToDB:self.shData]) {
        [self displayOverFlowActivityView:@"保存成功" maxShowTime:0.1];
    }
    else{
        [self displayOverFlowActivityView:@"保存失败" maxShowTime:0.1];
    }
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
        //是否保存按钮
        UIButton * cunButton= [[UIButton alloc] initWithFrame:CGRectMake(MainWidth - 60 , 4, 36, 36)];
        [cunButton addTarget:self action:@selector(buttonPressedAction:event:) forControlEvents:UIControlEventTouchUpInside];
        if (indexPath.row == 0) {
            [cunButton setBackgroundImage:[UIImage imageNamed:@"addInfo"] forState:UIControlStateNormal];
        }
        else{
            [cunButton setBackgroundImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
        }

        cunButton.layer.masksToBounds = YES;
        cell.accessoryView = cunButton;
    }
    cell.nIndex = indexPath.row;
    
    if([photosArray[indexPath.row] isEqualToString:@"yes"]){
        cell.bShowSuccessImg= YES;
    }
    
    //cell.bShowSuccessImg= YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//    }else{
//    }
}

- (void)buttonPressedAction:(id)sender event:(id)event
{
    UIButton *button = (UIButton *)sender;
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:newTableView];
    
    NSIndexPath *indexPath = [newTableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil)
    {
        
        if (indexPath.row == 0 ) {
            SHInfoViewController *vc = [[SHInfoViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.item = self.shData;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            UIActionSheet *sheetImage = [[UIActionSheet alloc]initWithTitle:@"请选择方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
            sheetImage.tag = indexPath.row;
            [sheetImage showInView:[UIApplication sharedApplication].keyWindow];
        }
    }
}


#pragma mark -- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    currentPhotoTag = actionSheet.tag;
    if (buttonIndex != 2) {
        //实例化Controller
        UIImagePickerController*picker;
        if (!picker) {
            picker = [[UIImagePickerController alloc]init];
            //设置代理
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
        
        //默认选择是相册
        if (buttonIndex == 0) {
            //开启相机模式之前需要判断相机是否可用
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
        }
    }
}

#pragma mark -- UIImagePickerControllerDelegate 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
   
    photoImages=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSData *imageData = UIImageJPEGRepresentation(photoImages, 0.5);
    NSString *nameString =  [NSString stringWithFormat:@"%ld.jpg",(long)currentPhotoTag];
    DLog(@"The pic name is%@",nameString);
    
    BOOL success = [FCFileManager createFileAtPath:nameString withContent:imageData];
    if (success) {
        DLog(@"The pic create success :%b",success);
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [photosArray replaceObjectAtIndex:(currentPhotoTag) withObject:@"yes"];
        [userDefaults setObject:photosArray forKey:@"photosTempArray"];
        [userDefaults synchronize];
        //[self.navigationController popViewControllerAnimated:YES];
        
        [newTableView reloadData];
    }
    
    

//    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"SHPhotosTemp"];
//    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    // 获取GroupPPTTemp文件夹 下的文件
//    if (bo) {
//        //图片压缩
//        FileManager *fileManager = [[FileManager alloc] init];
//        //压缩参数选择0.5
//        NSData *imageData = UIImageJPEGRepresentation(photoImages, 0.5);
//        NSString *nameString =  [NSString stringWithFormat:@"%ld.jpg",(long)currentPhotoTag];
//        DLog(@"The pic name is%@",nameString);
//        [fileManager writeDataForSHTemp:imageData andName:nameString];
//        
//        [FCFileManager createFileAtPath:@"test.txt" withContent:@"File management has never been so easy!!!"];
//        //[data writeToFile:path atomically:YES];
//        
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [photosArray replaceObjectAtIndex:(currentPhotoTag) withObject:@"yes"];
//        [userDefaults setObject:photosArray forKey:@"photosTempArray"];
//        [userDefaults synchronize];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    
//    [newTableView reloadData];
}

//#pragma mark -- CustomNavBarDelegate
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
