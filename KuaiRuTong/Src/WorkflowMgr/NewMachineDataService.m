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
    NSString *dealWithURLString =  [API_Get_AllCompanyAndMachineType stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"url == %@",dealWithURLString);
    //NSMutableDictionary *getCAndMPostDic =  [[NSMutableDictionary alloc] init];
    
    queryManufactorInfoHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:nil cmdCode:CC_QueryNewMachineRelData];
    [self.httpMsgCtrl sendHttpMsg:queryManufactorInfoHttpMsg];
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
    NSString *strMsg = @"";
    
    if (receiveMsg.cmdCode == CC_CheckKuCunCode)
    {
//        {
//            "termStrust": "",	1：机身号已存在；0：机身号可用
//            "code": "00"
//        }
        
        NSDictionary *dict = receiveMsg.jasonItems;
        if ([dict[@"termStrust"] isEqualToString:@"1"]) {
            isExist = NO;
            strMsg = @"机身号已存在";
        }
        else{
            isExist = YES;
            strMsg = @"机身号可用";
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(checkPosCodeServiceResult:Result:errorMsg:)]) {
            [_delegate checkPosCodeServiceResult:self Result:isExist errorMsg:strMsg];
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
        
//        "termCopInf": {
//            "实达": {		厂商名
//                "拨号POS(非键盘)": [],	机具类型：机具型号[]
//                "移动POS": [		机具类型：机具型号[]
//                          "WP-70"
//                          ],
//                "拨号POS(键盘)": []
//            },
//            "福建联迪": {		厂商名
//                "拨号POS(非键盘)": [		机具类型：机具型号[]
//                               "P1234",
//                               "E330",
//                               "E3300"
//                               ],
//                "移动POS": [
//                          "E550",
//                          "P123"
//                          ],
//                "拨号POS(键盘)": []
//            },
//            ...
//        }

        
        NSDictionary *dict = receiveMsg.jasonItems;
        NSDictionary *dictTermCopInf  = dict[@"termCopInf"];
        
        self.companyNamesArray = [dictTermCopInf allKeys];
        
        NSDictionary *subModel= [dictTermCopInf objectForKey:[self.companyNamesArray objectAtIndex:0]];
        self.machineTypesArray = [subModel allKeys];
        
        NSMutableArray *versionArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.companyNamesArray.count;  i++) {
            NSDictionary *subModel= [dictTermCopInf objectForKey:[self.companyNamesArray objectAtIndex:i]];
            for(NSString *compKey in subModel) {
                NSArray *comp = [subModel objectForKey:compKey];
                for(id obj in comp){
                    [versionArray addObject:obj];
                }
            }
        }
        self.versionArray = versionArray;
//        DLog(@"THE categoryItem info:%@",[categoryItem objectAtIndex:0]);
//        
//        NSDictionary *category= [categoryItem objectAtIndex:0];
//        self.pickerDic = category;
        
//        self.companyNamesArray = [[NSArray alloc] initWithArray:dict[@"termCopInf"]];
//        self.machineTypesArray = [[NSArray alloc] initWithArray:dict[@"terminalType"]];
        
        if (_delegate && [_delegate respondsToSelector:@selector(getManufacturerStorageServiceResult:Result:errorMsg:)]) {
            [_delegate getManufacturerStorageServiceResult:self Result:YES errorMsg:nil];
        }
    }
    
}
@end
