//
//  NewBusinessViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/9.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
@interface NewBusinessViewController : SuperViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSString *pendingType;
@end
