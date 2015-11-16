//
//  RemoveBindingRequest.m
//  KuaiRuTong
//
//  Created by HKRT on 15/9/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "RemoveBindingRequest.h"
#import "AFNetworking.h"
#import "DeviceManager.h"
#import "Config.h"
#import "RWDBManager.h"
#import "JSONKit.h"
@implementation RemoveBindingRequest
- (void)removeBindingMachineCode:(NSString *)machineCode completionBlock:(void (^)(NSDictionary *removeBindingDic))completionBlock{
    __block RemoveBindingStatus status =  RemoveBindingNoWifi;
    NSMutableDictionary *removeBindingDic = [[NSMutableDictionary alloc] init];
    if (![DeviceManager isExistenceNetwork]) {
        [removeBindingDic setObject:@"请检查当前网络状态" forKey:@"Info"];
        [removeBindingDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
        completionBlock(removeBindingDic);
    }else{
        if (machineCode == nil) {
            status = RemoveBindingFailed;
            [removeBindingDic setObject:@"查询数据不能全为空" forKey:@"Info"];
            [removeBindingDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
            completionBlock(removeBindingDic);
        }else{
            //商户查询接口地址
            NSString *dealWithURLString =  [API_RemoveBinding_Terminal stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            NSLog(@"url == %@",API_RemoveBinding_Terminal);
            NSMutableDictionary *removeBindingPostDic = [[NSMutableDictionary alloc] init];
            //            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            //            NSString *username = [[userDefaults objectForKey:@"UserInfoData"] objectForKey:@"username"];
            NSString *username = @"agesales";
            
            [removeBindingPostDic setObject:username    forKey:@"name"];
            [removeBindingPostDic setObject:machineCode      forKey:@"pos_num"];
        
            NSLog(@"%@",removeBindingPostDic);
            NSString *jsonStr=[removeBindingPostDic JSONString];
            NSDictionary *jsonPostData = @{@"data":jsonStr};
            NSLog(@"%@",jsonPostData);
            AFHTTPRequestOperationManager *managers = [AFHTTPRequestOperationManager manager];
            managers.responseSerializer = [AFJSONResponseSerializer serializer];
            [managers POST:dealWithURLString parameters:jsonPostData success:^(AFHTTPRequestOperation *operation, id responseObject) {
                id json_RemoveBindingData =[NSJSONSerialization  JSONObjectWithData:operation.responseData options:0 error:nil];
                
                
                NSLog(@"json_RemoveBindingData == %@",json_RemoveBindingData);
                
                if ([json_RemoveBindingData isKindOfClass:[NSDictionary class]]) {
                    if ([json_RemoveBindingData[@"code"] isEqualToString:@"00"]) {
                        //2.确定返回成功
                        status = RemoveBindingSuccess;
                        [removeBindingPostDic setObject:@"解绑成功" forKey:@"Info"];
                        [removeBindingPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(removeBindingPostDic);
                    }else{
                        //确定返回失败
                        status = RemoveBindingFailed;
                        [removeBindingPostDic setObject:json_RemoveBindingData[@"msg"] forKey:@"Info"];
                        [removeBindingPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(removeBindingPostDic);
                    }
                }else{
                    //确定返回失败
                    status = RemoveBindingFailed;
                    [removeBindingPostDic setObject:@"返回数据错误" forKey:@"Info"];
                    [removeBindingPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                    completionBlock(removeBindingPostDic);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                status = RemoveBindingFailed;
                NSLog(@"%@",error);
                [removeBindingPostDic setObject:@"数据库链接错误" forKey:@"Info"];
                [removeBindingPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                completionBlock(removeBindingPostDic);
            }];
        }
    }
    

}
@end
