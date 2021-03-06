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
@class BusinessInfoUpdateService;

@interface CateViewController : CommonViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)  BusinessInfoUpdateService *service;

@property (strong, nonatomic) NSArray *cates;
@property (strong, nonatomic) UIFolderTableView *tableView;

@property (strong, nonatomic) NSString *shopName; //外部必传参数，商户名称

@property (strong, nonatomic) SHDataItem *SHData;

//区分类型，可能来源于本地保存，也可能是服务器的问题流程
@property (nonatomic, assign) int nType;

@end
