//
//  LoginDataService.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/12.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "LoginDataService.h"
#import "DeviceManager.h"

@implementation LoginDataService

-(void)beginLogin:(NSString*)userName  Passport:(NSString*)password{
   
    NSString *url = [NSString stringWithFormat:@"%@", kShopSearchHost];
    
    NSString *dealWithURLString =  [API_LoginVC_Login stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSString *dateStr = [DeviceManager dealWithDate:[NSDate date]];
    NSString *versionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSMutableDictionary *loginPostDic = [[NSMutableDictionary alloc] init];
    [loginPostDic setObject:userName forKey:@"name"];
    [loginPostDic setObject:password forKey:@"password"];
    [loginPostDic setObject:dateStr  forKey:@"time"];
    [loginPostDic setObject:@"android" forKey:@"plamate"];
    [loginPostDic setObject:versionString forKey:@"version"];
    
    loginHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:loginPostDic cmdCode:CC_Login];
    
    [self.httpMsgCtrl sendHttpMsg:loginHttpMsg];
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
//    [self removeOverFlowActivityView];
    if (receiveMsg.cmdCode == CC_Login)
    {
        NSDictionary *item = receiveMsg.jasonItems;
        DLog(@"THE Login info:%@",item);
        
        //1.记录返回信息
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:item forKey:@"UserInfoData"];
        [userDefaults synchronize];
        
        if (_delegate && [_delegate respondsToSelector:@selector(getLoginServiceResult:Result:errorMsg:)]) {
            [_delegate getLoginServiceResult:self Result:YES errorMsg:nil];
        }
        
    }
}

@end
