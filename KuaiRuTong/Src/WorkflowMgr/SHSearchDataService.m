//
//  SearchDataService.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/25.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "SHSearchDataService.h"
#import "SHResultData.h"

@implementation SHSearchDataService


-(void)beginUploadByShopName:(NSString*)shopName withShopCode:(NSString*)shCode andPosCode:(NSString*)posCode{
    //
    NSString *dealWithURLString =  [API_Search_SH stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"url == %@",API_Search_SH);
    NSMutableDictionary *searchSHPostDic = [[NSMutableDictionary alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [[userDefaults objectForKey:@"UserInfoData"] objectForKey:@"username"];
    
    [searchSHPostDic setObject:username forKey:@"name"];

#ifdef Test
    [searchSHPostDic setObject:@"M0058523"  forKey:@"shop_num"];
    [searchSHPostDic setObject:@"Test--陈玉洁"  forKey:@"shop_name"];
    [searchSHPostDic setObject:@"130014122902373" forKey:@"pos_number"];
#else
    [searchSHPostDic setObject:shCode  forKey:@"shop_num"];
    [searchSHPostDic setObject:shopName  forKey:@"shop_name"];
    [searchSHPostDic setObject:posCode forKey:@"pos_number"];
#endif

    searchSHHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:searchSHPostDic cmdCode:CC_Search];
    [self.httpMsgCtrl sendHttpMsg:searchSHHttpMsg];
}


-(void)beginSearchSHDetail:(NSString*)merCode{
    //商户xijie查询接口地址
    NSString *dealWithURLString =  [API_Search_SHDetail stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"url == %@",API_Search_SHDetail);
    NSMutableDictionary *searchSHPostDic = [[NSMutableDictionary alloc] init];
    
#ifdef Test
    [searchSHPostDic setObject:@"M0058523"  forKey:@"shop_num"];

#else
    [searchSHPostDic setObject:merCode  forKey:@"shop_num"];
#endif
    
    searchSHDetailIndoHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:searchSHPostDic cmdCode:CC_SearchSHDetail];
    [self.httpMsgCtrl sendHttpMsg:searchSHDetailIndoHttpMsg];
}


-(void)beginBindWithPara:(NSMutableDictionary*)dic{
    
    NSString *dealWithURLString =  [API_Binding_Terminal stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"url == %@",dealWithURLString);
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [[userDefaults objectForKey:@"UserInfoData"] objectForKey:@"username"];
    
    
#ifdef Test
    [dic setObject:@"agesales"    forKey:@"name"];
#else
    [dic setObject:username    forKey:@"name"];
#endif
    
    
    bindHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:dic cmdCode:CC_UploadNewMachine];
    [self.httpMsgCtrl sendHttpMsg:bindHttpMsg];
}

-(NSMutableArray*)responseArray{
    if (!_responseArray) {
        _responseArray = [[NSMutableArray alloc]init];
    }
    return _responseArray;
}

//-(SHResultData *)detailData{
//    if (!_detailData) {
//        _detailData = [[SHResultData alloc]init];
//    }
//    return _detailData;
//}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    //[self removeOverFlowActivityView];
    if (receiveMsg.cmdCode == CC_Search)
    {
        NSDictionary *dict = receiveMsg.jasonItems;
        NSArray *dataArray = [[NSArray alloc] initWithArray:dict[@"merc"]];
        for (NSDictionary *mod in dataArray) {
            SHResultData *data = [[SHResultData alloc]init];
            data.machine_code = [mod[@"serialNos"] objectAtIndex:0];
            data.mercNum =  mod[@"mercNum"];
            data.mercName =  mod[@"mercName"] ;
            data.mercSta =  mod[@"mercSta"];
            
            [self.responseArray addObject:data];
            
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(getSearchServiceResult:Result:errorMsg:)]) {
            [_delegate getSearchServiceResult:self Result:YES errorMsg:nil];
        }
    }
    else if( receiveMsg.cmdCode == CC_SearchSHDetail)
    {
        NSDictionary *dict = receiveMsg.jasonItems;

        self.detailData.mercNum =  dict[@"mercNum"];
        self.detailData.mercName =  dict[@"mercName"] ;
        self.detailData.mercSta =  dict[@"mercSta"];
        self.detailData.mercMcc =  dict[@"mercMcc"];
        
        NSMutableArray *shopArray = [[NSMutableArray alloc]init];
        NSArray *dataArray = [[NSArray alloc] initWithArray:dict[@"shop"]];
        for (NSDictionary *mod in dataArray) {
            SHShopData *shopData = [[SHShopData alloc]init];
            shopData.shopAddress = mod[@"shopAddress"];
            shopData.shopName = mod[@"shopName"];
            shopData.coun = mod[@"coun"];
            shopData.city = mod[@"city"];
            shopData.provn = mod[@"provn"];
            shopData.serialNos = mod[@"serialNos"];
            [shopArray addObject:shopData];
        }
        self.detailData.shopArray = shopArray;
        
        if (_delegate && [_delegate respondsToSelector:@selector(getSHDetailDataServiceResult:Result:errorMsg:)]) {
            [_delegate getSHDetailDataServiceResult:self Result:YES errorMsg:nil];
        }

    }
    else if ( receiveMsg.cmdCode == CC_TermBind ){
        if (_delegate && [_delegate respondsToSelector:@selector(upLoadMachineInfoServiceResult:Result:errorMsg:)]) {
            [_delegate upLoadMachineInfoServiceResult:self Result:YES errorMsg:nil];
        }
    }
}

@end
