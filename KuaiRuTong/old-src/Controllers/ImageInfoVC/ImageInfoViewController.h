//
//  ImageInfoViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/16.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavBar.h"
#import "MBProgressHUD.h"
@interface ImageInfoViewController : UIViewController<CustomNavBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,MBProgressHUDDelegate>
@property (nonatomic, strong)NSDictionary *imageInfoDic;
@end
