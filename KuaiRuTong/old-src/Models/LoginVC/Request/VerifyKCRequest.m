//
//  VerifyKCRequest.m
//  KuaiRuTong
//
//  Created by HKRT on 15/11/3.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import "VerifyKCRequest.h"
#import "AFNetworking.h"
#import "DeviceManager.h"
#import "Config.h"
#import "RWDBManager.h"
#import "JSONKit.h"
@implementation VerifyKCRequest
- (void)verifyKCMachineCode:(NSString *)machineCode completionBlock:(void (^)(NSDictionary *verifyKuCunDic))completionBlock{
    __block VerifyKCStatus status =  VerifyKCNoWifi;
    NSMutableDictionary *verifyKuCunDic = [[NSMutableDictionary alloc] init];
    if (![DeviceManager isExistenceNetwork]) {
        [verifyKuCunDic setObject:@"请检查当前网络状态" forKey:@"Info"];
        [verifyKuCunDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
        completionBlock(verifyKuCunDic);
    }else{
        if (machineCode == nil) {
            status = VerifyKCFailed;
            [verifyKuCunDic setObject:@"查询数据不能全为空" forKey:@"Info"];
            [verifyKuCunDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
            completionBlock(verifyKuCunDic);
        }else{
            //商户查询接口地址
            NSString *dealWithURLString =  [API_Verify_Stock stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            NSLog(@"url == %@",dealWithURLString);
            NSMutableDictionary *verifyKuCunPostDic = [[NSMutableDictionary alloc] init];
            [verifyKuCunPostDic setObject:machineCode      forKey:@"termNum"];
            
            NSLog(@"%@",verifyKuCunPostDic);
            NSString *jsonStr=[verifyKuCunPostDic JSONString];
            NSDictionary *jsonPostData = @{@"data":jsonStr};
            NSLog(@"%@",jsonPostData);
            
            AFHTTPRequestOperationManager *managers = [AFHTTPRequestOperationManager manager];
            managers.responseSerializer = [AFJSONResponseSerializer serializer];
            [managers POST:dealWithURLString parameters:jsonPostData success:^(AFHTTPRequestOperation *operation, id responseObject) {
                id json_VerifyKuCunData =[NSJSONSerialization  JSONObjectWithData:operation.responseData options:0 error:nil];
                
                
                NSLog(@"json_VerifyKuCunData == %@",json_VerifyKuCunData);
                
                if ([json_VerifyKuCunData isKindOfClass:[NSDictionary class]]) {
                    if ([json_VerifyKuCunData[@"code"] isEqualToString:@"00"]) {
                        //2.确定返回成功
                        status = VerifyKCSuccess;
                        [verifyKuCunPostDic setObject:@"验证成功" forKey:@"Info"];
                        [verifyKuCunPostDic setObject:json_VerifyKuCunData[@"termStrust"] forKey:@"message"];
                        [verifyKuCunPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(verifyKuCunPostDic);
                    }else{
                        //确定返回失败
                        status = VerifyKCFailed;
                        [verifyKuCunPostDic setObject:json_VerifyKuCunData[@"msg"] forKey:@"Info"];
                        [verifyKuCunPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                        completionBlock(verifyKuCunPostDic);
                    }
                }else{
                    //确定返回失败
                    status = VerifyKCFailed;
                    [verifyKuCunPostDic setObject:@"返回数据错误" forKey:@"Info"];
                    [verifyKuCunPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                    completionBlock(verifyKuCunPostDic);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                status = VerifyKCFailed;
                NSLog(@"%@",error);
                [verifyKuCunPostDic setObject:@"数据库链接错误" forKey:@"Info"];
                [verifyKuCunPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                completionBlock(verifyKuCunPostDic);
            }];
        }
    }
    
    
}

@end
