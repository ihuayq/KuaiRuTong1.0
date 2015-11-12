//
//  HttpMsgCtrl.m
//  SuningLottery
//
//  Created by wangrui on 7/3/12.
//  Copyright (c) 2012 suning. All rights reserved.
//

#import <map>
#import "HttpMsgCtrl.h"
#import "AFNetworkTool.h"
//#import "ASIHTTPRequest.h"
//#import "ASINetworkQueue.h"
//#import "UserCenter.h"
#import "DefineConstant.h"
//#import "AutoLoginWithWaitViewCommand.h"
//#import "SNSwitch.h"
//#import "ASIDownloadCache.h"
//#import "PerformanceStatistics.h"

using namespace std;
using std::iterator;

typedef map<int, HttpMessage *> map_send;
typedef map<int, HttpMessage *>::iterator iter_send;
typedef map<int, HttpMessage *>::value_type value_send;

static map_send g_mapSend;


@implementation HttpMsgCtrl

@synthesize lock = _lock;

+ (HttpMsgCtrl *)shareInstance
{
    static dispatch_once_t once;
    static HttpMsgCtrl * __singleton__; 
    dispatch_once( &once, ^{ __singleton__ = [[HttpMsgCtrl alloc] init]; } ); 
    return __singleton__; 
}

- (id)init
{
    
    if (self =[super init])
    {
        _lock = [[NSLock alloc] init];
    }
    
    return self;
}


- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_lock);
    [super dealloc];
}

//获得tagcode(short转int)
- (int)getTagCode:(int)cmdCode
{
	static unsigned short int curCode= 0x0001;
    
	int returnCode = (curCode & 0x0000ffff);
    
	returnCode |=  cmdCode << 16 & 0xffff0000;
    
	[self.lock lock];
    
    curCode++;
    
    if (0xffff == curCode)
    {
        curCode = 0x0001;
    }
	
	[self.lock unlock];
    
    return returnCode;
}
//得到cmdcode(int转short)
- (int)getCmdcode:(int)tagCode
{
	int returnCode = tagCode >>16 & 0x0000ffff;
    
	return returnCode;
}

#pragma mark -
#pragma mark Send http request
- (void)sendHttpMsg:(HttpMessage *)sendMsg
{
    int msgTag = [self getTagCode:sendMsg.cmdCode];
    
    
    if (sendMsg.requestMethod == RequestMethodPost) {
        [AFNetworkTool postJSONWithUrl:sendMsg.requestUrl  parameters:sendMsg.postDataDic success:^(id json) {
            //DLog(@"%@", json);
            // 提示:NSURLConnection异步方法回调,是在子线程
            // 得到回调之后,通常更新UI,是在主线程
            //NSLog(@"%@", [NSThread currentThread]);
            
           
            if ([json isKindOfClass:[NSDictionary class]]) {
                sendMsg.jasonItems = json;
            }
            
            if ([sendMsg.delegate respondsToSelector:@selector(receiveDidFinished:)])
            {
                [sendMsg.delegate receiveDidFinished:sendMsg];
            }

            
        } fail:^(NSError *error){
            DError(@"请求失败");
        }];
    }
    
    
    [self.lock lock];
    
    // 这里retain 一次 方便外部释放对应
    [sendMsg retain];
    
    NSLog(@"%lu",sendMsg.retainCount);
    
    g_mapSend.insert(value_send(msgTag, sendMsg));
    
    [self.lock unlock];
}


