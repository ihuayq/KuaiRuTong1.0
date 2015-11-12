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

#define RED_COLOR1   [UIColor colorWithRed:0.97f green:0.26f blue:0.00f alpha:1.00f];
#define RED_COLOR2   [UIColor colorWithRed:0.78f green:0.21f blue:0.01f alpha:1.00f];
#define ORANGE_COLOR [UIColor colorWithRed:0.91f green:0.51f blue:0.02f alpha:1.00f];
#define GRAY_COLOR   [UIColor colorWithRed:0.86f green:0.85f blue:0.85f alpha:1.00f];

@interface DeviceManager : NSObject
+ (BOOL)isExistenceNetwork;
+ (BOOL)isValidateMobile:(NSString *)mobile;
+ (NSString *)dealWithDate:(NSDate *)date;
@end
