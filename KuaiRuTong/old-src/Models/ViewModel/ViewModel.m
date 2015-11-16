//
//  ViewModel.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/23.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "ViewModel.h"
#import "DeviceManager.h"

@implementation ViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

/**
 *  创建UIView
 *
 *  @param frame 尺寸
 *
 *  @return UIView
 */
+ (UIView *)createViewWithFrame:(CGRect)frame{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(frame.origin.x * WIDTH_SCALE, frame.origin.y * HEIGHT_SCALE, frame.size.width * WIDTH_SCALE, frame.size.height * HEIGHT_SCALE);
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}
/**
 *  创建UIButton
 *
 *  @param frame           尺寸
 *  @param imageNormalName 按钮正常状态背景图
 *  @param imageSelectName 按钮选择转态背景图
 *  @param title           文字
 *  @param target          目标
 *  @param action          事件
 *
 *  @return UIButton
 */
+ (UIButton*)createButtonWithFrame:(CGRect)frame  ImageNormalName:(NSString*)imageNormalName ImageSelectName:(NSString*)imageSelectName Title:(NSString *)title Target:(id)target Action:(SEL)action{
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    if (imageNormalName != nil) {
        [button setBackgroundImage:[UIImage imageNamed:imageNormalName] forState:UIControlStateNormal];
    }
    if (imageSelectName != nil) {
        [button setBackgroundImage:[UIImage imageNamed:imageSelectName] forState:UIControlStateSelected];
    }
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
  
    button.frame = CGRectMake(frame.origin.x * WIDTH_SCALE, frame.origin.y * HEIGHT_SCALE, frame.size.width * WIDTH_SCALE, frame.size.height * HEIGHT_SCALE);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
  
    
    return button;
    
}

/**
 *  创建UILabel
 *
 *  @param frame 尺寸
 *  @param font  字体
 *  @param text  文字
 *
 *  @return UILabel
 */
+ (UILabel*)createLabelWithFrame:(CGRect)frame Font:(UIFont *)font Text:(NSString*)text{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.frame =  CGRectMake(frame.origin.x * WIDTH_SCALE, frame.origin.y * HEIGHT_SCALE, frame.size.width * WIDTH_SCALE, frame.size.height * HEIGHT_SCALE);
    if (font != nil) {
        label.font = font;
    }
    label.text = text;
    
    return label;
}

/**
 *  创建UITextField
 *
 *  @param frame       尺寸
 *  @param placeholder 默认字
 *  @param font        字体大小
 *
 *  @return UITextField
 */
+ (UITextField*)createTextFieldWithFrame:(CGRect)frame Placeholder:(NSString*)placeholder Font:(UIFont *)font{
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor clearColor];
                                            textField.frame =  CGRectMake(frame.origin.x * WIDTH_SCALE, frame.origin.y * HEIGHT_SCALE, frame.size.width * WIDTH_SCALE, frame.size.height * HEIGHT_SCALE);
    textField.returnKeyType = UIReturnKeyDone;
    textField.placeholder = placeholder;
    textField.borderStyle = UITextBorderStyleLine;
    textField.textAlignment = NSTextAlignmentCenter;
    if (font != nil) {
        textField.font = font;
    }
    
 
    return textField;
    
}


/**
 *  创建UIImageView
 *
 *  @param frame     尺寸
 *  @param imageName 图片名称
 *
 *  @return UIImageView
 */
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.frame =  CGRectMake(frame.origin.x * WIDTH_SCALE, frame.origin.y * HEIGHT_SCALE, frame.size.width * WIDTH_SCALE, frame.size.height * HEIGHT_SCALE);
    if (imageName != nil) {
        imageView.image = [UIImage imageNamed:imageName];
    }
    return imageView;
    
}

+ (UITableView *)createTableViewWithFrame:(CGRect)frame CellHeight:(CGFloat)height ScrollEnabled:(BOOL)enabled{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x * WIDTH_SCALE, frame.origin.y * HEIGHT_SCALE, frame.size.width * WIDTH_SCALE, frame.size.height * HEIGHT_SCALE) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.scrollEnabled = enabled;
    tableView.rowHeight = height * HEIGHT_SCALE;
    
    return tableView;
}

@end
