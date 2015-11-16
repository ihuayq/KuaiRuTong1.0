//
//  ZBJRKViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanView.h"
#import "ZBJRKView.h"
#import "SuperViewController.h"
@interface ZBJRKViewController : SuperViewController<UITextFieldDelegate ,CustomNavBarDelegate,MBProgressHUDDelegate,ScanViewDelegate,ZBJRKViewDelegate>

@end
