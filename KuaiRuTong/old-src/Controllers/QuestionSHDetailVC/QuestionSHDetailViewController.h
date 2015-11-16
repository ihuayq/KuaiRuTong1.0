//
//  QuestionSHDetailViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/15.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavBar.h"
@interface QuestionSHDetailViewController : UIViewController<CustomNavBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSDictionary *questionsDic;
@end
