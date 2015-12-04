//
//  TimeLineItem.m
//  KuaiRuTong
//
//  Created by huayq on 15/12/4.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "TimeLineItem.h"

@implementation TimeLineItem


+ (TimeLineItem *)itemWithDescriptions:(NSArray *)descriptions andPos:(int)index
{
    TimeLineItem *item = [[TimeLineItem alloc] init];
    item.descriptions = descriptions;
    item.nIndex  = index;
    return item;
}


@end
