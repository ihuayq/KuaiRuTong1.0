//
//  RemoveBindingRequest.h
//  KuaiRuTong
//
//  Created by HKRT on 15/9/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, RemoveBindingStatus) {
    RemoveBindingSuccess = 0,
    RemoveBindingFailed  = 1,
    RemoveBindingNoWifi  = 2,
};
@interface RemoveBindingRequest : NSObject
- (void)removeBindingMachineCode:(NSString *)machineCode completionBlock:(void (^)(NSDictionary *removeBindingDic))completionBlock;
@end
