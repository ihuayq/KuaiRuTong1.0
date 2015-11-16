//
//  GetCAndMRequest.m
//  KuaiRuTong
//
//  Created by HKRT on 15/11/3.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import "GetCAndMRequest.h"
#import "AFNetworking.h"
#import "DeviceManager.h"
#import "Config.h"
#import "RWDBManager.h"
#import "JSONKit.h"
@implementation GetCAndMRequest
- (void)getCompanyNameAndMachineTypeRequestCompletionBlock:(void (^)(NSDictionary *getCAndMDic))completionBlock{
    __block GetCAndMStatus status =  GetCAndMNoWifi;
    NSMutableDictionary *getCAndMDic = [[NSMutableDictionary alloc] init];
    if (![DeviceManager isExistenceNetwork]) {
        [getCAndMDic setObject:@"请检查当前网络状态" forKey:@"Info"];
        [getCAndMDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
        completionBlock(getCAndMDic);
    }else{
        NSString *dealWithURLString =  [API_Get_CompanyAndMachineType stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSLog(@"url == %@",dealWithURLString);
        NSMutableDictionary *getCAndMPostDic =  [[NSMutableDictionary alloc] init];
        
        
        AFHTTPRequestOperationManager *managers  =[AFHTTPRequestOperationManager manager];
        managers.responseSerializer = [AFJSONResponseSerializer serializer];
        [managers POST:dealWithURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            id json_GetCAndMData =[NSJSONSerialization  JSONObjectWithData:operation.responseData options:0 error:nil];
            
            
            NSLog(@"json_GetCAndMData == %@",json_GetCAndMData);
            
            if ([json_GetCAndMData isKindOfClass:[NSDictionary class]]) {
                                    //2.确定返回成功
                    status = GetCAndMSuccess;
                    [getCAndMPostDic setObject:@"获取成功" forKey:@"Info"];
                [getCAndMPostDic setObject:json_GetCAndMData forKey:@"CAndMData"];
                    [getCAndMPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                    completionBlock(getCAndMPostDic);
                
            }else{
                //确定返回失败
                status = GetCAndMFailed;
                [getCAndMPostDic setObject:@"返回数据错误" forKey:@"Info"];
                [getCAndMPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                completionBlock(getCAndMPostDic);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            status = GetCAndMFailed;
            NSLog(@"%@",error);
            [getCAndMPostDic setObject:@"数据库链接错误" forKey:@"Info"];
            [getCAndMPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
            completionBlock(getCAndMPostDic);
        }];
    }

}
@end