- (void)requestDidFinished:(id) json message:(HttpMessage *)sendMsg
{
    
    int msgTag = [self getTagCode:sendMsg.cmdCode];
    
    [self.lock lock];
    iter_send it = g_mapSend.find(msgTag);
    [self.lock unlock];

    if (it != g_mapSend.end())
    {
        
        HttpMessage *sendMsg = it->second;
        
//      sendMsg.responseString = request.responseString;
//      sendMsg.errorCode = request.errorCode;
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            sendMsg.jasonItems = json;
        }

        if ([sendMsg.delegate respondsToSelector:@selector(receiveDidFinished:)])
        {
            [sendMsg.delegate receiveDidFinished:sendMsg];
        }
    }
    
    
    [self.lock lock];

    g_mapSend.erase(it);

    [self.lock unlock];
}
//
//        if (request.isShouXian)
//            sendMsg.isShouXian = YES;
//
//        //判断登录是否失效
//        if ([sendMsg.errorCode isKindOfClass:[NSString class]] &&
//            [sendMsg.errorCode isEqualToString:@"5015"] &&
//            [UserCenter defaultCenter].isLogined)
//        {
//            [self loginSessionFailedNeedAutoLogin:YES shouldPresentLoginVCAfterFail:YES];
//        }
//        NSString *jsonStat = sendMsg.jasonItems?@"Ok":@"fail";
////            [self.delegate requestDidFinished:logStr];
////
////            NSString *logstr1 = @"cookies : \n";
////
////            for (NSHTTPCookie *cookie in cookies)
////            {
////                logstr1 = [logstr1 stringByAppendingString:[NSString stringWithFormat:@"name : %@; value : %@\n", cookie.name, cookie.value]];
////            }
////
////            [self.delegate requestDidFinished:logstr1];
////
////            NSDate *date = [NSDate date];
////            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
////            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
////            NSString *datestr = [formatter stringFromDate:date];
////
////            [self.delegate requestDidFinished:datestr];
////
////            NSString *sep = @"=============================================================================================end\n";
////            [self.delegate requestDidFinished:sep];
////        }
//
//        if ([jsonStat isEqualToString:@"fail"]&&(([request responseStatusCode] == 200)||([request responseStatusCode] >= 400)))
//        {
//            [self httpError:request isJson:YES];
//        }
//        sendMsg.responseStatusCode = [request responseStatusCode];
//        sendMsg.error = [request error];
//
//        if (sendMsg.responseStatusCode == 200)
//        {
//            if (sendMsg.jasonItems) {
//                if ([sendMsg.delegate respondsToSelector:@selector(receiveDidFinished:)])
//                {
//                    [sendMsg.delegate receiveDidFinished:sendMsg];
//                }
//            } else {
//                //登录是否需要验证码的请求返回的不是json格式，只是个字符串，因此特殊处理。2014-10-14 储鹏
//                if (sendMsg.cmdCode == CC_CheckNeedVerifyCode)
//                {
//                    [sendMsg.delegate receiveDidFinished:sendMsg];
//                    goto getout;
//                }
//
//                sendMsg.error = [NSError errorWithDomain:@"HttpMsgCtrlErrorDomain"
//                                                    code:10021
//                                                userInfo:nil];
//                if ([sendMsg.delegate respondsToSelector:@selector(receiveDidFailed:)])
//                {
//                    [sendMsg.delegate receiveDidFailed:sendMsg];
//                }
//            }
//        }
//        else
//        {
//            if ([sendMsg.delegate respondsToSelector:@selector(receiveDidFailed:)])
//            {
//                [sendMsg.delegate receiveDidFailed:sendMsg];
//            }
//        }
//
//getout:
//        [self.lock lock];
//
//        [sendMsg release];
//
//        g_mapSend.erase(it);
//
//        [self.lock unlock];
//    }
//
//}

- (void)cancelHttpRequest:(HttpMessage *)msg
{
    if (msg == nil) {
        return;
    }
    
    
//    for (ASIHTTPRequest *request in [self.networkQueue operations])
//    {
//        [self.lock lock];
//        iter_send it = g_mapSend.find(request.tag);
//        [self.lock unlock];
//        
//        if (it != g_mapSend.end())
//        {
//            HttpMessage *sendMsg = it->second;
//            if (sendMsg == msg) {
//                
//                [request clearDelegatesAndCancel];
//                
//                DLog(@"cancel %#x success", msg.cmdCode);
//                break;
//            }
//        }
//	}
}

//- (BOOL)isRunningHttpMessage:(HttpMessage *)msg dependOperations:(NSArray **)operations
//{
//    if (msg == nil) {
//        return NO;
//    }
//    
//    NSMutableArray *depOpers = [[[NSMutableArray alloc] init] autorelease];
//    for (ASIHTTPRequest *request in [self.networkQueue operations])
//    {
//        [self.lock lock];
//        iter_send it = g_mapSend.find(request.tag);
//        [self.lock unlock];
//        
//        if (it != g_mapSend.end())
//        {
//            HttpMessage *sendMsg = it->second;
//            if ([sendMsg.requestUrl isEqualToString:msg.requestUrl]) {
//                [depOpers addObject:request];
//            }
//        }
//	}
//    if ([depOpers count] > 0) {
//        *operations = depOpers;
//        return YES;
//    }
//    
//    return NO;
//}


