//
//  GetCAndMRequest.h
//  KuaiRuTong
//
//  Created by HKRT on 15/11/3.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, GetCAndMStatus) {
    GetCAndMSuccess = 0,
    GetCAndMFailed  = 1,
    GetCAndMNoWifi  = 2,
};
@interface GetCAndMRequest : NSObject
- (void)getCompanyNameAndMachineTypeRequestCompletionBlock:(void (^)(NSDictionary *getCAndMDic))completionBlock;
@end
