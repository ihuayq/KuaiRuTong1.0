//
//  CodeTableViewCell.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/18.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "CodeTableViewCell.h"

@implementation CodeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //详细地址
        addressTextField = [[UITextField  alloc ]initWithFrame:CGRectMake(10, 4, MainWidth, 40)];
        addressTextField.borderStyle = UITextBorderStyleNone;
        addressTextField.textAlignment = NSTextAlignmentLeft;
        addressTextField.placeholder = @"请输入机身序列号";
        addressTextField.font = [UIFont systemFontOfSize:20.0];
        [self.contentView addSubview:addressTextField];
    }
    return self;
}


-(NSString *)code{
    if (addressTextField.text) {
        return addressTextField.text;
    }
    return @"";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
