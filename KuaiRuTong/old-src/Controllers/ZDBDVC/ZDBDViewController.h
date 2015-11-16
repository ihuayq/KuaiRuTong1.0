//
//  ZDBDViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanView.h"
#import "CustomNavBar.h"
#import "ZDBDView.h"
#import "MBProgressHUD.h"
@interface ZDBDViewController : UIViewController<CustomNavBarDelegate,ScanViewDelegate,ZDBDViewDelegate,MBProgressHUDDelegate>
@end
