//
//  NewMachineDataService.m
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/28.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "NewMachineDataService.h"

@implementation NewMachineDataService


-(void)beginUploadByShopName:(NSMutableDictionary*)dic{
    
    
    NSString *dealWithURLString =  [API_EnterInto_Stock stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"url == %@",dealWithURLString);

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [[userDefaults objectForKey:@"UserInfoData"] objectForKey:@"username"];
    
    
#ifdef Test
    [dic setObject:@"agesales"    forKey:@"name"];
#else
    [dic setObject:username    forKey:@"name"];
#endif
    
    
    upLoadHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:dic cmdCode:CC_UploadNewMachine];
    [self.httpMsgCtrl sendHttpMsg:upLoadHttpMsg];
    
}

-(void)getManufacturerStorageData{
    NSString *dealWithURLString =  [API_Get_CompanyAndMachineType stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"url == %@",dealWithURLString);
    //NSMutableDictionary *getCAndMPostDic =  [[NSMutableDictionary alloc] init];
    
    queryManufactorInfoHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:nil cmdCode:CC_QueryNewMachineRelData];
    [self.httpMsgCtrl sendHttpMsg:upLoadHttpMsg];
}


-(void)checkPosCode:(NSString*)posCode{
    NSString *dealWithURLString =  [API_Verify_Stock stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"url == %@",dealWithURLString);
    NSMutableDictionary *verifyKuCunPostDic = [[NSMutableDictionary alloc] init];
    [verifyKuCunPostDic setObject:posCode      forKey:@"termNum"];
    
    checkCodeHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:verifyKuCunPostDic cmdCode:CC_CheckKuCunCode];
    [self.httpMsgCtrl sendHttpMsg:checkCodeHttpMsg];
}


- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    
    BOOL isExist = NO;
    
    if (receiveMsg.cmdCode == CC_CheckKuCunCode)
    {
//        {
//            "termStrust": "",	1：机身号已存在；0：机身号可用
//            "code": "00"
//        }
        NSDictionary *dict = receiveMsg.jasonItems;
        if ([dict[@"termStrust"] isEqualToString:@"1"]) {
            isExist = NO;
        }
        else{
            isExist = YES;
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(checkPosCodeServiceResult:Result:errorMsg:)]) {
            [_delegate checkPosCodeServiceResult:self Result:isExist errorMsg:nil];
        }
    }
    else if (receiveMsg.cmdCode == CC_UploadNewMachine){
        if (_delegate && [_delegate respondsToSelector:@selector(upLoadMachineInfoServiceResult:Result:errorMsg:)]) {
            [_delegate upLoadMachineInfoServiceResult:self Result:YES errorMsg:nil];
        }
    }
    
    else if (receiveMsg.cmdCode == CC_QueryNewMachineRelData){
//        {
//            "termCopInf": [		厂商名
//                           "银点",
//                           "实达"
//                           ...
//                           ],
//            "terminalType": [	机具类型
//                             "拨号POS(非键盘)",
//                             "拨号POS(键盘)",
//                             "移动POS"
//                             ]
//        }
        NSDictionary *dict = receiveMsg.jasonItems;
        self.companyNamesArray = [[NSArray alloc] initWithArray:dict[@"termCopInf"]];
        self.machineTypesArray = [[NSArray alloc] initWithArray:dict[@"terminalType"]];
        
        if (_delegate && [_delegate respondsToSelector:@selector(getManufacturerStorageServiceResult:Result:errorMsg:)]) {
            [_delegate getManufacturerStorageServiceResult:self Result:YES errorMsg:nil];
        }
    }
    
}
@end
