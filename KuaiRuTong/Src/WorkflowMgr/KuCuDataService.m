//
//  KuCuDataService.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/26.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "KuCuDataService.h"
#import "KuCunData.h"

@implementation KuCuDataService

-(void)beginUploadByShopName:(NSString*)shopName withShopCode:(NSString*)shCode andPosCode:(NSString*)posCode andPosStatus:(NSString*)posStatus {

    //库存接口地址
    NSString *dealWithURLString =  [API_Search_Stock stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"url == %@",API_Search_Stock);
    NSMutableDictionary *searchKCPostDic = [[NSMutableDictionary alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [[userDefaults objectForKey:@"UserInfoData"] objectForKey:@"username"];
    
#ifdef Test
    //NSString *username = @"agesales";
    [searchKCPostDic setObject:@"TTest-子商户-陈玉洁"    forKey:@"name"];
    [searchKCPostDic setObject:@"M0058557"      forKey:@"shop_num"];
    
#else
    [searchKCPostDic setObject:username    forKey:@"name"];
    [searchKCPostDic setObject:shCode      forKey:@"shop_num"];
    [searchKCPostDic setObject:posCode forKey:@"pos_num"];

#endif
    
    updateHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:searchKCPostDic cmdCode:CC_QueryKuCun];
    [self.httpMsgCtrl sendHttpMsg:updateHttpMsg];
}


-(void)deleteBindRelationshipByCode:(NSString*)code{
    NSString *dealWithURLString =  [API_RemoveBinding_Terminal stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"url == %@",API_RemoveBinding_Terminal);
    NSMutableDictionary *removeBindingPostDic = [[NSMutableDictionary alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [[userDefaults objectForKey:@"UserInfoData"] objectForKey:@"username"];


#ifdef Test
    //NSString *username = @"agesales";
    [removeBindingPostDic setObject:@"agesales"    forKey:@"name"];
    [removeBindingPostDic setObject:@"dfd78546"      forKey:@"pos_num"];
    
#else
    [removeBindingPostDic setObject:username    forKey:@"name"];
    [removeBindingPostDic setObject:machineCode      forKey:@"pos_num"];
    
#endif
    
    deleteBindHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:removeBindingPostDic cmdCode:CC_DeleteBind];
    [self.httpMsgCtrl sendHttpMsg:deleteBindHttpMsg];
    
}

-(NSMutableArray*)responseArray{
    if (!_responseArray) {
        _responseArray = [[NSMutableArray alloc]init];
    }
    return _responseArray;
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    
//    返回字段：
//    {
//        "mercNum": "M8000076",	商户编号
//        "boundStatus": "已绑定",	绑定状态
//        "mercName": "感冒要飘起来了",	商户名
//        "shopName": "广东各地分公司",	网点名
//        "termNum": "fds13512",	机身序列号
//        "termStatus": "正常机具",	机具状态
//        "shopNum": "00054423",	网点编号
//        "code": "",		返回编码
//        "msg":"",	返回信息
//    }
    
    if (receiveMsg.cmdCode == CC_QueryKuCun)
    {
        NSDictionary *dict = receiveMsg.jasonItems;
        NSArray *dataArray = [[NSArray alloc] initWithArray:dict[@"merc"]];
        for (NSDictionary *mod in dataArray) {
            KuCunData *data = [[KuCunData alloc]init];
            data.shop_name = mod[@"mercName"];
            data.shop_id= mod[@"mercNum"];
            data.netpoint_id= mod[@"shopNum"];
            data.netpoint_name= mod[@"shopName"];
            data.machine_code= mod[@"termNum"];
            data.machine_status= mod[@"termStatus"];
            data.kucun_status= mod[@"boundStatus"];
            data.bind_status = mod[@"boundStatus"];
            
            [self.responseArray addObject:data];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(getSearchServiceResult:Result:errorMsg:)]) {
            [_delegate getSearchServiceResult:self Result:YES errorMsg:nil];
        }
    }
    
    else if (receiveMsg.cmdCode == CC_DeleteBind){
        
        
        if (_delegate && [_delegate respondsToSelector:@selector(deleteBindServiceResult:Result:errorMsg:)]) {
            [_delegate deleteBindServiceResult:self Result:YES errorMsg:nil];
        }
        
    }
}

@end
