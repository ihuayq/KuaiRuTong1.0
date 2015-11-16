//
//  ShowImageViewController.m
//  KuaiRuTong
//
//  Created by HKRT on 15/9/24.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import "ShowImageViewController.h"
#import "FileManager.h"
@interface ShowImageViewController (){
    NSMutableArray *photosTempArray;
    UIImage *photoImages;
    UIImageView *photoImageView;
  
}

@end

@implementation ShowImageViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_isTakePhoto == NO){
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([[userDefaults objectForKey:@"photosTempArray"] isKindOfClass:[NSArray class]]) {
            photosTempArray = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"photosTempArray"]];
            if ([[photosTempArray objectAtIndex:(_currentPhotoTag -1)] isEqualToString:@"yes"]) {
                NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"SHPhotosTemp"];
                NSString *nameString =  [NSString stringWithFormat:@"%ld.jpg",(long)self.currentPhotoTag];
                NSString *imagePath = [path stringByAppendingPathComponent:nameString];
                [photoImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
            }
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicView];
}
- (void)loadBasicView{
    //nav
    customNavBar.customSaveBtn.hidden = NO;
    customNavBar.backView.hidden = NO;
    customNavBar.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    customNavBar.titleLabel.text = [NSString stringWithFormat:@"请拍摄%@",self.navTitle];
    
    //uiimageview
    photoImageView = [ViewModel createImageViewWithFrame:CGRectMake(20, 20, 280, 300) ImageName:nil];
    photoImageView.backgroundColor = [UIColor lightGrayColor];
    photoImageView.layer.borderWidth = 1.0f;
    [scrollView addSubview:photoImageView];
    
    //保存按钮
    UIButton *takePhotoButton = [ViewModel createButtonWithFrame:CGRectMake(110, 350, 100, 40) ImageNormalName:nil ImageSelectName:nil Title:nil Target:self Action:@selector(takePhotoButtonClicked)];
    takePhotoButton.layer.masksToBounds = YES;
    takePhotoButton.layer.cornerRadius = 5.0f;
    takePhotoButton.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:takePhotoButton];
    
}
- (void)takePhotoButtonClicked{
    UIActionSheet *sheetImage = [[UIActionSheet alloc]initWithTitle:@"请选择方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    [sheetImage showInView:[UIApplication sharedApplication].keyWindow];

}


#pragma mark -- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)
buttonIndex{
    if (buttonIndex != 2) {
        //实例化Controller
        UIImagePickerController*picker;
        if (!picker) {
            picker = [[UIImagePickerController alloc]init];
            //设置代理
            picker.delegate=self;
            [self presentViewController:picker animated:YES completion:nil];
        }
        
        //默认选择是相册
        if (buttonIndex == 0) {
            //开启相机模式之前需要判断相机是否可用
            
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
                picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            }
        }

    }
    
}

#pragma mark -- UIImagePickerControllerDelegate 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    _isTakePhoto = YES;
    photoImages=[info objectForKey:UIImagePickerControllerOriginalImage];
    photoImageView.image = photoImages;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark -- CustomNavBarDelegate
- (void)dealWithBackButtonClickedMethod{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealWithSaveButtonClickedMethod{
    if (photoImages == nil) {
        hud_SuperVC.labelText = @"请拍摄照片";
        hud_SuperVC.mode = MBProgressHUDModeText;
        [hud_SuperVC show:YES];
        [hud_SuperVC hide:YES afterDelay:2];
    }else{
        NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"SHPhotosTemp"];
        BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        // 获取GroupPPTTemp文件夹 下的文件
        if (bo) {
            FileManager *fileManager = [[FileManager alloc] init];
            NSData *imageData = UIImageJPEGRepresentation(photoImages, 0.0001);
            NSString *nameString =  [NSString stringWithFormat:@"%ld.jpg",(long)self.currentPhotoTag];
            [fileManager writeDataForSHTemp:imageData andName:nameString];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [photosTempArray replaceObjectAtIndex:(_currentPhotoTag -1) withObject:@"yes"];
            [userDefaults setObject:photosTempArray forKey:@"photosTempArray"];
            [userDefaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }

    }
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
