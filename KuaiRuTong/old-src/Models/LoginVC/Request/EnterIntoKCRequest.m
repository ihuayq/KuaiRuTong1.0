//
//  EnterIntoKCRequest.m
//  KuaiRuTong
//
//  Created by HKRT on 15/11/3.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import "EnterIntoKCRequest.h"
#import "AFNetworking.h"
#import "DeviceManager.h"
#import "Config.h"
#import "RWDBManager.h"
#import "JSONKit.h"
@implementation EnterIntoKCRequest
- (void)enterIntoKuCunRequestCompletionBlock:(void (^)(NSDictionary *enterIntoKCDic))completionBlock{
    __block EnterIntoKCStatus status =  EnterIntoKCNoWifi;
    NSMutableDictionary *enterIntoKCDic = [[NSMutableDictionary alloc] init];
    if (![DeviceManager isExistenceNetwork]) {
        [enterIntoKCDic setObject:@"请检查当前网络状态" forKey:@"Info"];
        [enterIntoKCDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
        completionBlock(enterIntoKCDic);
    }else{
        
        //
        NSString *dealWithURLString =  [API_Get_CompanyAndMachineType stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSLog(@"url == %@",dealWithURLString);
        NSMutableDictionary *enterIntoKCPostDic =  [[NSMutableDictionary alloc] init];
        
        
        NSString *jsonStr=[enterIntoKCPostDic JSONString];
        NSDictionary *jsonPostData = @{@"data":jsonStr};
        NSLog(@"%@",jsonPostData);
        
        AFHTTPRequestOperationManager *managers  =[AFHTTPRequestOperationManager manager];
        managers.responseSerializer = [AFJSONResponseSerializer serializer];
        [managers POST:dealWithURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            id json_EnterIntoKuCunData =[NSJSONSerialization  JSONObjectWithData:operation.responseData options:0 error:nil];
            
            
            NSLog(@"json_EnterIntoKuCunData == %@",json_EnterIntoKuCunData);
            
            if ([json_EnterIntoKuCunData isKindOfClass:[NSDictionary class]]) {
                if ([json_EnterIntoKuCunData[@"code"] isEqualToString:@"00"]) {
                    //2.确定返回成功
                    status = EnterIntoKCSuccess;
                    [enterIntoKCPostDic setObject:@"验证成功" forKey:@"Info"];
                    [enterIntoKCPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                    completionBlock(enterIntoKCPostDic);
                }else{
                    //确定返回失败
                    status = EnterIntoKCFailed;
                    [enterIntoKCPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                    completionBlock(enterIntoKCPostDic);
                }
            }else{
                //确定返回失败
                status = EnterIntoKCFailed;
                [enterIntoKCPostDic setObject:@"返回数据错误" forKey:@"Info"];
                [enterIntoKCPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
                completionBlock(enterIntoKCPostDic);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            status = EnterIntoKCFailed;
            NSLog(@"%@",error);
            [enterIntoKCPostDic setObject:@"数据库链接错误" forKey:@"Info"];
            [enterIntoKCPostDic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
            completionBlock(enterIntoKCPostDic);
        }];
    }
}
@end
