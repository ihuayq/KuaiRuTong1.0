//
//  UpdatePosTermianlToNetPointViewController.h
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/29.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSearchDataService.h"
#import "SHResultData.h"

@interface UpdatePosTermianlToNetPointViewController : CommonViewController

@property(nonatomic,copy)  NSString *merCode;
@property(nonatomic,copy)  NSString *shopName;

@property(nonatomic,strong)  SHSearchDataService *service;

@end
