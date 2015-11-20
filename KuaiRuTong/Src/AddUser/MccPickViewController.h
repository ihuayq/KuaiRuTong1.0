//
//  MccPickViewController.h
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/19.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^MccBlock)(NSString *strCategory,NSString *strSubCategory,NSString *strMccCode);


@interface MccPickViewController : CommonViewController{
    
}

@property (strong, nonatomic) NSDictionary *pickerDic;

@property (nonatomic, copy) MccBlock block;


@end
