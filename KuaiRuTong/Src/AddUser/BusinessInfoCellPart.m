//
//  BMAccountCellInfo.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/8.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BusinessInfoCellPart.h"

@interface BusinessInfoCellPart ()

@end

@implementation BusinessInfoCellPart
-(BusinessInfoCellPart *)initWithPlacehold:(NSString *)placehold{
    if (self=[super init]) {
        self.placehold=placehold;
     }
    return self;
}

+(BusinessInfoCellPart *)initWithPlacehold:(NSString *)placehold{
    BusinessInfoCellPart *cell = [[BusinessInfoCellPart alloc] initWithPlacehold:placehold];
    return cell;
}
@end


#pragma mark 分组描述
@implementation BusinessInfoCellGroup

-(BusinessInfoCellGroup *)initWithDetail:(NSString *)detail andContacts:(NSMutableArray *)groups{
    if (self=[super init]) {
        self.detail=detail;
        self.groups=groups;
    }
    return self;
}

+(BusinessInfoCellGroup *)initWithDetail:(NSString *)detail andContacts:(NSMutableArray *)groups{
    BusinessInfoCellGroup *group1=[[BusinessInfoCellGroup alloc]initWithDetail:detail andContacts:groups];
    return group1;
}
@end
