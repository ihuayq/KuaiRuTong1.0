//
//  SHSearchCell.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/12.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHResultData;
@interface SHSearchResultCell : UITableViewCell{
    
}


@property(nonatomic,strong) SHResultData *model;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
