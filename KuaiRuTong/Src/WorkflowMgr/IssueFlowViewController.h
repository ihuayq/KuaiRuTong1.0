//
//  IssueFlowViewController.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/30.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIFolderTableView.h"

@class SHDataItem;
@class BusinessInfoUpdateService;

@interface IssueFlowViewController : CommonViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)  BusinessInfoUpdateService *service;

@property (strong, nonatomic) NSArray *cates;
@property (strong, nonatomic) UIFolderTableView *tableView;

@property (strong, nonatomic) NSString *shopName; //外部必传参数，商户名称

@property (strong, nonatomic) SHDataItem *SHData;

//区分类型，可能来源于本地保存，也可能是服务器的问题流程
@property (nonatomic, assign) int nType;

@end
