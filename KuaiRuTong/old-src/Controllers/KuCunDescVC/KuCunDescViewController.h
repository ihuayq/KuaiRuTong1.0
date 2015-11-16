//
//  KuCunDescViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/9/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "SuperViewController.h"

@interface KuCunDescViewController : SuperViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSDictionary *kuCunDescData;
@end
