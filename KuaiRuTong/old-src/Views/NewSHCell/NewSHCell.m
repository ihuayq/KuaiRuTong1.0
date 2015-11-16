//
//  NewSHCell.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "NewSHCell.h"
#import "DeviceManager.h"
#import "ViewModel.h"
@implementation NewSHCell
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
    //标题
    _titleLabel = [ViewModel createLabelWithFrame:CGRectMake(20, 12, 160, 21) Font:nil Text:nil];
    [self.contentView addSubview:_titleLabel];
    
    //是否保存按钮
    _cunButton = [ViewModel createButtonWithFrame:CGRectMake(270, 15, 13, 13) ImageNormalName:@"rememberPwd_button_normal" ImageSelectName:@"rememberPwd_button_select" Title:nil Target:nil Action:nil];
    [self.contentView addSubview:_cunButton];
    
    _intoInfoView = [ViewModel createViewWithFrame:CGRectMake(270, 6, 30, 30)];
    _intoInfoView.hidden = YES;
    _intoInfoView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_intoInfoView];
    
    //分割线
    UIView *lineView = [ViewModel createViewWithFrame:CGRectMake(0, 43, 320, 1)];
    [self.contentView addSubview:lineView];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
