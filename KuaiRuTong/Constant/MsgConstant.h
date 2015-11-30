//
//  HttpConstant.h
//  Common Application
//
//  Created by wangrui on 11/25/11.
//  Copyright (c) 2011 suning. All rights reserved.
//


#define HTTP_TIMEOUT    30.0f

typedef enum CmdCode
{
	// 系统命令
	CC_VersionCheck             = 0x0001,//3.8.5 检查版本号 Action:SNMobileGetClientVersionView
    CC_MessagePush              = 0x0002,//3.7.7 获取推送消息接口 Action:SNMobileMessageListView
	CC_NetCheck					= 0x0003,// 网络检测, 无接口
	CC_SpecialSubject           = 0x0004,//获取促销专栏列表
    
	// 个人信息命令
	CC_Login                    = 0x0101,
	CC_Logout					= 0x0102,
    CC_Register                 = 0x0103,
    CC_AccountValidate          = 0x0104,
    CC_ResetPassword            = 0x0105,
    CC_DisCountInfo             = 0x0106,
    
    
    CC_CITYANDMCC_QUERY         = 0x0107,
    CC_BusinessUpload          = 0x0108,
    CC_Search         = 0x0109, //查询商户
    CC_SearchSHDetail         = 0x0110,
    CC_QueryWorkingStatus = 0x0111,
    CC_QueryKuCun = 0x0112,
    CC_QueryKuCunDetail = 0x0113,
    CC_DeleteBind = 0x0114,
    CC_QueryNewMachineRelData = 0x0115,
    CC_CheckKuCunCode = 0x0116,
    CC_UploadNewMachine = 0x0117,   //自备机入库
    CC_TermBind         = 0x0118, //终端绑定
    CC_IssueBusinessDownload          = 0x0119,
    CC_IssueBusinessDownloadFile          = 0x0120
    
} E_CMDCODE;




//需要登录的接口
static const int CC_NEED_LOGIN_QUEUE[] = 
{
    0x0106,
    0x0107,
    0x0108,
    0x0109,
    0x010A,
    0x010B,
    0x010C,
    0x010D,
    0x010E,
    0x010F,
    
    0x030B,
    0x030D,
    
    0x0405,
    0x0406,
    0x0407,
    0x0408,

    
    0x0602,
    0x0603,
    0x0604,
    0x0605,
    0x0605,
    0x0606,
    0x0607,
    0x0608,
    0x0609,
    0x060a,
    0x060b,
    
    
    0x0701,
    0x0702,
    0x0703,
    0x0704,
    
    0x0801,
    0x0802,

    0x0A02,
    0x0A08,
    0x0A09,
    0x0A0A,
    
    0x0B01,
    0x0B02,
    
    0x0C01,
    0x0C02,
    0x0C03,
    0x0C04,
    0x0C05,
    
    0x0D03,
    0x0D04,
    0x0D05,
    0x0D0A,
    0x0D0B,
    0x0D0C,
    
    0x0E04,
    0x0E05,
    0x0E06,
    0x0E07,
    0x0E08,
    0x0E09,
    0x0E0A,
    0x0E0B,

    0x1001,
    0x1002,
    0x1006,
    0x1007,
    0x1008,
    0x1009,
    0x100A,
    0x100B,
    
    0x1101,
    0x1102,
    0x1103,
    0x1104,
    0x1105,
    0x1106,

    0x1201,
    0x1202,
    0x1203,
    0x1204,
    
    0x1305,
    
    0x1605,
    0x1606,
    0x1607,
    0x1609,
    0x160C,
    0x160D,
    
    0x0702,
    0x706,
    0x707,
    0x708,
    
    0X3002
};

//需要重写cookie的接口，例如彩票服务器，酒店服务器的域名不同，需要重写下cookie，否则cookie不能带过去
static const int CC_NEED_COOKIE_QUEUE[] = 
{
//    CC_AgentPurchasePayment     ,
//    
//    CC_EvaluateList             ,
//    CC_EvaluateValidate         ,
//    CC_EvaluatePublish          ,
//    
//    CC_RegistrationDetail       ,
//    CC_StoresRegistration       ,
//    CC_RegistrationPrepare      ,
////    CC_EvaluateProduct          ,
//    CC_ScanerCodeActionLogin,
//    CC_ScanerCodeActionAuthorize
};

