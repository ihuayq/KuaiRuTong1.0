//
//  SearchKCRequest.m
//  KuaiRuTong
//
//  Created by HKRT on 15/9/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "SearchKCRequest.h"
#import "AFNetworking.h"
#import "DeviceManager.h"
#import "Config.h"
#import "RWDBManager.h"
#import "JSONKit.h"
@implementation SearchKCRequest
- (void)searchKCShopName:(NSString *)shName AndShopCode:(NSString *)shCode AndMachineCode:(NSString *)machineCode AndBangDingState:(NSString *)bdState completionBlock:(void (^)(NSDictionary *seachKCDic))completionBlock{
    __block SearchKCStatus status =  SearchKCNoWifi;
    NSMutableDictionary *searchKCDic = [[NSMutableDictionary alloc] init];
    if (![DeviceManager isExistenceNetwork]) {
        [searchKCDic setObject:@"请检查当前网络状态" forKey:@"Info"];
        [searchKCDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
        completionBlock(searchKCDic);
    }else{
        if ((shName == nil)&&(shCode == nil)&&(machineCode == nil)&&(bdState == nil)) {
            status = SearchKCFailed;
            [searchKCDic setObject:@"查询数据不能全为空" forKey:@"Info"];
            [searchKCDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
            completionBlock(searchKCDic);
        }else{
            //商户查询接口地址
            NSString *dealWithURLString =  [API_Search_Stock stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            NSLog(@"url == %@",API_Search_Stock);
            NSMutableDictionary *searchKCPostDic = [[NSMutableDictionary alloc] init];
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            NSString *username = [[userDefaults objectForKey:@"UserInfoData"] objectForKey:@"username"];
            NSString *username = @"agesales";
            
            [searchKCPostDic setObject:username    forKey:@"name"];
            [searchKCPostDic setObject:shCode      forKey:@"shop_num"];
            [searchKCPostDic setObject:shName      forKey:@"shop_name"];
            [searchKCPostDic setObject:machineCode forKey:@"pos_num"];
            [searchKCPostDic setObject:bdState     forKey:@"banding_state"];
            
            NSLog(@"%@",searchKCPostDic);
            NSString *jsonStr=[searchKCPostDic JSONString];
            NSDictionary *jsonPostData = @{@"data":jsonStr};
            NSLog(@"%@",jsonPostData);
            AFHTTPRequestOperationManager *managers = [AFHTTPRequestOperationManager manager];
            managers.responseSerializer = [AFJSONResponseSerializer serializer];
            [managers POST:dealWithURLString parameters:jsonPostData success:^(AFHTTPRequestOperation *operation, id responseObject) {
                id json_SearhKCData =[NSJSONSerialization  JSONObjectWithData:operation.responseData options:0 error:nil];
                
                
                NSLog(@"json_SearhKCData == %@",json_SearhKCData);
                
                if ([json_SearhKCData isKindOfClass:[NSDictionary class]]) {
                    if ([json_SearhKCData[@"code"] isEqualToString:@"00"]) {
                        //2.确定返回成功
                        status = SearchKCSuccess;
                        [searchKCPostDic setObject:@"查询成功" forKey:@"Info"];
                        [searchKCPostDic setObject:json_SearhKCData[@"merc"] forKey:@"kunCunData"];
                        [searchKCPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(searchKCPostDic);
                    }else{
                        //确定返回失败
                        status = SearchKCFailed;
                        [searchKCPostDic setObject:json_SearhKCData[@"msg"] forKey:@"Info"];
                        [searchKCPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(searchKCPostDic);
                    }
                }else{
                    //确定返回失败
                    status = SearchKCFailed;
                    [searchKCPostDic setObject:@"返回数据错误" forKey:@"Info"];
                    [searchKCPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                    completionBlock(searchKCPostDic);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                status = SearchKCFailed;
                NSLog(@"%@",error);
                [searchKCPostDic setObject:@"数据库链接错误" forKey:@"Info"];
                [searchKCPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                completionBlock(searchKCPostDic);
            }];
        }
    }

}
@end
