//
//  NewNetPointViewController.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/18.
//  Copyright © 2015年 hkrt. All rights reserved.
//
//网点信息  填写
#import <UIKit/UIKit.h>

typedef void (^addressBlock)(NSString *strAddressInfo,NSString *strPosCodeInfo);

@class TPKeyboardAvoidingTableView;

@interface SHNewNetPointViewController :CommonViewController


@property (strong, nonatomic) TPKeyboardAvoidingTableView *tableView;

@property (strong, nonatomic)  addressBlock block;



@end
