//
//  MachineCodeCell.m
//  KuaiRuTong
//
//  Created by HKRT on 15/9/28.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import "MachineCodeCell.h"
#import "ViewModel.h"
#import "DeviceManager.h"

@implementation MachineCodeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadBasicView];
    }
    return self;
}
/**
 *  加载基础视图
 *  @return void
 */
- (void)loadBasicView{
    //序列号
    UITextField *xlhTextField = [ViewModel createTextFieldWithFrame:CGRectMake(10, 0, 270, 40) Placeholder:@"请输入序列号" Font:[UIFont systemFontOfSize:20.0]];
    xlhTextField.borderStyle = UITextBorderStyleNone;
    xlhTextField.textAlignment = NSTextAlignmentLeft;
    xlhTextField.delegate = self;
    [self.contentView addSubview:xlhTextField];
    
    //添加按钮
    UIButton *addButton = [ViewModel createButtonWithFrame:CGRectMake(280, 0, 40, 40) ImageNormalName:nil ImageSelectName:nil Title:nil Target:self Action:@selector(addButtonClicked)];
    addButton.backgroundColor = RED_COLOR1;
    [self.contentView addSubview:addButton];

}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([_Delegate respondsToSelector:@selector(writeTextFieldForCell:AndText:)]) {
        [_Delegate writeTextFieldForCell:self AndText:textField.text];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)addButtonClicked{
    if ([_Delegate respondsToSelector:@selector(addButtonForCell:)]) {
        [_Delegate addButtonForCell:self];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
