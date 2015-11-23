//
//  CateViewController.h
//  top100
//
//  Created by Dai Cloud on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"

@class SHDataItem;

@interface CateViewController : CommonViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *cates;
@property (strong, nonatomic) UIFolderTableView *tableView;

@property (strong, nonatomic) NSString *shopName; //外部必传参数，商户名称

@property (strong, nonatomic) SHDataItem *SHData;

@end
