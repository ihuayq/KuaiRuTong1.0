//
//  WDSearchCell.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/12.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WDSerarchCellDelegate;
@interface WDSearchCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, assign)id<WDSerarchCellDelegate> Delegate;
@end

@protocol WDSerarchCellDelegate <NSObject>

- (void)addButtonDelegate;

@end