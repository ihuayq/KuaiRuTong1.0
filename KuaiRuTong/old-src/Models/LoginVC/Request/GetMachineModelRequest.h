//
//  GetMachineModelRequest.h
//  KuaiRuTong
//
//  Created by HKRT on 15/11/4.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, GetMachineModelStatus) {
    GetMachineModelSuccess = 0,
    GetMachineModelFailed  = 1,
    GetMachineModelNoWifi  = 2,
};
@interface GetMachineModelRequest : NSObject
- (void)getMachineModelFromCompayName:(NSString *)companyName AndMachineType:(NSString *)machineType completionBlock:(void (^)(NSDictionary *getMachineModelDic))completionBlock;
@end
