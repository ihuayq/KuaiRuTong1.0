//
//  LocationPickerVC.h
//  YouZhi
//
//  Created by roroge on 15/4/9.
//  Copyright (c) 2015年 com.roroge. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ablock)(NSString *strProvice,NSString *strCity,NSString *strArea);



@interface LocationPickerVC : CommonViewController

@property (nonatomic, copy) ablock block;

@end
