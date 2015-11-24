//
//  NewBusinessViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/9.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHDataItem;

@class BusinessInfoUpdateService;

@interface NewBusinessViewController : CommonViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>


//上传接口
@property(nonatomic,strong)  BusinessInfoUpdateService *service;
@property(nonatomic,strong)  SHDataItem *shData;


@end
