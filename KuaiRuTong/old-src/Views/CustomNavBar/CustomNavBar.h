//
//  CustomNavBar.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/9.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomNavBarDelegate;
@interface CustomNavBar : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong)  UIButton *customSaveBtn;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, assign) id <CustomNavBarDelegate> Delegate;
@end

@protocol CustomNavBarDelegate <NSObject>

- (void)dealWithBackButtonClickedMethod;
- (void)dealWithSaveButtonClickedMethod;
@end
