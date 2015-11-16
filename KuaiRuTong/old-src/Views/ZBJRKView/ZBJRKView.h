//
//  ZBJRKView.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "InfoDataView.h"
@protocol ZBJRKViewDelegate;

@interface ZBJRKView : UIView<UITextFieldDelegate,MBProgressHUDDelegate,InfoDataViewDelegate>{
    UIScrollView *scrollView;
    UILabel *descLabel;
    UITextField *xlhTextField;
    MBProgressHUD *hud_ZBJRKVC;
    NSString *message;
    NSArray *companyNamesArray; //厂商名称列表
    NSArray *machineTypesArray; //机具类型列表
    InfoDataView *infoDataView;
    BOOL isCompanyName;
    BOOL isMachineType;
}
@property (nonatomic, assign) id <ZBJRKViewDelegate>Delegate;
- (void)passScanInfoForZBJRK:(NSString *)scanNumber;

@end
@protocol ZBJRKViewDelegate <NSObject>

- (void)rukuButtonClikcedMethod:(UITextField *)jsTextField AndcsmcTextField:(UITextField *)csmcTextField AndjjlxTextField:(UITextField *)jjlxTextField AndjjxhTextField:(UITextField *)jjxhTextField AndjjslTextField:(UITextField *)jjslTextField;

@end