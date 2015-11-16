//
//  SearchSHRequest.m
//  KuaiRuTong
//
//  Created by HKRT on 15/8/7.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "SearchSHRequest.h"
#import "AFNetworking.h"
#import "DeviceManager.h"
#import "Config.h"
#import "RWDBManager.h"
#import "JSONKit.h"
@implementation SearchSHRequest
- (void)searchSHCode:(NSString *)shCode AndshName:(NSString *)shName AndPosCode:(NSString *)posCode completionBlock:(void (^)(NSDictionary *))completionBlock{
    __block SearchSHStatus status =  SearchSHNoWifi;
    NSMutableDictionary *searchSHDic = [[NSMutableDictionary alloc] init];
    if (![DeviceManager isExistenceNetwork]) {
        [searchSHDic setObject:@"请检查当前网络状态" forKey:@"Info"];
        [searchSHDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
        completionBlock(searchSHDic);
    }else{
        if ((shCode == nil)&&(shName == nil)&&(posCode == nil)) {
            status = SearchSHFailed;
            [searchSHDic setObject:@"查询数据不能全为空" forKey:@"Info"];
            [searchSHDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
            completionBlock(searchSHDic);
        }else{
            //商户查询接口地址
            NSString *dealWithURLString =  [API_Search_SH stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            NSLog(@"url == %@",API_Search_SH);
            NSMutableDictionary *searchSHPostDic = [[NSMutableDictionary alloc] init];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *username = [[userDefaults objectForKey:@"UserInfoData"] objectForKey:@"username"];
            
            [searchSHPostDic setObject:username forKey:@"name"];
            [searchSHPostDic setObject:shCode  forKey:@"shop_num"];
            [searchSHPostDic setObject:shName  forKey:@"shop_name"];
            [searchSHPostDic setObject:posCode forKey:@"pos_number"];
            NSLog(@"%@",searchSHPostDic);
            NSString *jsonStr=[searchSHPostDic JSONString];
            NSDictionary *jsonPostData = @{@"data":jsonStr};
            NSLog(@"%@",jsonPostData);
            AFHTTPRequestOperationManager *managers = [AFHTTPRequestOperationManager manager];
            managers.responseSerializer = [AFJSONResponseSerializer serializer];
            [managers POST:dealWithURLString parameters:jsonPostData success:^(AFHTTPRequestOperation *operation, id responseObject) {
                id json_SearhSHData =[NSJSONSerialization  JSONObjectWithData:operation.responseData options:0 error:nil];
                NSLog(@"%@",json_SearhSHData);
                
                if ([json_SearhSHData isKindOfClass:[NSDictionary class]]) {
                    if ([json_SearhSHData[@"code"] isEqualToString:@"00"]) {
                        //2.确定返回成功
                        status = SearchSHSuccess;
                        [searchSHPostDic setObject:@"查询成功" forKey:@"Info"];
                        [searchSHPostDic setObject:json_SearhSHData[@"merc"] forKey:@"desic"];
                        [searchSHPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(searchSHPostDic);
                    }else{
                        //确定返回失败
                        status = SearchSHFailed;
                        [searchSHPostDic setObject:json_SearhSHData[@"msg"] forKey:@"Info"];
                        [searchSHPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(searchSHPostDic);
                    }
                }else{
                    //确定返回失败
                    status = SearchSHFailed;
                    [searchSHPostDic setObject:@"返回数据错误" forKey:@"Info"];
                    [searchSHPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                    completionBlock(searchSHPostDic);
                }
             
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                status = SearchSHFailed;
                [searchSHPostDic setObject:@"数据库链接错误" forKey:@"Info"];
                [searchSHPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                completionBlock(searchSHPostDic);
            }];
        }
    }
}



@end
