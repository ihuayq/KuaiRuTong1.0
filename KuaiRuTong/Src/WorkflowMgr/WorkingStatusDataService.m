//
//  WorkingStatusDataService.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/26.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "WorkingStatusDataService.h"

@implementation WorkingStatusDataService


//返回字段：
//{
//    "formStatus": "success",	 表单状态
//    "mercNum": "M0058723",	商户编号
//    "mercName": "Test_商户2",	商户名
//    "processId": "201505260943191043567",	任务流水号
//    "date": {	各个岗位审核时间，为空时为未审核
//        "operation": "",	运营审核
//        "sales": "",	销售
//        "inrecodr": "",	运营补录
//        "success": "",	 	审核通过
//    },
//    "proceStatus": ""	处理状态
//    "code": "00",	返回编码
//    "msg":"",	返回信息
//}
//地址：http://192.168.13.30:8080/self/jsp/mobileProceStatusQuery.action
//测试数据：{"name":"agesales","shop_num":"M8000052"}	备用测试商户：M8000057、M8000063、M8000064


-(void)beginUploadByShopName:(NSString*)shopName withShopCode:(NSString*)shCode {
    //商户状态查询地址
    NSString *dealWithURLString =  [API_Search_WorkState stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url == %@",API_Search_WorkState);
    NSMutableDictionary *searchWorkPostDic = [[NSMutableDictionary alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [[userDefaults objectForKey:@"UserInfoData"] objectForKey:@"username"];
#ifdef Test
    [searchWorkPostDic setObject:username forKey:@"name"];
    [searchWorkPostDic setObject:@"M8000057"  forKey:@"shop_num"];
    [searchWorkPostDic setObject:@"agesales"  forKey:@"shop_name"];
#else
    [searchWorkPostDic setObject:username forKey:@"name"];
    [searchWorkPostDic setObject:shCode  forKey:@"shop_num"];
    [searchWorkPostDic setObject:shopName  forKey:@"shop_name"];
#endif
    updateHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:searchWorkPostDic cmdCode:CC_QueryWorkingStatus];
    [self.httpMsgCtrl sendHttpMsg:updateHttpMsg];
}



- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    
    //返回字段：
    //{
    //    "formStatus": "success",	 表单状态
    //    "mercNum": "M0058723",	商户编号
    //    "mercName": "Test_商户2",	商户名
    //    "processId": "201505260943191043567",	任务流水号
    //    "date": {	各个岗位审核时间，为空时为未审核
    //        "operation": "",	运营审核
    //        "sales": "",	销售
    //        "inrecodr": "",	运营补录
    //        "success": "",	 	审核通过
    //    },
    //    "proceStatus": ""	处理状态
    //    "code": "00",	返回编码
    //    "msg":"",	返回信息
    //}
    
    if (receiveMsg.cmdCode == CC_QueryWorkingStatus)
    {
        NSDictionary *dict = receiveMsg.jasonItems;
        
        self.formStatus = dict[@"formStatus"];
        self.mercNum = dict[@"mercNum"];
        self.mercName = dict[@"mercName"];
        self.processId = dict[@"processId"];
        
        NSArray *dataArray = [[NSArray alloc] initWithArray:dict[@"date"]];
        for (NSDictionary *mod in dataArray) {
            self.operation = dict[@"operation"];
            self.sales = dict[@"sales"];
            self.inrecodr = dict[@"inrecodr"];
            self.success = dict[@"success"];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(getSearchServiceResult:Result:errorMsg:)]) {
            [_delegate getSearchServiceResult:self Result:YES errorMsg:nil];
        }
    }
}

@end
