//
//  QueryKuCunTableViewCell.h
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/26.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KuCunData.h"

@interface QueryKuCunTableViewCell : UITableViewCell

@property(nonatomic,strong) KuCunData *model;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
