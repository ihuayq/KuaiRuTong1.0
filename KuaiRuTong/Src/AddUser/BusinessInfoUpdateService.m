//
//  BusinessInfoUpdateService.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/19.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "BusinessInfoUpdateService.h"

@implementation BusinessInfoUpdateService


-(void)beginUpload:(NSDictionary*)parameters{
    
    NSString *dealWithURLString =  [API_LoginVC_Login stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//    NSString *dateStr = [DeviceManager dealWithDate:[NSDate date]];
//    NSString *versionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
//    NSMutableDictionary *loginPostDic = [[NSMutableDictionary alloc] init];
//    [loginPostDic setObject:userName forKey:@"name"];
//    [loginPostDic setObject:password forKey:@"password"];
//    [loginPostDic setObject:dateStr  forKey:@"time"];
//    [loginPostDic setObject:@"android" forKey:@"plamate"];
//    [loginPostDic setObject:versionString forKey:@"version"];
    
    updateHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:parameters cmdCode:CC_BusinessUpload];
    
    [self.httpMsgCtrl sendHttpMsg:updateHttpMsg];
}




- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    //    [self removeOverFlowActivityView];
    if (receiveMsg.cmdCode == CC_BusinessUpload)
    {
        NSDictionary *item = receiveMsg.jasonItems;
    }
}


@end
