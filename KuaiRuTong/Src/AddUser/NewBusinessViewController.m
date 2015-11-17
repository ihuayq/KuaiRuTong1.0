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



static NSArray *titlesArray = nil;

@interface NewBusinessViewController ()<UIImagePickerControllerDelegate>{
    UITableView *newTableView;  //新建商户列表信息
    //NSArray *titlesArray;       //标题数组
    NSInteger currentPhotoTag;  //当前图片标识
    UIButton *uploadBtn;        //上传按钮
    UIButton *saveBtn;          //保存按钮
    
    NSMutableArray *photosArray;       //相片是否保存数组
    
    UIImage *photoImages;
    
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
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:@"yes" forKey:@"isSaveNewBussinss"];
//    [userDefaults synchronize];
//    hud_SuperVC.labelText = @"保存成功";
//    [hud_SuperVC show:YES];
//    [hud_SuperVC hide:YES afterDelay:2];
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
////        UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
////        SHInfoViewController *childController = [board instantiateViewControllerWithIdentifier: @"SHInfoVC"];
////        [self.navigationController pushViewController:childController animated:YES];
//    }else{
//        ShowImageViewController *childController = [[ShowImageViewController alloc] init];
//        childController.navTitle = titlesArray[indexPath.row];
//        childController.currentPhotoTag = indexPath.row;
//        childController.isTakePhoto = NO;
//        [self.navigationController pushViewController:childController animated:YES];
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
            picker.delegate= self;
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
    
    
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"SHPhotosTemp"];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    // 获取GroupPPTTemp文件夹 下的文件
    if (bo) {
        //图片压缩
        FileManager *fileManager = [[FileManager alloc] init];
        NSData *imageData = UIImageJPEGRepresentation(photoImages, 0.0001);
        NSString *nameString =  [NSString stringWithFormat:@"%ld.jpg",(long)currentPhotoTag];
        [fileManager writeDataForSHTemp:imageData andName:nameString];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [photosArray replaceObjectAtIndex:(currentPhotoTag) withObject:@"yes"];
        [userDefaults setObject:photosArray forKey:@"photosTempArray"];
        [userDefaults synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [newTableView reloadData];
    
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
