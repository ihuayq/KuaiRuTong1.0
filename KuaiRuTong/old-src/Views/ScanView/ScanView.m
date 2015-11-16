//
//  ScanView.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "ScanView.h"
#import "DeviceManager.h"
@implementation ScanView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadBasicView];
        
    }
    return self;
}
///
- (void)loadBasicView {
    ///
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 320 * HEIGHT_SCALE, 320 * WIDTH_SCALE, 21 * HEIGHT_SCALE)];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.font = [UIFont boldSystemFontOfSize:15.0];
    infoLabel.text = @"请将机身条形码放入扫描框内";
    [self addSubview:infoLabel];
    
    
    
    
    
    UIView *photoView = [[UIView alloc] initWithFrame:CGRectMake(45 * WIDTH_SCALE, 90 * HEIGHT_SCALE, 230 * WIDTH_SCALE, 200 * HEIGHT_SCALE)];
    [self addSubview:photoView];
    
    
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * WIDTH_SCALE, 200 * HEIGHT_SCALE)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [photoView addSubview:lineView];
    upOrdown = NO;
    num = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animationButton) userInfo:nil repeats:YES];
    
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [session addInput:input];
    [session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=photoView.layer.bounds;
    [photoView.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [session startRunning];
}
///
-(void)animationButton {
    if (upOrdown == NO) {
        num ++;
        lineView.frame = CGRectMake(2 * num * WIDTH_SCALE, 0 * HEIGHT_SCALE , 2* WIDTH_SCALE,  200 * HEIGHT_SCALE);
        if (2*num * WIDTH_SCALE == 230 * WIDTH_SCALE) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        lineView.frame = CGRectMake(2 * num * WIDTH_SCALE, 0 * HEIGHT_SCALE , 2 * WIDTH_SCALE,  200 * HEIGHT_SCALE);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}
///
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        NSLog(@"%@",metadataObject.stringValue);
         [session stopRunning];
        [timer invalidate];
        if ([_Delegate respondsToSelector:@selector(pushOtherViewAndPassInfo:)]) {
            [_Delegate pushOtherViewAndPassInfo:metadataObject.stringValue];
        }
    }
    
}

@end
