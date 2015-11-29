//
//  SHResultData.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/25.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <Foundation/Foundation.h>

//查询网点信息
//{
//    "shop": [	网点详情
//             {
//                 "shopAddress": "",	网点地址
//                 "shopName": "",	网点名
//                 "coun": "",	网点所在县
//                 "city": ""，	网点所在市
//                 "provn": "",	网点所在省
//                 "serialNos": [	机身序列号
//                               ""
//                               ],
//             },
//             ],
//    "mercMcc": "",	mcc
//    "mercNum": "",	商户编号
//    "mercName": "TTest-子商户-陈玉洁",	商户名
//    "mercSta": "",	商户状态
//    "code": "",	返回编码
//    "msg":"",	返回信息
//}

@interface SHShopData : NSObject

@property(nonatomic,copy) NSString* shopAddress;
@property(nonatomic,copy) NSString* shopName;
@property(nonatomic,copy) NSString* coun;//临时用的字段
@property(nonatomic,copy) NSString* city;
@property(nonatomic,copy) NSString* provn;
@property(nonatomic,strong) NSArray* serialNos;

@end


@interface SHResultData : NSObject

@property(nonatomic,copy) NSString* mercName;
@property(nonatomic,copy) NSString* mercNum;
@property(nonatomic,copy) NSString* machine_code;//临时用的字段
@property(nonatomic,copy) NSString* mercSta;
@property(nonatomic,copy) NSString* mercMcc;

@property(nonatomic,strong) NSArray* shopArray;

@end
