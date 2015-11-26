//
//  QueryWorkingStatusViewController.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/25.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkingStatusDataService.h"

@interface QueryWorkingStatusViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource>

//搜索条件
@property(nonatomic,copy) NSString* shop_name;
@property(nonatomic,copy) NSString* shop_code;

@property(nonatomic,strong)  WorkingStatusDataService *service;

@end