#pragma mark - AutoLogin Command Delegate Methods

/* deprecated
//访问受限资源自动登录失败后，改为手动登录
- (void)commandDidFailed:(id<Command>)cmd
{
    if ([cmd isKindOfClass:[AutoLoginWithWaitViewCommand class]])
    {
        UserInfoDTO *userInfoDTO = [UserCenter defaultCenter].userInfoDTO;
        [UserCenter defaultCenter].lastUserId = userInfoDTO.userId;
        [[UserCenter defaultCenter] clearUserInfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE_NEED_LOGIN object:nil];
        
    }
}
 */

//- (void)loginSessionFailedNeedAutoLogin:(BOOL)autoLogon shouldPresentLoginVCAfterFail:(BOOL)shouldPresentLoginView
//{
//    [UserCenter defaultCenter].lastUserId = [UserCenter defaultCenter].userInfoDTO.userId;
//    [[UserCenter defaultCenter] clearUserInfo];
//    [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE object:nil];
//    
//    //自动登录
//    if (autoLogon)
//    {
//        AutoLoginWithWaitViewCommand *loginCmd = [AutoLoginWithWaitViewCommand command];
//        [CommandManage excuteCommand:loginCmd completeBlock:^(id<Command> cmd) {
//            
//            AutoLoginWithWaitViewCommand *cmd_ = (AutoLoginWithWaitViewCommand *)cmd;
//            
//            if (cmd_.isLoginOk)
//            {
//                UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//                TabBarController *tab = (TabBarController*)keyWindow.rootViewController;
//                AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[tab selectedViewController];
//                UIViewController *v = [nav topViewController];
//                
//                //手动刷新一下，让v重新请求页面数据
//                [v viewWillAppear:NO];
//                [v viewDidAppear:NO];
//            }
//            else if (shouldPresentLoginView)
//            {
//                [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE_NEED_LOGIN object:nil];
//            }
//        }];
//    }
//}

