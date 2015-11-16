//
//  SHDetailViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/12.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDSearchCell.h"
#import "SuperViewController.h"
@interface SHDetailViewController : SuperViewController<UITableViewDataSource,UITableViewDelegate,WDSerarchCellDelegate>
@property (nonatomic, strong) NSDictionary *resultsDic;
@end
