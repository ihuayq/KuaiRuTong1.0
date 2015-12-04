//
//  TimeLineItem.h
//  KuaiRuTong
//
//  Created by huayq on 15/12/4.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "RETableViewItem.h"

@interface TimeLineItem : RETableViewItem

@property (assign, readwrite, nonatomic) int nIndex;
@property (strong, readwrite, nonatomic) NSArray *descriptions;

+ (TimeLineItem *)itemWithDescriptions:(NSArray *)descriptions andPos:(int)index;
@end
