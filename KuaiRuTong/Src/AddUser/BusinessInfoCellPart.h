//
//  BMAccountCellInfo.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/8.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessInfoCellPart : NSObject
#pragma mark UITEXTFIELD 默认内容
@property (nonatomic,copy) NSString *placehold;

@property (nonatomic,copy) NSString *content;


-(BusinessInfoCellPart *)initWithPlacehold:(NSString *)placehold;

#pragma mark 带参数的静态对象初始化方法
+(BusinessInfoCellPart *)initWithPlacehold:(NSString *)placehold;

@end


@interface BusinessInfoCellGroup : NSObject

#pragma mark 分组描述
@property (nonatomic,copy) NSString *detail;

#pragma mark 组信息列表
@property (nonatomic,strong) NSMutableArray *groups;


-(BusinessInfoCellGroup *)initWithDetail:(NSString *)detail andContacts:(NSMutableArray *)groups;

+(BusinessInfoCellGroup *)initWithDetail:(NSString *)detail andContacts:(NSMutableArray *)groups;

@end