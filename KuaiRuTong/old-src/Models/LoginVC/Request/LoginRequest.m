//
//  LoginRequest.m
//  BTSOpenClass
//
//  Created by bts on 15/3/16.
//  Copyright (c) 2015年 Aruba Studio. All rights reserved.
//

#import "LoginRequest.h"
#import "AFNetworking.h"
#import "DeviceManager.h"
#import "Config.h"
#import "RWDBManager.h"
#import "JSONKit.h"


@implementation LoginRequest

- (void)loginWithUsername:(NSString *)username AndPassword:(NSString *)password completionBlock:(void (^)(NSDictionary *loginDic))completionBlock {
    __block LoginStatus status = LoginNoWifi;
    NSMutableDictionary *loginDic = [[NSMutableDictionary alloc] init];
    if (![DeviceManager isExistenceNetwork]) {
        [loginDic setObject:@"请检查当前网络状态" forKey:@"Info"];
        [loginDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
        completionBlock(loginDic);
    }else{
        if ([username isEqualToString:@""] || (username == nil)||[password isEqualToString:@""]||(password == nil)) {
            status = LoginFailed;
            [loginDic setObject:@"用户名或密码不能为空" forKey:@"Info"];
            [loginDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
            completionBlock(loginDic);
            
        }else{
            
            //登录接口地址
            NSString *dealWithURLString =  [API_LoginVC_Login stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            //key:@"data"  value:loginPostDic
            NSString *dateStr = [DeviceManager dealWithDate:[NSDate date]];
            NSString *versionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
            NSMutableDictionary *loginPostDic = [[NSMutableDictionary alloc] init];
            [loginPostDic setObject:username forKey:@"name"];
            [loginPostDic setObject:password forKey:@"password"];
            [loginPostDic setObject:dateStr  forKey:@"time"];
            [loginPostDic setObject:@"android" forKey:@"plamate"];
            [loginPostDic setObject:versionString forKey:@"version"];
            NSString *jsonStr=[loginPostDic JSONString];
            NSDictionary *jsonPostData = @{@"data":jsonStr};
            AFHTTPRequestOperationManager *managers = [AFHTTPRequestOperationManager manager];
            managers.responseSerializer = [AFJSONResponseSerializer serializer];
            [managers POST:dealWithURLString parameters:jsonPostData success:^(AFHTTPRequestOperation *operation, id responseObject) {
                id json_LoginData =[NSJSONSerialization  JSONObjectWithData:operation.responseData options:0 error:nil];
                NSLog(@"%@",json_LoginData);
                if ([json_LoginData isKindOfClass:[NSDictionary class]]) {
                    if ([json_LoginData[@"isLogin"] isEqualToString:@"true"]) {
                        //1.记录返回信息
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:json_LoginData forKey:@"UserInfoData"];
                        [userDefaults synchronize];
                        //2.确定返回成功
                        status = LoginSuccess;
                        [loginDic setObject:@"登录成功" forKey:@"Info"];
                        [loginDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(loginDic);
                    }else{
                        //确定返回失败
                        status = LoginFailed;
                        [loginDic setObject:json_LoginData[@"msg"] forKey:@"Info"];
                        [loginDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(loginDic);
                    }
                }else{
                    //确定返回失败
                    status = LoginFailed;
                    [loginDic setObject:@"返回数据错误" forKey:@"Info"];
                    [loginDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                    completionBlock(loginDic);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                status = LoginFailed;
                [loginDic setObject:@"数据库链接错误" forKey:@"Info"];
                [loginDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                completionBlock(loginDic);
            }];
        }
    }
}




@end
