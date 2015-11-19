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
        textField = [[UITextField  alloc ]initWithFrame:CGRectMake(10, 4, MainWidth, 40)];
        textField.borderStyle = UITextBorderStyleNone;
        textField.textAlignment = NSTextAlignmentLeft;
        textField.placeholder = @"请输入机身序列号";
        textField.font = [UIFont systemFontOfSize:20.0];
        textField.delegate = self;
        
        //此方法为关键方法
        [textField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
        
        [self.contentView addSubview:textField];
    }
    return self;
}


//-(NSString *)code{
//    NSString *codeTMP = @"";
//    if (textField.text) {
//        codeTMP = textField.text;
//    }
//    DLog(@"Cell textfield info:%@", textField.text);
//    return codeTMP;
//}


- (void)textFieldWithText:(UITextField *)field
{
    if (self.onTextEntered) {
        self.onTextEntered(field.text);
    }
    
//    DLog(@"Cell textfield info:%@", field.text);
//    
//    self.code = field.text;
//    
//    DLog(@"Cell code info:%@", self.code);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
