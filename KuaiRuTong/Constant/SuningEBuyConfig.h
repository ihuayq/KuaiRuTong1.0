//
//  SuningEBuyConfig.h
//  SuningEBuy
//
//  Created by  on 12-9-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
//  发布配置文件
//  刘坤  12-9-21

#ifdef DISTRIBUTION_APPSTORE    //----------------发布到AppStore,勿动

#define kReleaseH            1
#define kMobileReleaseH      1
#define kReleaseInfoH        1
#define kAllowInvalidHttps   0

#elif DISTRIBUTION_JAILBROKEN   //----------------越狱渠道发布，勿动

#define kReleaseH            1
#define kMobileReleaseH      1
#define kReleaseInfoH        1
#define kAllowInvalidHttps   0

#else //----------------自己配置

//1、基本网络环境切换
//#define kPreTest        1
//#define kSitTest        1
#define kReleaseH        1


//2、Mobile后台网络环境切换 包括（推送、签到、资讯公共、用户反馈）

//#define kMobileDevTest        1
//#define kMobileSitTest        1

#define kMobileReleaseH        1

//3、信息搜集服务器切换

//#define kPreInfoTest        1
//#define kSitInfoTest        1
#define kReleaseInfoH        1

//4、打印开关控制
#define DEBUGLOG 1

//5、是否允许不受信任的https证书
#define kAllowInvalidHttps   1

#endif
