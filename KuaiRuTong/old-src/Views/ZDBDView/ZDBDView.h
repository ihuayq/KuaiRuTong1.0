//
//  ZDBDView.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDBDViewDelegate;
@interface ZDBDView : UIView<UITextFieldDelegate>{
    UIScrollView *scrollView;
}
@property (nonatomic , assign)id <ZDBDViewDelegate>Delegate;
@end
@protocol ZDBDViewDelegate <NSObject>

- (void)bangDingButtonClikcedMethod:(UITextField *)shbhTextField AndwdmcTextField:(UITextField *)wdmcTextField AndxlhTextField:(UITextField *)xlhTextField AndbddhTextField:(UITextField *)bddhTextField;

@end