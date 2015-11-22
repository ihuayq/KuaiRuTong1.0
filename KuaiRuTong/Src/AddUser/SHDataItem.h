//
//  SHDataItem.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/20.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <Foundation/Foundation.h>

//商户数据
@interface SHDataItem : NSObject
//        "shop_name": "",  新增商户名称
//        "pos_code": "",   网点机具序列号
//        "branch_add": "", 网点地址
//        "industry": "",   行业
//        "industry_subclass": "", 行业细类
//        "mcc": "",        mcc
//        "account_name": "", 账户名
//        "bank_card_num": "", 结算卡号
//        "pub_pri": "",       对公 1 对私 0
//        "invitation_code": "", 商户邀请码
//        "bank_province":"",  省
//        "bank_city":"",      市
//        "bank_add": "",	结算卡地址
//        "phone_num": "",	手机号
//        "phone_verify": "", 手机号验证
//        "network_name_verify": "" 网点名称验证接口
//        "zip":""               照片数据zip包

@property (nonatomic, copy)     NSString    *business_id;//主键值

@property (nonatomic, copy)     NSString    *shop_name;
@property (nonatomic, copy)     NSString	*pos_code;
@property (nonatomic, copy)     NSString	*branch_add;
@property (nonatomic, copy)     NSString	*industry;
@property (nonatomic, copy)     NSString	*industry_subclass;
@property (nonatomic, copy)     NSString    *mcc;
@property (nonatomic, copy)     NSString    *account_name;
@property (nonatomic, copy)     NSString    *bank_card_num;
@property (nonatomic, copy)     NSString    *pub_pri;
@property (nonatomic, copy)     NSString    *invitation_code;
@property (nonatomic, copy)     NSString    *bank_province;
@property (nonatomic, strong)   NSString    *bank_city;
@property (nonatomic, strong)   NSString    *bank_add;

@property (nonatomic, copy)     NSString    *phone_num;
@property (nonatomic, copy)     NSString    *phone_verify;
@property (nonatomic, strong)   NSString    *network_name_verify;

@property (nonatomic, strong)   NSData*     photo_business_permit;
@property (nonatomic, strong)   NSData*     photo_identifier_front;
@property (nonatomic, strong)   NSData*     photo_identifier_back;
@property (nonatomic, strong)   NSData*     photo_business_place;
@property (nonatomic, strong)   NSData*     photo_bankcard_front;
@property (nonatomic, strong)   NSData*     photo_bankcard_back;
@property (nonatomic, strong)   NSData*     photo_contracts;


//@property (nonatomic, strong)   NSNumber    *zip;

@end
