//
//  ScanView.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@protocol ScanViewDelegate;
@interface ScanView : UIView<AVCaptureMetadataOutputObjectsDelegate>{
    AVCaptureSession *session;
    NSTimer *timer;
    UIView *lineView;
     BOOL upOrdown;
    int num;
}
@property (nonatomic, assign)id <ScanViewDelegate>Delegate;
@end

@protocol ScanViewDelegate <NSObject>

- (void)pushOtherViewAndPassInfo:(NSString *)info;

@end