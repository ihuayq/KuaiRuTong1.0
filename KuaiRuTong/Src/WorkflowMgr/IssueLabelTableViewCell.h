//
//  IssueLabelTableViewCell.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/30.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHDataItem.h"

@interface IssueLabelTableViewCell : UITableViewCell

@property(nonatomic,strong) SHDataItem *model;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
