//
//  SHSearchViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/12.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
@interface SHSearchViewController : SuperViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSArray *resultsArray;
@end
