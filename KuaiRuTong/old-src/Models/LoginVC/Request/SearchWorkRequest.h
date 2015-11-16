//
//  SearchWorkRequest.h
//  KuaiRuTong
//
//  Created by HKRT on 15/9/16.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, SearchWorkStatus) {
    SearchWorkSuccess = 0,
    SearchWorkFailed  = 1,
    SearchWorkNoWifi  = 2,
};

@interface SearchWorkRequest : NSObject
/**
 *  工作查询接口请求并放入数据模型
 *
 *  @param shopName        商户名称
 *  @param shopCode        商户编号
 *  @param completionBlock 完成模块
 */
- (void)searchWorkShopName:(NSString *)shName AndShopCode:(NSString *)shCode completionBlock:(void (^)(NSDictionary *seachWorkDic))completionBlock;
@end