/* deprecated
- (void)commandDidFinish:(id<Command>)cmd
{
    if ([cmd isKindOfClass:[AutoLoginWithWaitViewCommand class]])
    {
        AutoLoginWithWaitViewCommand *cmd_ = (AutoLoginWithWaitViewCommand *)cmd;
        
        if (cmd_.isLoginOk)
        {
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            TabBarController *tab = (TabBarController*)keyWindow.rootViewController;
            AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[tab selectedViewController];
            UIViewController *v = [nav topViewController];
            
            //手动刷新一下，让v重新请求页面数据
            [v viewWillAppear:NO];
            [v viewDidAppear:NO];
        }
        else
        {
//            UserInfoDTO *userInfoDTO = [UserCenter defaultCenter].userInfoDTO;
//            [UserCenter defaultCenter].lastUserId = userInfoDTO.userId;
//            [[UserCenter defaultCenter] clearUserInfo];
//            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE_NEED_LOGIN object:nil];
        }
        
    }
}
*/
//#pragma mark -
//#pragma mark Request delegate methods
//- (void)requestDidStart:(ASIHTTPRequest *)request
//{
//    
//}
//
//- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
//{
////    UserInfoDTO *userInfoDTO = [UserCenter defaultCenter].userInfoDTO;
////    [UserCenter defaultCenter].lastUserId = userInfoDTO.userId;
////    
////    [[UserCenter defaultCenter] clearUserInfo];
////    AutoLoginWithWaitViewCommand *loginCmd = [AutoLoginWithWaitViewCommand command];
////    [CommandManage excuteCommand:loginCmd observer:self];
////    
////    return;
//    
//    if ([UserCenter defaultCenter].isLogined)
//    {
//        //如果是注销接口就不做判断
//        int cmdCode = [self getCmdcode:request.tag];
//        if (cmdCode == CC_Logout) {
//            return;
//        }
//        
//        UserInfoDTO *userInfoDTO = [UserCenter defaultCenter].userInfoDTO;
//        NSArray *responseCookies = request.responseCookies;
//        
//        //chupeng 2013-1-3 如果是passport登陆方式，通过判断head头里的标志位确认登陆session是否失效
//        NSString *loginFlag = nil;
//        id temp = [responseHeaders objectForKey:@"passport.login.flag"];
//        if ([temp isKindOfClass:[NSString class]])
//        {
//            loginFlag = temp;
//        }
//        else if ([temp isKindOfClass:[NSNumber class]])
//        {
//            loginFlag = [temp stringValue];
//        }
//        if (NotNilAndNull(loginFlag))
//        {
//            [self loginSessionFailedNeedAutoLogin:YES shouldPresentLoginVCAfterFail:YES];
//            
//            request.isShouXian = YES;
//            return;
//        }
//
//        NSString *cookieName = nil;
//        NSString *cookieValue = nil;
//        
//        for (NSHTTPCookie *cookie in responseCookies)
//        {
//            cookieName = [cookie name];
//            cookieValue = [cookie value];
//            
//            if ([cookieName rangeOfString:userInfoDTO.userId].location != NSNotFound
//                && [cookieValue isEqualToString:@"DEL"])
//            {
//                //判断是不是受限资源
//                BOOL isShouXianSouce = NO;
//                [self.lock lock];
//                
//                iter_send it = g_mapSend.find(request.tag);
//                
//                [self.lock unlock];
//                
//                if (it != g_mapSend.end())
//                {
//                    HttpMessage *sendMsg = it->second;
//                    
//                    if (CC_Login_Contain(sendMsg.cmdCode)) {
//                        
//                        isShouXianSouce = YES;
//                        
//                        request.isShouXian = YES;
//                    }
//                }
//                
//                //受限资源的话，在自动登录失败后要弹出登录页面
//                [self loginSessionFailedNeedAutoLogin:YES shouldPresentLoginVCAfterFail:isShouXianSouce];
//                
//                break;
//            }
//        }
//    }
//}
//
//- (void)requestDidFinished:(ASIHTTPRequest *)request
//{
//    [self.lock lock];
//    
//    iter_send it = g_mapSend.find(request.tag);
//    
//    [self.lock unlock];
//    
//    if (it != g_mapSend.end())
//    {
//        HttpMessage *sendMsg = it->second;
//        
//        sendMsg.responseString = request.responseString;
//        sendMsg.errorCode = request.errorCode;
//        sendMsg.jasonItems = request.jasonItems;
//        
//        if (request.isShouXian)
//            sendMsg.isShouXian = YES;
//        
//        //判断登录是否失效
//        if ([sendMsg.errorCode isKindOfClass:[NSString class]] &&
//            [sendMsg.errorCode isEqualToString:@"5015"] &&
//            [UserCenter defaultCenter].isLogined)
//        {
//            [self loginSessionFailedNeedAutoLogin:YES shouldPresentLoginVCAfterFail:YES];
//        }
//        NSString *jsonStat = sendMsg.jasonItems?@"Ok":@"fail";
//#ifdef DEBUGLOG
//        
//        NSArray *cookies = [request requestCookies];
//        NSString *cookieName = nil;
//        NSString *cookieValue = nil;
//        for (NSHTTPCookie *cookie in cookies)
//        {
//            cookieName = [cookie name];
//            if ([cookieName isEqualToString:@"WC_SERVER"]) {
//                cookieValue = [cookie value];
//                break;
//            }
//        }
//        
//        NSMutableString *urlString = [[NSMutableString alloc] initWithString:sendMsg.requestUrl];
//        if(sendMsg.postDataDic != nil)
//        {
//            [urlString appendString:@"?"];
//            NSArray *allKeys = [sendMsg.postDataDic allKeys];
//            for(NSString *key in allKeys)
//            {
//                [urlString appendFormat:@"%@=%@&", key, [sendMsg.postDataDic objectForKey:key]];
//            }
//        }
//        
//        //add by zhangbeibei:
//        NSString *absoluteString = nil;
//        if (sendMsg.postDataDic == nil) {
//            absoluteString = [urlString substringWithRange:NSMakeRange(0, urlString.length)];
//        }
//        else {
//            absoluteString = [urlString substringWithRange:NSMakeRange(0, urlString.length-1)];
//        }
//        TT_RELEASE_SAFELY(urlString);
//        SNLogDebug(@"\n=============================================================================================begin\n----sendMsg id =  %#x\n----requestUrl = %@ \n----UrlParaDic =  %@\n----absoluteUrl = %@ \n----WC_SERVER : cell%@\n----Response: (status %d) (JSON %@) = \n%@\n=============================================================================================end\n",sendMsg.cmdCode, sendMsg.requestUrl, sendMsg.postDataDic, absoluteString, cookieValue, request.responseStatusCode, jsonStat, [sendMsg.responseString formatJSON]);
//        
//        
//#endif
////        if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinished:)])
////        {
////            NSArray *cookies = [request requestCookies];
////            NSString *cookieName = nil;
////            NSString *cookieValue = nil;
////            
////            for (NSHTTPCookie *cookie in cookies)
////            {
////                cookieName = [cookie name];
////                if ([cookieName isEqualToString:@"WC_SERVER"]) {
////                    cookieValue = [cookie value];
////                    break;
////                }
////            }
////            //        if (sendMsg.cmdCode == CC_SyncShopCart)
////            //        {
////            //            SNLogDebug(@"requestCookies：\n %@", cookies);
////            //        }
////            
////            NSMutableString *urlString = [[NSMutableString alloc] initWithString:sendMsg.requestUrl];
////            if(sendMsg.postDataDic != nil)
////            {
////                [urlString appendString:@"?"];
////                NSArray *allKeys = [sendMsg.postDataDic allKeys];
////                for(NSString *key in allKeys)
////                {
////                    [urlString appendFormat:@"%@=%@&", key, [sendMsg.postDataDic objectForKey:key]];
////                }
////            }
////            
////            //add by zhangbeibei:
////            NSString *absoluteString = nil;
////            if (sendMsg.postDataDic == nil) {
////                absoluteString = [urlString substringWithRange:NSMakeRange(0, urlString.length)];
////            }
////            else {
////                absoluteString = [urlString substringWithRange:NSMakeRange(0, urlString.length-1)];
////            }
////            TT_RELEASE_SAFELY(urlString);
////            
////            
////            
////            
////            NSString *logStr = [NSString stringWithFormat:@"\n=============================================================================================begin\n----sendMsg id =  %#x\n----requestUrl = %@ \n----UrlParaDic =  %@\n----absoluteUrl = %@ \n----WC_SERVER : cell%@\n----Response: (status %d) (JSON %@) = \n%@\n",sendMsg.cmdCode, sendMsg.requestUrl, sendMsg.postDataDic, absoluteString, cookieValue, request.responseStatusCode, jsonStat, [sendMsg.responseString formatJSON]];
////            
////            [self.delegate requestDidFinished:logStr];
////            
////            NSString *logstr1 = @"cookies : \n";
////            
////            for (NSHTTPCookie *cookie in cookies)
////            {
////                logstr1 = [logstr1 stringByAppendingString:[NSString stringWithFormat:@"name : %@; value : %@\n", cookie.name, cookie.value]];
////            }
////            
////            [self.delegate requestDidFinished:logstr1];
////            
////            NSDate *date = [NSDate date];
////            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
////            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
////            NSString *datestr = [formatter stringFromDate:date];
////            
////            [self.delegate requestDidFinished:datestr];
////            
////            NSString *sep = @"=============================================================================================end\n";
////            [self.delegate requestDidFinished:sep];
////        }
//        
//        if ([jsonStat isEqualToString:@"fail"]&&(([request responseStatusCode] == 200)||([request responseStatusCode] >= 400)))
//        {
//            [self httpError:request isJson:YES];
//        }
//        sendMsg.responseStatusCode = [request responseStatusCode];
//        sendMsg.error = [request error];
//        
//        if (sendMsg.responseStatusCode == 200)
//        {
//            if (sendMsg.jasonItems) {
//                if ([sendMsg.delegate respondsToSelector:@selector(receiveDidFinished:)])
//                {
//                    [sendMsg.delegate receiveDidFinished:sendMsg];
//                }
//            } else {
//                //登录是否需要验证码的请求返回的不是json格式，只是个字符串，因此特殊处理。2014-10-14 储鹏
//                if (sendMsg.cmdCode == CC_CheckNeedVerifyCode)
//                {
//                    [sendMsg.delegate receiveDidFinished:sendMsg];
//                    goto getout;
//                }
//                
//                sendMsg.error = [NSError errorWithDomain:@"HttpMsgCtrlErrorDomain"
//                                                    code:10021
//                                                userInfo:nil];
//                if ([sendMsg.delegate respondsToSelector:@selector(receiveDidFailed:)])
//                {
//                    [sendMsg.delegate receiveDidFailed:sendMsg];
//                }
//            }
//        }
//        else
//        {
//            if ([sendMsg.delegate respondsToSelector:@selector(receiveDidFailed:)])
//            {
//                [sendMsg.delegate receiveDidFailed:sendMsg];
//            }
//        }
//        
//getout:
//        [self.lock lock];
//        
//        [sendMsg release];
//        
//        g_mapSend.erase(it);
//        
//        [self.lock unlock];
//    }
//    
//}
//
//- (void)requestDidFailed:(ASIHTTPRequest *)request
//{
//    [self.lock lock];
//    
//    iter_send it = g_mapSend.find(request.tag);
//    
//    [self.lock unlock];
//    
//    if (it != g_mapSend.end())
//    {
//        HttpMessage *sendMsg = it->second;
//        
//        sendMsg.error = [request error];
//        sendMsg.responseStatusCode = [request responseStatusCode];
//        
//        if (request.isShouXian)
//            sendMsg.isShouXian = YES;
//#ifdef DEBUGLOG
//        
//        NSArray *cookies = [request requestCookies];
//        NSString *cookieName = nil;
//        NSString *cookieValue = nil;
//        for (NSHTTPCookie *cookie in cookies)
//        {
//            cookieName = [cookie name];
//            if ([cookieName isEqualToString:@"WC_SERVER"]) {
//                cookieValue = [cookie value];
//                break;
//            }
//        }
//        
//        NSMutableString *urlString = [[NSMutableString alloc] initWithString:sendMsg.requestUrl];
//        if(sendMsg.postDataDic != nil)
//        {
//            [urlString appendString:@"?"];
//            NSArray *allKeys = [sendMsg.postDataDic allKeys];
//            for(NSString *key in allKeys)
//            {
//                [urlString appendFormat:@"%@=%@&", key, [sendMsg.postDataDic objectForKey:key]];
//            }
//        }
//        NSString *absoluteString = [urlString substringWithRange:NSMakeRange(0, urlString.length-1)];
//        TT_RELEASE_SAFELY(urlString);
//        
//        DLog(@"\n=============================================================================================begin\n----sendMsg id =  %#x\n----requestUrl = %@ \n----UrlParaDic =  %@\n----absoluteUrl = %@ \n----WC_SERVER : cell%@\n----Response Fail : (status %d) \n=============================================================================================end\n",sendMsg.cmdCode, sendMsg.requestUrl, sendMsg.postDataDic, absoluteString, cookieValue, request.responseStatusCode);
//        
//#endif
//        
//        [self httpError:request isJson:NO];
//        if ([sendMsg.delegate respondsToSelector:@selector(receiveDidFailed:)])
//        {
//            
//            
//            [sendMsg.delegate receiveDidFailed:sendMsg];
//        }
//        
//        [self.lock lock];
//        
//        [sendMsg release];
//        
//        g_mapSend.erase(it);
//        
//        [self.lock unlock];
//    }
//}
//
//-(void)httpError:(ASIHTTPRequest *)request isJson:(BOOL)isJsonError
//{
//    if (KPerformance)
//    {
//        iter_send it = g_mapSend.find(request.tag);
//        HttpMessage *sendMsg = it->second;
//        NSMutableString *urlString = [[NSMutableString alloc] initWithString:sendMsg.requestUrl];
//        if(sendMsg.postDataDic != nil)
//        {
//            [urlString appendString:@"?"];
//            NSArray *allKeys = [sendMsg.postDataDic allKeys];
//            for(NSString *key in allKeys)
//            {
//                [urlString appendFormat:@"%@=%@&", key, [sendMsg.postDataDic objectForKey:key]];
//            }
//        }
//        NSString *absoluteString = [urlString substringWithRange:NSMakeRange(0, urlString.length-1)];
//        NSString* code = [NSString stringWithFormat:@"%d",request.responseStatusCode];
//        if (isJsonError&&(request.responseStatusCode == 200))
//        {
//            code = [NSString stringWithFormat:@"%@",@"1000"];
//        }
//        PerformanceStatisticsHttp* errorHttp = [[PerformanceStatisticsHttp alloc] init];
//        errorHttp.startTime = [NSDate date];
//        errorHttp.url = [NSString stringWithFormat:@"%@",absoluteString];
//        errorHttp.errorCode = [NSString stringWithFormat:@"%@",code];
//        [[PerformanceStatistics sharePerformanceStatistics]sendCustomErrorData:errorHttp];
//
//    }
//    
//}

@end
