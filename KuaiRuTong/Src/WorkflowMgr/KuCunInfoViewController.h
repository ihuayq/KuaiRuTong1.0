//
//  KuCunInfoViewController.h
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/26.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KuCunData.h"
#import "KuCuDataService.h"
typedef void (^delCelllock)(int index);

@interface KuCunInfoViewController : CommonViewController


@property(nonatomic,assign) int index;

@property(nonatomic,strong) KuCunData *model;

@property(nonatomic,strong)  KuCuDataService *service;
@property (strong, nonatomic)  delCelllock block;

@end
