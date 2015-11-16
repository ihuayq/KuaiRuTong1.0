//
//  GetMachineModelRequest.m
//  KuaiRuTong
//
//  Created by HKRT on 15/11/4.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import "GetMachineModelRequest.h"
#import "AFNetworking.h"
#import "DeviceManager.h"
#import "Config.h"
#import "RWDBManager.h"
#import "JSONKit.h"
@implementation GetMachineModelRequest
- (void)getMachineModelFromCompayName:(NSString *)companyName AndMachineType:(NSString *)machineType completionBlock:(void (^)(NSDictionary *getMachineModelDic))completionBlock{
    __block GetMachineModelStatus status =  GetMachineModelNoWifi;
    NSMutableDictionary *getMachineModelDic = [[NSMutableDictionary alloc] init];
    if (![DeviceManager isExistenceNetwork]) {
        [getMachineModelDic setObject:@"请检查当前网络状态" forKey:@"Info"];
        [getMachineModelDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
        completionBlock(getMachineModelDic);
    }else{
        if ((companyName == nil)||(machineType == nil)) {
            status = GetMachineModelFailed;
            [getMachineModelDic setObject:@"查询数据不能全为空" forKey:@"Info"];
            [getMachineModelDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
            completionBlock(getMachineModelDic);
        }else{
            //商户查询接口地址
            NSString *dealWithURLString =  [API_Verify_Stock stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            NSLog(@"url == %@",dealWithURLString);
            NSMutableDictionary *getMachineModelPostDic = [[NSMutableDictionary alloc] init];
            [getMachineModelPostDic setObject:companyName      forKey:@"termCopName"];
            [getMachineModelPostDic setObject:machineType      forKey:@"termType"];
            
            NSLog(@"%@",getMachineModelPostDic);
            NSString *jsonStr=[getMachineModelPostDic JSONString];
            NSDictionary *jsonPostData = @{@"data":jsonStr};
            NSLog(@"%@",jsonPostData);
            
            AFHTTPRequestOperationManager *managers = [AFHTTPRequestOperationManager manager];
            managers.responseSerializer = [AFJSONResponseSerializer serializer];
            [managers POST:dealWithURLString parameters:jsonPostData success:^(AFHTTPRequestOperation *operation, id responseObject) {
                id json_GetMachineModelData =[NSJSONSerialization  JSONObjectWithData:operation.responseData options:0 error:nil];
                
                
                NSLog(@"json_GetMachineModelData == %@",json_GetMachineModelData);
                
                if ([json_GetMachineModelData isKindOfClass:[NSDictionary class]]) {
                    if ([json_GetMachineModelData[@"code"] isEqualToString:@"00"]) {
                        //2.确定返回成功
                        status = GetMachineModelSuccess;
                        [getMachineModelPostDic setObject:@"验证成功" forKey:@"Info"];
                        [getMachineModelPostDic setObject:json_GetMachineModelData[@"termStrust"] forKey:@"message"];
                        [getMachineModelPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(getMachineModelPostDic);
                    }else{
                        //确定返回失败
                        status = GetMachineModelFailed;
                        [getMachineModelPostDic setObject:json_GetMachineModelData[@"msg"] forKey:@"Info"];
                        [getMachineModelPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(getMachineModelPostDic);
                    }
                }else{
                    //确定返回失败
                    status = GetMachineModelFailed;
                    [getMachineModelPostDic setObject:@"返回数据错误" forKey:@"Info"];
                    [getMachineModelPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                    completionBlock(getMachineModelPostDic);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                status = GetMachineModelFailed;
                NSLog(@"%@",error);
                [getMachineModelPostDic setObject:@"数据库链接错误" forKey:@"Info"];
                [getMachineModelPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                completionBlock(getMachineModelPostDic);
            }];
        }
    }

}
@end
