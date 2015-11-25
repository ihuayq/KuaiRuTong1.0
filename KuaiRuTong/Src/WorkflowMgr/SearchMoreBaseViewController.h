//
//  SearchMoreBaseViewController.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/23.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchMoreBaseViewController:CommonViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)  WorkMgr_ENUM nSearchType;

@end
