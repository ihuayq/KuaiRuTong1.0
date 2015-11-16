//
//  VerifyKCRequest.h
//  KuaiRuTong
//
//  Created by HKRT on 15/11/3.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, VerifyKCStatus) {
    VerifyKCSuccess = 0,
    VerifyKCFailed  = 1,
    VerifyKCNoWifi  = 2,
};

@interface VerifyKCRequest : NSObject
- (void)verifyKCMachineCode:(NSString *)machineCode completionBlock:(void (^)(NSDictionary *verifyKuCunDic))completionBlock;
@end
