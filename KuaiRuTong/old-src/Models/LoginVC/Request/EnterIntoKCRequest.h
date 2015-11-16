//
//  EnterIntoKCRequest.h
//  KuaiRuTong
//
//  Created by HKRT on 15/11/3.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, EnterIntoKCStatus) {
    EnterIntoKCSuccess = 0,
    EnterIntoKCFailed  = 1,
    EnterIntoKCNoWifi  = 2,
};
@interface EnterIntoKCRequest : NSObject
- (void)enterIntoKuCunRequestCompletionBlock:(void (^)(NSDictionary *enterIntoKCDic))completionBlock;
@end
