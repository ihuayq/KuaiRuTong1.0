//
//  ZDBDView.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "ZDBDView.h"
#import "DeviceManager.h"
@implementation ZDBDView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadBasicView];
        
    }
    return self;
}
- (void)loadBasicView {
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320 * WIDTH_SCALE, HEIGHT - 60 * HEIGHT_SCALE)];
    scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:scrollView];

    
    
    NSArray *titlesArray = @[@"商户编号",@"网点名称",@"机身序列号",@"绑定电话"];
    for (int i = 0 ; i < titlesArray.count; i ++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8 * WIDTH_SCALE, (55 + 50 * i)* HEIGHT_SCALE,77 * WIDTH_SCALE, 21 * HEIGHT_SCALE)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.text = titlesArray[i];
        [scrollView addSubview:titleLabel];
        
        UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(102 * WIDTH_SCALE, (53 + 50 * i) * HEIGHT_SCALE, 210 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
        titleTextField.tag = 200 + i;
        titleTextField.returnKeyType = UIReturnKeyDone;
        titleTextField.backgroundColor = [UIColor clearColor];
        titleTextField.font = [UIFont systemFontOfSize:15.0];
        titleTextField.borderStyle = UITextBorderStyleLine;
        titleTextField.delegate = self;
        [scrollView addSubview:titleTextField];
    }

    UIButton *bangdingButton = [[UIButton alloc] initWithFrame:CGRectMake(94 * WIDTH_SCALE, 323 * HEIGHT_SCALE, 132 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
    bangdingButton.backgroundColor = [UIColor clearColor];
    [bangdingButton setTitle:@"确认绑定" forState:UIControlStateNormal];
    [bangdingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bangdingButton.layer.borderWidth = 1;
    bangdingButton.layer.cornerRadius = 3;
    [bangdingButton addTarget:self action:@selector(bangdingButtonClicked1) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:bangdingButton];
    
}
#pragma mark -- UITextFieldDelegate 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    UITextField *xlhTextField = (UITextField *)[scrollView viewWithTag:202];
    UITextField *bddhTextField = (UITextField *)[scrollView viewWithTag:203];
    if ((textField == xlhTextField)||(textField == bddhTextField)) {
        [scrollView setContentOffset:CGPointMake(0, 80 * HEIGHT_SCALE) animated:YES];
    }
    return YES;
}


- (void)bangdingButtonClicked1{
    UITextField *shbhTextField = (UITextField *)[scrollView viewWithTag:200];
    UITextField *wdmcTextField = (UITextField *)[scrollView viewWithTag:201];
    UITextField *xlhTextField = (UITextField *)[scrollView viewWithTag:202];
    UITextField *bddhTextField = (UITextField *)[scrollView viewWithTag:203];
    if ([_Delegate respondsToSelector:@selector(bangDingButtonClikcedMethod:AndwdmcTextField:AndxlhTextField:AndbddhTextField:)]) {
        [_Delegate bangDingButtonClikcedMethod:shbhTextField AndwdmcTextField:wdmcTextField AndxlhTextField:xlhTextField AndbddhTextField:bddhTextField];
    }
    
}

@end
