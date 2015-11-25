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
        
        FirstLabel =  [[UILabel alloc] initWithFrame:CGRectMake(20,0,MainWidth,40)];;
        FirstLabel.textAlignment = NSTextAlignmentCenter;
        FirstLabel.backgroundColor = [UIColor clearColor];
//        FirstLabel.text = @"商户名称";
        FirstLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:FirstLabel];
        
        //商户编号
        UILabel *shopCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0,FirstLabel.size.height + FirstLabel.origin.y + 10,width,30)];;
        shopCodeLabel.textAlignment = NSTextAlignmentCenter;
        shopCodeLabel.backgroundColor = [UIColor clearColor];
        shopCodeLabel.text = @"商户编码";
        shopCodeLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:shopCodeLabel];
        
        SecondLabel =  [[UILabel alloc] initWithFrame:CGRectMake(width*0,shopCodeLabel.size.height + shopCodeLabel.origin.y,width,40)];;
        SecondLabel.textAlignment = NSTextAlignmentCenter;
        SecondLabel.backgroundColor = [UIColor clearColor];
        SecondLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:SecondLabel];
        
        //机身序列号
        UILabel *machineCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*1,FirstLabel.size.height + FirstLabel.origin.y + 10,width,30)];;
        machineCodeLabel.textAlignment = NSTextAlignmentCenter;
        machineCodeLabel.backgroundColor = [UIColor clearColor];
        machineCodeLabel.text = @"机身序列号";
        machineCodeLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:machineCodeLabel];
        
        ThirdLabel =  [[UILabel alloc] initWithFrame:CGRectMake(width*1,machineCodeLabel.size.height + machineCodeLabel.origin.y,width,40)];
        ThirdLabel.textAlignment = NSTextAlignmentCenter;
        ThirdLabel.backgroundColor = [UIColor clearColor];
        ThirdLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:ThirdLabel];
        
        //商户状态
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*2,FirstLabel.size.height + FirstLabel.origin.y + 10,width,30)];;
        statusLabel.textAlignment = NSTextAlignmentCenter;
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.text = @"商户状态";
        statusLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:statusLabel];
        
        FourthLabel =  [[UILabel alloc] initWithFrame:CGRectMake(width*2,statusLabel.size.height + statusLabel.origin.y,width,40)];;
        FourthLabel.textAlignment = NSTextAlignmentCenter;
        FourthLabel.backgroundColor = [UIColor clearColor];
        //FourthLabel.textColor = [UIColor whiteColor];
        FourthLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:FourthLabel];
        
    }
    return self;
}

-(void)setModel:(SHResultData *)model{
    _model = model;
    
    FirstLabel.text = [NSString stringWithFormat:@"商户名称:%@",model.shop_name];
    SecondLabel.text = model.shop_code;
    ThirdLabel.text = model.machine_code;
    FourthLabel.text = model.status;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
