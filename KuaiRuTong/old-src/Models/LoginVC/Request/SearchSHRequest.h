//
//  SearchSHRequest.h
//  KuaiRuTong
//
//  Created by HKRT on 15/8/7.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SearchSHStatus) {
    SearchSHSuccess = 0,
    SearchSHFailed  = 1,
    SearchSHNoWifi  = 2,
};
@interface SearchSHRequest : NSObject
/**
 *  商户查询接口请求并放入数据模型
 *
 *  @param username        用户名称
 *  @param password        用户密码
 *  @param code            激活码
 *  @param DeviceID        通知时获取的设备令牌
 *  @param completionBlock 完成模块
 */
- (void)searchSHCode:(NSString *)shCode AndshName:(NSString *)shName AndPosCode:(NSString *)posCode completionBlock:(void (^)(NSDictionary *seachSHDic))completionBlock;

@end
