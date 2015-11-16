//
//  DeviceManager.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/8.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <Foundation/Foundation.h>
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH_SCALE     1.0 / 320.0 * WIDTH
#define HEIGHT_SCALE    1.0 / 568.0 *  (320.0 == WIDTH ? 568.0 : HEIGHT)

@interface DeviceManager : NSObject
+ (BOOL)isExistenceNetwork;
+ (BOOL)isValidateMobile:(NSString *)mobile;
+ (NSString *)dealWithDate:(NSDate *)date;
@end
