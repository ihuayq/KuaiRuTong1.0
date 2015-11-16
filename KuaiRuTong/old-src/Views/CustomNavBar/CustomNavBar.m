//
//  CustomNavBar.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/9.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "CustomNavBar.h"
#import "DeviceManager.h"

@implementation CustomNavBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadBasicView];
        
    }
    return self;
}
- (void)loadBasicView {
    //背景颜色
    self.backgroundColor = RED_COLOR1;
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20,self.frame.size.width,self.frame.size.height -20)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:23.0];
    [self addSubview:_titleLabel];
    
    
    //返回视图
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60 * WIDTH_SCALE, 80 * HEIGHT_SCALE)];
    _backView.hidden = YES;
    _backView.backgroundColor = [UIColor clearColor];
    [self addSubview:_backView];
    //返回按钮
    UIImageView *backIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15 * WIDTH_SCALE, 40 * HEIGHT_SCALE, 14 * WIDTH_SCALE, 28 * HEIGHT_SCALE)];
    backIcon.image = [UIImage imageNamed:@"back_button_normal"];
    [_backView addSubview:backIcon];
    //返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60 * WIDTH_SCALE, 80 * HEIGHT_SCALE)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:backButton];
    //保存按钮
    _customSaveBtn = [[UIButton alloc] initWithFrame:CGRectMake(250 * WIDTH_SCALE, 38 * HEIGHT_SCALE, 60 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
    _customSaveBtn.hidden = YES;
    [_customSaveBtn setTitle:@"保存" forState:UIControlStateNormal];
    _customSaveBtn.backgroundColor = ORANGE_COLOR;
    _customSaveBtn.layer.cornerRadius = 5;
    [_customSaveBtn addTarget:self action:@selector(cucstomSaveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_customSaveBtn];
    
}

/**
 *  点击返回按钮出来方法
 *  @return void
 */
- (void)backButtonClicked{
    if ([_Delegate respondsToSelector:@selector(dealWithBackButtonClickedMethod)]) {
        [_Delegate dealWithBackButtonClickedMethod];
    }
    
}

/**
 *  点击保存按钮出来方法
 */
- (void)cucstomSaveBtnClicked{
    if ([_Delegate respondsToSelector:@selector(dealWithSaveButtonClickedMethod)]) {
        [_Delegate dealWithSaveButtonClickedMethod];
    }
}
@end
