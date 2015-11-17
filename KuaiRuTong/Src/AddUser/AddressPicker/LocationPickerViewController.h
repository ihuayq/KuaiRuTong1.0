//
//  LocationPickerViewController.h
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/17.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^block)(NSString *strProvice,NSString *strCity,NSString *strArea);

@interface LocationPickerViewController : CommonViewController

@property (nonatomic, copy) block block;

@end
