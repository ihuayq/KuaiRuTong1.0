//
//  SHSearchCell.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/12.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "SHSearchResultCell.h"
#import "DeviceManager.h"
#import "SHResultData.h"

@interface SHSearchResultCell(){
    UILabel * FirstLabel;
    UILabel * SecondLabel;
    UILabel * ThirdLabel;
    
    UILabel * FourthLabel;
}


@end

@implementation SHSearchResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float width = MainWidth/3;
        
        FirstLabel =  [[UILabel alloc] initWithFrame:CGRectMake(20,0,MainWidth,30)];;
        FirstLabel.textAlignment = NSTextAlignmentLeft;
        FirstLabel.backgroundColor = [UIColor clearColor];
//        FirstLabel.text = @"商户名称";
        FirstLabel.font = [UIFont systemFontOfSize:18.0f];
        [self.contentView addSubview:FirstLabel];
        
        CGFloat heightWithGap = FirstLabel.size.height + FirstLabel.origin.y + 4;
        //商户编号
        UILabel *shopCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, heightWithGap ,width,20)];;
        shopCodeLabel.textAlignment = NSTextAlignmentLeft;
        shopCodeLabel.backgroundColor = [UIColor clearColor];
        shopCodeLabel.text = @"商户编码";
        shopCodeLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:shopCodeLabel];
        
        SecondLabel =  [[UILabel alloc] initWithFrame:CGRectMake(width*0,shopCodeLabel.size.height + shopCodeLabel.origin.y,width,30)];;
        SecondLabel.textAlignment = NSTextAlignmentCenter;
        SecondLabel.backgroundColor = [UIColor clearColor];
        SecondLabel.font = [UIFont systemFontOfSize:18.0f];
        [self.contentView addSubview:SecondLabel];
        
        //机身序列号
        UILabel *machineCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*1,heightWithGap,width,20)];;
        machineCodeLabel.textAlignment = NSTextAlignmentCenter;
        machineCodeLabel.backgroundColor = [UIColor clearColor];
        machineCodeLabel.text = @"机身序列号";
        machineCodeLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:machineCodeLabel];
        
        ThirdLabel =  [[UILabel alloc] initWithFrame:CGRectMake(width*1,machineCodeLabel.size.height + machineCodeLabel.origin.y,width,30)];
        ThirdLabel.textAlignment = NSTextAlignmentCenter;
        ThirdLabel.backgroundColor = [UIColor clearColor];
        ThirdLabel.font = [UIFont systemFontOfSize:18.0f];
        [self.contentView addSubview:ThirdLabel];
        
        //商户状态
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*2,heightWithGap ,width,20)];;
        statusLabel.textAlignment = NSTextAlignmentCenter;
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.text = @"商户状态";
        statusLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:statusLabel];
        
        FourthLabel =  [[UILabel alloc] initWithFrame:CGRectMake(width*2,statusLabel.size.height + statusLabel.origin.y,width,30)];;
        FourthLabel.textAlignment = NSTextAlignmentCenter;
        FourthLabel.backgroundColor = [UIColor clearColor];
        //FourthLabel.textColor = [UIColor whiteColor];
        FourthLabel.font = [UIFont systemFontOfSize:18.0f];
        [self.contentView addSubview:FourthLabel];
        
    }
    return self;
}

-(void)setModel:(SHResultData *)model{
    _model = model;
    
    FirstLabel.text = [NSString stringWithFormat:@"商户名称:%@",model.mercName];
    SecondLabel.text = model.mercNum;
    ThirdLabel.text = model.machine_code;
    FourthLabel.text = model.mercSta;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
