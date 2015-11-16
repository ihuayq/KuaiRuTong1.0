//
//  SearchWorkRequest.m
//  KuaiRuTong
//
//  Created by HKRT on 15/9/16.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "SearchWorkRequest.h"
#import "AFNetworking.h"
#import "DeviceManager.h"
#import "Config.h"
#import "RWDBManager.h"
#import "JSONKit.h"
@implementation SearchWorkRequest
- (void)searchWorkShopName:(NSString *)shName AndShopCode:(NSString *)shCode completionBlock:(void (^)(NSDictionary *searchWorkDic))completionBlock{
    __block SearchWorkStatus status =  SearchWorkNoWifi;
    NSMutableDictionary *searchWorkDic = [[NSMutableDictionary alloc] init];
    if (![DeviceManager isExistenceNetwork]) {
        [searchWorkDic setObject:@"请检查当前网络状态" forKey:@"Info"];
        [searchWorkDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
        completionBlock(searchWorkDic);
    }else{
        if ((shName == nil)&&(shCode == nil)) {
            status = SearchWorkFailed;
            [searchWorkDic setObject:@"查询数据不能全为空" forKey:@"Info"];
            [searchWorkDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
            completionBlock(searchWorkDic);
        }else{
            //商户查询接口地址
            NSString *dealWithURLString =  [API_Search_WorkState stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            NSLog(@"url == %@",API_Search_WorkState);
            NSMutableDictionary *searchWorkPostDic = [[NSMutableDictionary alloc] init];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *username = [[userDefaults objectForKey:@"UserInfoData"] objectForKey:@"username"];
            
            [searchWorkPostDic setObject:username forKey:@"name"];
            [searchWorkPostDic setObject:shCode  forKey:@"shop_num"];
            [searchWorkPostDic setObject:shName  forKey:@"shop_name"];
            
            NSLog(@"%@",searchWorkPostDic);
            NSString *jsonStr=[searchWorkPostDic JSONString];
            NSDictionary *jsonPostData = @{@"data":jsonStr};
            NSLog(@"%@",jsonPostData);
            AFHTTPRequestOperationManager *managers = [AFHTTPRequestOperationManager manager];
            managers.responseSerializer = [AFJSONResponseSerializer serializer];
            [managers POST:dealWithURLString parameters:jsonPostData success:^(AFHTTPRequestOperation *operation, id responseObject) {
                id json_SearhWorkData =[NSJSONSerialization  JSONObjectWithData:operation.responseData options:0 error:nil];
                
                
                NSLog(@"json_SearhWorkData == %@",json_SearhWorkData);
                
                if ([json_SearhWorkData isKindOfClass:[NSDictionary class]]) {
                    if ([json_SearhWorkData[@"code"] isEqualToString:@"00"]) {
                        //2.确定返回成功
                        status = SearchWorkSuccess;
                        [searchWorkPostDic setObject:@"查询成功" forKey:@"Info"];
                        [searchWorkPostDic setObject:json_SearhWorkData forKey:@"jsonInfoData"];
                        [searchWorkPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(searchWorkPostDic);
                    }else{
                        //确定返回失败
                        status = SearchWorkFailed;
                        [searchWorkPostDic setObject:json_SearhWorkData[@"msg"] forKey:@"Info"];
                        [searchWorkPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(searchWorkPostDic);
                    }
                }else{
                    //确定返回失败
                    status = SearchWorkFailed;
                    [searchWorkPostDic setObject:@"返回数据错误" forKey:@"Info"];
                    [searchWorkPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                    completionBlock(searchWorkPostDic);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                status = SearchWorkFailed;
                NSLog(@"%@",error); 
                [searchWorkPostDic setObject:@"数据库链接错误" forKey:@"Info"];
                [searchWorkPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                completionBlock(searchWorkPostDic);
            }];
        }
    }

}
@end
