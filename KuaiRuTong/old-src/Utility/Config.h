//
//  Config.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/8.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#ifndef KuaiRuTong_Config_h
#define KuaiRuTong_Config_h


//测试地址
#define TEST_COMMONT_URL           @"http://192.168.13.30:8080"
//登录
#define API_LoginVC_Login          (TEST_COMMONT_URL"/self/jsp/mobileLogin.action")
//校验商户名
#define API_Checkout_SHName        (TEST_COMMONT_URL"/self/jsp/mobileCheckMercName.action")
//校验机身序列号
#define API_Checkout_MachineCode   (TEST_COMMONT_URL"/self/jsp/mobileCheckTermNo.action")
//新增商户
#define API_Add_SH                 (TEST_COMMONT_URL"/self/jsp/mobileAddMercApp.action")
//商户查询
#define API_Search_SH              (TEST_COMMONT_URL"/self/jsp/mobileQueryMerc.action")
//工作状态查询
#define API_Search_WorkState       (TEST_COMMONT_URL"/self/jsp/mobileProceStatusQuery.action")
//问题工作流查询
#define API_Search_QuestionWorks   (TEST_COMMONT_URL"/self/jsp/mobileErrorWorkFlowQuery.action")
//问题流程商户信息
#define API_Searhc_QuestionSH      (TEST_COMMONT_URL"/self/jsp/mobileErrorWorkFlowMercQuery.action")
//终端绑定
#define API_Binding_Terminal       (TEST_COMMONT_URL"/self/jsp/mobiletermShopBound.action")
//库存查询
#define API_Search_Stock           (TEST_COMMONT_URL"/self/jsp/mobileTermQuery.action")
//机具解绑
#define API_RemoveBinding_Terminal (TEST_COMMONT_URL"/self/jsp/mobileRelieveTerm.action")
//获取(厂商名称 + 机具类型)
#define API_Get_CompanyAndMachineType (TEST_COMMONT_URL"/self/jsp/mobileOwnTermStorageSkip.action")
//获取机具型号
#define API_Get_MachineModel       (TEST_COMMONT_URL"/self/jsp/mobileOwnTermStorageSkip.action")
//自备机入库
#define API_EnterInto_Stock        (TEST_COMMONT_URL"/self/jsp/mobileOwnTermStorage.action")
//库存验证
#define API_Verify_Stock           (TEST_COMMONT_URL"/self/jsp/mobileCheckTermNum.action")


#endif
