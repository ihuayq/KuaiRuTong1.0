//
//  SuperViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/26.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CustomNavBar.h"
#import "DeviceManager.h"
#import "ViewModel.h"
@interface SuperViewController : CommonViewController<MBProgressHUDDelegate,CustomNavBarDelegate>{
    MBProgressHUD *hud_SuperVC;
    CustomNavBar *customNavBar;
    UIScrollView *scrollView;
}

- (void)hudWasHidden:(MBProgressHUD *)hud;
@end
