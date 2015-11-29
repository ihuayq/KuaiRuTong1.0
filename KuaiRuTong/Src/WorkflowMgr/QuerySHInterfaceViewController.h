//
//  QuerySHInterfaceViewController.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/25.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSearchDataService.h"

@interface QuerySHInterfaceViewController : CommonViewController

//搜索条件
@property(nonatomic,copy) NSString* shop_name;
@property(nonatomic,copy) NSString* shop_code;
@property(nonatomic,copy) NSString* pos_code;

@property(nonatomic,strong)  SHSearchDataService *service;

@end
