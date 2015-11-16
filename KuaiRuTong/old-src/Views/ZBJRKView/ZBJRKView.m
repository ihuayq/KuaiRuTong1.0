//
//  ZBJRKView.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "ZBJRKView.h"
#import "DeviceManager.h"
#import "VerifyKCRequest.h"
#import "GetCAndMRequest.h"
#import "EnterIntoKCRequest.h"
@implementation ZBJRKView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadBasicView];
        isCompanyName = NO;
        isMachineType = NO;
    }
    return self;
}
- (void)passScanInfoForZBJRK:(NSString *)scanNumber{
    xlhTextField.text = scanNumber;
    [self loadBasicData];
}
- (void)loadBasicData{

    GetCAndMRequest *getCAndMRequest = [[GetCAndMRequest alloc] init];
    [getCAndMRequest getCompanyNameAndMachineTypeRequestCompletionBlock:^(NSDictionary *getCAndMDic) {
        if([getCAndMDic [@"status"] intValue] == 2){
            //没有网络
            hud_ZBJRKVC.labelText = getCAndMDic[@"Info"];
             [hud_ZBJRKVC show:YES];
            [hud_ZBJRKVC hide:YES afterDelay:1];
        }else if ([getCAndMDic[@"status"] intValue] == 1){
            //解绑失败
            hud_ZBJRKVC.labelText = getCAndMDic[@"Info"];
            [hud_ZBJRKVC show:YES];
            [hud_ZBJRKVC hide:YES afterDelay:1];
        }else{
            //解绑成功
            hud_ZBJRKVC.labelText = getCAndMDic[@"Info"];
            NSDictionary *infoDic = getCAndMDic[@"CAndMData"];
            companyNamesArray = [[NSArray alloc] initWithArray:infoDic[@"termCopInf"]];
        
            machineTypesArray = [[NSArray alloc] initWithArray:infoDic[@"terminalType"]];
            
        }

    }];
    
}
- (void)loadBasicView {
    //添加HUD
    hud_ZBJRKVC = [[MBProgressHUD alloc] initWithView:self];
    hud_ZBJRKVC.mode = MBProgressHUDModeText;
    hud_ZBJRKVC.mode = MBProgressHUDModeIndeterminate;
    hud_ZBJRKVC.delegate = self;
    [self addSubview:hud_ZBJRKVC];
    [self bringSubviewToFront:hud_ZBJRKVC];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320 * WIDTH_SCALE, HEIGHT - 130 * HEIGHT_SCALE)];
    scrollView.backgroundColor = [UIColor clearColor];
    [scrollView setContentSize:CGSizeMake(0, 400 * HEIGHT_SCALE)];
    [self addSubview:scrollView];
    
    UILabel *xlhLabel = [[UILabel alloc] initWithFrame:CGRectMake(8 * WIDTH_SCALE, 55 * HEIGHT_SCALE,77 * WIDTH_SCALE, 21 * HEIGHT_SCALE)];
    xlhLabel.backgroundColor = [UIColor clearColor];
    xlhLabel.textColor = [UIColor blackColor];
    xlhLabel.font = [UIFont systemFontOfSize:15.0];
    xlhLabel.text = @"机身序列号";
    [scrollView addSubview:xlhLabel];
    
    xlhTextField = [[UITextField alloc] initWithFrame:CGRectMake(102 * WIDTH_SCALE, 53 * HEIGHT_SCALE, 210 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
    xlhTextField.returnKeyType = UIReturnKeyDone;
    xlhTextField.backgroundColor = [UIColor clearColor];
    xlhTextField.font = [UIFont systemFontOfSize:15.0];
    xlhTextField.borderStyle = UITextBorderStyleLine;
   
    xlhTextField.delegate = self;
    [scrollView addSubview:xlhTextField];
    
    UIButton *verifyButton = [[UIButton alloc] initWithFrame:CGRectMake(8 * WIDTH_SCALE, 105 * HEIGHT_SCALE,77 * WIDTH_SCALE, 21 * HEIGHT_SCALE)];
    verifyButton.backgroundColor = ORANGE_COLOR;
    [verifyButton setTitle:@"库存验证" forState:UIControlStateNormal];
    [verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    verifyButton.layer.cornerRadius = 3;
    verifyButton.layer.borderWidth = 1;
    [verifyButton addTarget:self action:@selector(verifyButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:verifyButton];
    
    descLabel = [[UILabel alloc] initWithFrame:CGRectMake(102 * WIDTH_SCALE, 103 * HEIGHT_SCALE,218 * WIDTH_SCALE, 21 * HEIGHT_SCALE)];
    descLabel.hidden = YES;
    descLabel.backgroundColor = [UIColor clearColor];
    descLabel.textColor = [UIColor lightGrayColor];
    descLabel.font = [UIFont systemFontOfSize:13.0];
    [scrollView addSubview:descLabel];

    
    NSArray *titlesArray = @[@"厂商名称",@"机具类型",@"机具型号",@"机具数量"];
    for (int i = 0 ; i < titlesArray.count; i ++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8 * WIDTH_SCALE, (155 + 50 * i)* HEIGHT_SCALE,77 * WIDTH_SCALE, 21 * HEIGHT_SCALE)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.text = titlesArray[i];
        [scrollView addSubview:titleLabel];
        
        UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(102 * WIDTH_SCALE, (153 + 50 * i) * HEIGHT_SCALE, 210 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
        titleTextField.tag = 200 + i;
        if (titleTextField.tag != 203) {
            titleTextField.allowsEditingTextAttributes = NO;
        }else{
            titleTextField.allowsEditingTextAttributes = YES;
        }
        
        titleTextField.returnKeyType = UIReturnKeyDone;
        titleTextField.backgroundColor = [UIColor clearColor];
        titleTextField.font = [UIFont systemFontOfSize:15.0];
        titleTextField.borderStyle = UITextBorderStyleLine;
        
        titleTextField.delegate = self;
        [scrollView addSubview:titleTextField];
    }
    
    UIButton *successButton = [[UIButton alloc] initWithFrame:CGRectMake(0 * WIDTH_SCALE, 370 * HEIGHT_SCALE, 320 * WIDTH_SCALE, 30 * HEIGHT_SCALE)];
    successButton.backgroundColor = ORANGE_COLOR;
    [successButton setTitle:@"确认入库" forState:UIControlStateNormal];
    [successButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [successButton addTarget:self action:@selector(successButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:successButton];
    
    infoDataView = [[InfoDataView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width,scrollView.frame.size.height)];
    infoDataView.Delegate = self;
    infoDataView.hidden = YES;
    [scrollView addSubview:infoDataView];
    
}

- (void)verifyButtonClicked{
    
    hud_ZBJRKVC.mode = MBProgressHUDModeIndeterminate;
    hud_ZBJRKVC.labelText = @"验证中...";
    [hud_ZBJRKVC show:YES];
    VerifyKCRequest *verifyKuCunRequest = [[VerifyKCRequest alloc] init];
    [verifyKuCunRequest verifyKCMachineCode:xlhTextField.text completionBlock:^(NSDictionary *verifyKuCunDic) {
        if([verifyKuCunDic [@"status"] intValue] == 2){
            //没有网络
            hud_ZBJRKVC.labelText = verifyKuCunDic[@"Info"];
        }else if ([verifyKuCunDic[@"status"] intValue] == 1){
            //解绑失败
            hud_ZBJRKVC.labelText = verifyKuCunDic[@"Info"];
        }else{
            //解绑成功
            hud_ZBJRKVC.labelText = verifyKuCunDic[@"Info"];
            
            message = verifyKuCunDic[@"message"];
        }
        [hud_ZBJRKVC hide:YES afterDelay:1];
    }];

    
}
#pragma mark -- MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud{
    if ([hud_ZBJRKVC.labelText isEqualToString:@"验证成功"]) {
        //0 不存在 1 存在
        if ([message isEqualToString:@"1"]) {
            descLabel.text = @"该机器没有库存可以入库";
            descLabel.textColor = [UIColor greenColor];
            descLabel.hidden = NO;
        }else{
            descLabel.text = @"该机器有库存不可以入库";
            descLabel.textColor = [UIColor redColor];
            descLabel.hidden = NO;

        }
        
    }

}
#pragma mark -- InfoDataViewDelegate 代理方法
- (void)selectInfoForCell:(NSString *)info AndTag:(NSInteger)tag{
    infoDataView.hidden = YES;
    if (tag == 200) {
        UITextField *chmcTextField = (UITextField *)[scrollView viewWithTag:200];
        chmcTextField.text =info;
        isCompanyName = YES;
    }else if (tag == 201){
        UITextField *jjlxTextField = (UITextField *)[scrollView viewWithTag:201];
        jjlxTextField.text =info;
        isMachineType = YES;
    }
    
    if (isCompanyName && isMachineType) {
        UITextField *chmcTextField = (UITextField *)[scrollView viewWithTag:200];
        UITextField *jjlxTextField = (UITextField *)[scrollView viewWithTag:201];
        UITextField *jjxhTextField = (UITextField *)[scrollView viewWithTag:202];
        jjxhTextField.text = @"机具型号获取中...";
        jjxhTextField.textColor = [UIColor redColor];
        [self loadXLHMethod:chmcTextField.text AndMachineType:jjlxTextField.text];
    }
    
}
#pragma mark -- UITextFieldDelegate 代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    UITextField *chmcTextField = (UITextField *)[scrollView viewWithTag:200];
    UITextField *jjlxTextField = (UITextField *)[scrollView viewWithTag:201];
    UITextField *jjxhTextField = (UITextField *)[scrollView viewWithTag:202];
    UITextField *jjslTextField = (UITextField *)[scrollView viewWithTag:203];
    if (textField == jjslTextField) {
        [textField isFirstResponder];
        [scrollView setContentOffset:CGPointMake(0, 160 * HEIGHT_SCALE) animated:YES];
        return YES;
    }else{
        
        infoDataView.hidden = NO;
      
        [jjslTextField resignFirstResponder];
        
        if (textField == chmcTextField) {
            
            
            NSLog(@"%@",companyNamesArray);
            
            [infoDataView loadDataForTableViewMethod:companyNamesArray AndTextFieldTag:200];
        }else if (textField == jjlxTextField){
            [infoDataView loadDataForTableViewMethod:machineTypesArray AndTextFieldTag:201];
        }
        return NO;
    }
    return YES;
}

- (void)loadXLHMethod:(NSString *)companyName AndMachineType:(NSString *)machineType{
    
}

- (void)successButtonClicked{
    UITextField *chmcTextField = (UITextField *)[scrollView viewWithTag:200];
    UITextField *jjlxTextField = (UITextField *)[scrollView viewWithTag:201];
    UITextField *jjxhTextField = (UITextField *)[scrollView viewWithTag:202];
    UITextField *jjslTextField = (UITextField *)[scrollView viewWithTag:203];
   if ([_Delegate respondsToSelector:@selector(rukuButtonClikcedMethod:AndcsmcTextField:AndjjlxTextField:AndjjxhTextField:AndjjslTextField:)]) {
       [_Delegate rukuButtonClikcedMethod:xlhTextField AndcsmcTextField:chmcTextField AndjjlxTextField:jjlxTextField AndjjxhTextField:jjxhTextField AndjjslTextField:jjslTextField];
   }
}

@end
