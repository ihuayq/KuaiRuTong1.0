//
//  TimeLineCell.h
//  KuaiRuTong
//
//  Created by huayq on 15/12/4.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "RETableViewCell.h"
#import "TimeLineItem.h"
#import "TimeLineViewControl.h"

@interface TimeLineCell : RETableViewCell

@property (strong, nonatomic) TimeLineViewControl *timeLineView;

@property (strong, nonatomic) TimeLineItem *item;

@end
