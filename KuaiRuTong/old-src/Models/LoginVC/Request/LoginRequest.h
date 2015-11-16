//
//  LoginRequest.h
//  BTSOpenClass
//
//  Created by bts on 15/3/16.
//  Copyright (c) 2015年 Aruba Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LoginStatus) {
    LoginSuccess = 0,
    LoginFailed  = 1,
    LoginNoWifi  = 2,
};
@interface LoginRequest : NSObject

/**
 *  登录接口请求并放入数据模型
 *
 *  @param username        用户名称
 *  @param password        用户密码
 *  @param code            激活码
 *  @param DeviceID        通知时获取的设备令牌
 *  @param completionBlock 完成模块
 */
- (void)loginWithUsername:(NSString *)username AndPassword:(NSString *)password completionBlock:(void (^)(NSDictionary *loginDic))completionBlock;



@end
