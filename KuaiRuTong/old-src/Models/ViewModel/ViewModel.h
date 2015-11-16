//
//  ViewModel.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/23.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewModel : UIView
// 创建UIView
+ (UIView *)createViewWithFrame:(CGRect)frame;

// 创建UIButton
+ (UIButton*)createButtonWithFrame:(CGRect)frame  ImageNormalName:(NSString*)imageName ImageSelectName:(NSString*)imageName Title:(NSString *)title Target:(id)target Action:(SEL)action;

// 创建UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame Font:(UIFont *)font Text:(NSString*)text;

// 创建UITextField
+ (UITextField*)createTextFieldWithFrame:(CGRect)frame Placeholder:(NSString*)placeholder Font:(UIFont *)font;

// 创建UIImageView
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString *)imageName;

// 创建UITableView
+ (UITableView *)createTableViewWithFrame:(CGRect)frame CellHeight:(CGFloat )height ScrollEnabled:(BOOL)enabled;

@end
