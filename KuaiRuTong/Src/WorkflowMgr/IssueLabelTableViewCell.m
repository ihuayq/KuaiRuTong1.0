//
//  IssueLabelTableViewCell.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/30.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "IssueLabelTableViewCell.h"

@interface IssueLabelTableViewCell ()
{
    UILabel * FirstLabel;
    UILabel * SecondLabel;
    UILabel * ThirdLabel;
}
@end

@implementation IssueLabelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float width = MainWidth/3;
        
        FirstLabel =  [[UILabel alloc] initWithFrame:CGRectMake(20,0,MainWidth,40)];;
        FirstLabel.textAlignment = NSTextAlignmentCenter;
        FirstLabel.backgroundColor = [UIColor clearColor];
        FirstLabel.font = [UIFont systemFontOfSize:18.0f];
        FirstLabel.text = @"商户名称";
        [self.contentView addSubview:FirstLabel];
        
        //商户编号
        SecondLabel =  [[UILabel alloc] initWithFrame:CGRectZero];;
        SecondLabel.textAlignment = NSTextAlignmentCenter;
        SecondLabel.backgroundColor = [UIColor clearColor];
        SecondLabel.font = [UIFont systemFontOfSize:18.0f];
        SecondLabel.text = @"网点名称";
        [self.contentView addSubview:SecondLabel];
        
        //机身序列号
        ThirdLabel =  [[UILabel alloc] initWithFrame:CGRectZero];
        ThirdLabel.textAlignment = NSTextAlignmentCenter;
        ThirdLabel.backgroundColor = [UIColor clearColor];
        ThirdLabel.font = [UIFont systemFontOfSize:18.0f];
        ThirdLabel.text = @"机身序列号:";
        [self.contentView addSubview:ThirdLabel];
        
    }
    return self;
}

-(void)setModel:(SHDataItem *)model{
    _model = model;
    
    FirstLabel.text = [NSString stringWithFormat:@"商户名称:%@",model.shop_name];
    CGSize fittingSize = [FirstLabel systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
    [FirstLabel setFrame:CGRectMake(10,10,fittingSize.width,fittingSize.height )];
    
    SecondLabel.text = [NSString stringWithFormat:@"申请时间:%@",model.applyDate];
    CGSize SecondLabelSize = [SecondLabel systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
    [SecondLabel setFrame:CGRectMake(10,FirstLabel.origin.y + FirstLabel.size.height+10,SecondLabelSize.width,SecondLabelSize.height )];
    
    ThirdLabel.text = [NSString stringWithFormat:@"审批备注:%@",model.examineComment];
    CGSize ThirdLabelSize = [ThirdLabel systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
    [ThirdLabel setFrame:CGRectMake(10,SecondLabel.origin.y + SecondLabel.size.height+10,ThirdLabelSize.width,ThirdLabelSize.height )];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
