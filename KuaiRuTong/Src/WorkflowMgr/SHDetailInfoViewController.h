//
//  SHDetailInfoViewController.h
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/29.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSearchDataService.h"

@interface SHDetailInfoViewController : CommonViewController

@property(nonatomic,copy) NSString *strMerNo;
@property(nonatomic,strong)  SHSearchDataService *service;

@end
