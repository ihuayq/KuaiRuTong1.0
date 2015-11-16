//
//  SearchKCRequest.h
//  KuaiRuTong
//
//  Created by HKRT on 15/9/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, SearchKCStatus) {
    SearchKCSuccess = 0,
    SearchKCFailed  = 1,
    SearchKCNoWifi  = 2,
};
@interface SearchKCRequest : NSObject
/**
 *  工作查询接口请求并放入数据模型
 *
 *  @param shopName        商户名称
 *  @param shopCode        商户编号
 *  @param machineCode     机身序列号
 *  @param bdState         绑定状态
 *  @param completionBlock 完成模块
 */
- (void)searchKCShopName:(NSString *)shName AndShopCode:(NSString *)shCode AndMachineCode:(NSString *)machineCode AndBangDingState:(NSString *)bdState completionBlock:(void (^)(NSDictionary *seachKCDic))completionBlock;
@end
