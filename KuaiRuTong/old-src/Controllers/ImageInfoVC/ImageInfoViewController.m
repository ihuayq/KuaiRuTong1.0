//
//  ImageInfoViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/16.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "ImageInfoViewController.h"
#import "DeviceManager.h"
#import "FileManager.h"
#import "QuestionSHViewController.h"

@interface ImageInfoViewController (){
    UIButton *photoButton;
    UIButton *uploadButton;
    UIImageView *photoImageView;
    MBProgressHUD  *HUD_imageInfoVC;
}

@end

@implementation ImageInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicView];
}
- (void)loadBasicView{
    HUD_imageInfoVC = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    HUD_imageInfoVC.delegate = self;
    [self.navigationController.view addSubview:HUD_imageInfoVC];
    
    //标题栏
    CustomNavBar *customNavBar = [[CustomNavBar alloc] initWithFrame:CGRectMake(0, 0, 320 * WIDTH_SCALE, 60 * HEIGHT_SCALE + 20)];
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.text = _imageInfoDic[@"title"];
    customNavBar.Delegate = self;
    [self.view addSubview:customNavBar];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20 + 60 * HEIGHT_SCALE, 320 * WIDTH_SCALE, HEIGHT - 60 * HEIGHT_SCALE)];
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(45 * WIDTH_SCALE, 20 * HEIGHT_SCALE, 230 * WIDTH_SCALE, 250 * HEIGHT_SCALE)];
    photoImageView.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:photoImageView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 293 * HEIGHT_SCALE, 320 * WIDTH_SCALE, 112 * WIDTH_SCALE)];
    view.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:view];
    
    photoButton = [[UIButton alloc] initWithFrame:CGRectMake(32 * WIDTH_SCALE, 14 * HEIGHT_SCALE, 255 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
    photoButton.backgroundColor = [UIColor clearColor];
    [photoButton setTitle:@"相机/相册" forState:UIControlStateNormal];
    [photoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    photoButton.layer.borderWidth = 1;
    photoButton.layer.cornerRadius = 3;
    [photoButton addTarget:self action:@selector(photoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:photoButton];
    
    uploadButton = [[UIButton alloc] initWithFrame:CGRectMake(32 * WIDTH_SCALE, 74 * HEIGHT_SCALE, 255 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
    uploadButton.backgroundColor = [UIColor orangeColor];
    [uploadButton setTitle:@"上   传" forState:UIControlStateNormal];
    [uploadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    uploadButton.layer.borderWidth = 1;
    uploadButton.layer.cornerRadius = 3;
    [uploadButton addTarget:self action:@selector(uploadButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:uploadButton];
    
}

- (void)uploadButtonClicked{
    NSData *imageData = UIImageJPEGRepresentation(photoImageView.image, 0.0001);
    if (imageData != nil) {
        if (![DeviceManager isExistenceNetwork]) {
            HUD_imageInfoVC.mode = MBProgressHUDModeText;
            HUD_imageInfoVC.labelText = @"对不起,请先检查网络状态";
            [HUD_imageInfoVC show:YES];
            [HUD_imageInfoVC hide:YES afterDelay:2];
        }else{
            HUD_imageInfoVC.mode = MBProgressHUDModeIndeterminate;
            HUD_imageInfoVC.labelText = @"上传中...";
            [HUD_imageInfoVC show:YES];
            uploadButton.enabled = NO;
            uploadButton.backgroundColor = [UIColor lightGrayColor];
            HUD_imageInfoVC.mode = MBProgressHUDModeText;
            HUD_imageInfoVC.labelText = @"上传成功";
            //        [HUD_imageInfoVC show:YES];
            [HUD_imageInfoVC hide:YES afterDelay:2];
        }
        

    }else{
        HUD_imageInfoVC.mode = MBProgressHUDModeText;
        HUD_imageInfoVC.labelText = @"对不起,图片不能为空";
        [HUD_imageInfoVC show:YES];
        [HUD_imageInfoVC hide:YES afterDelay:2];
    }
    
    
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    if ([hud.labelText isEqualToString:@"上传成功"]) {
        uploadButton.enabled = YES;
        uploadButton.backgroundColor = [UIColor orangeColor];
        
        for (UIViewController *viewController in self.navigationController.viewControllers) {
            if ([viewController isKindOfClass:[QuestionSHViewController class]]) {
                [self.navigationController popToViewController:viewController animated:YES];
            }
        }
        
    }
}

- (void)photoButtonClicked{
    UIActionSheet *sheetImage = [[UIActionSheet alloc]initWithTitle:@"请选择方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    [sheetImage showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark -- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)
buttonIndex{
    
    //实例化Controller
    UIImagePickerController*picker;
    if (!picker) {
        picker = [[UIImagePickerController alloc]init];
        //设置代理
        picker.delegate=self;
        [self presentViewController:picker animated:YES completion:nil];
    }
    
    //默认选择是相册
    if (!buttonIndex) {
        //开启相机模式之前需要判断相机是否可用
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        }
    }
    
}
#pragma mark -- UIImagePickerControllerDelegate 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *photoImages=[info objectForKey:UIImagePickerControllerOriginalImage];
    [photoImageView setImage:photoImages];

//    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"UserPhotos"];
//    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//    // 获取GroupPPTTemp文件夹 下的文件
//    if (bo) {
//        FileManager *fileManager = [[FileManager alloc] init];
//        UIImage *originalImage = photoImageView.image;
//        NSData *imageData = UIImageJPEGRepresentation(originalImage, 0.0001);
//        NSString *nameString =  @"1.jpg";
//        [fileManager writeData:imageData andName:nameString];
//    }

  
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
