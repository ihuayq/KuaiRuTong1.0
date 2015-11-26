//
//  QueryKuCunViewController.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/26.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KuCuDataService.h"

@interface QueryKuCunViewController : CommonViewController


//搜索条件
@property(nonatomic,copy) NSString* shop_name;
@property(nonatomic,copy) NSString* shop_code;
@property(nonatomic,copy) NSString* pos_code;
@property(nonatomic,copy) NSString* pos_status;

@property(nonatomic,strong)  KuCuDataService *service;

@end
