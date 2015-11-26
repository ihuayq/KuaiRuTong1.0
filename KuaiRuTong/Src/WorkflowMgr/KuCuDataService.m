//
//  KuCuDataService.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/26.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "KuCuDataService.h"

@implementation KuCuDataService

-(void)beginUploadByShopName:(NSString*)shopName withShopCode:(NSString*)shCode andPosCode:(NSString*)posCode{
    
    //商户查询接口地址
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
    
    updateHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:searchSHPostDic cmdCode:CC_Search];
    [self.httpMsgCtrl sendHttpMsg:updateHttpMsg];
}

-(NSMutableArray*)responseArray{
    if (!_responseArray) {
        _responseArray = [[NSMutableArray alloc]init];
    }
    return _responseArray;
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    //[self removeOverFlowActivityView];
    if (receiveMsg.cmdCode == CC_Search)
    {
        NSDictionary *dict = receiveMsg.jasonItems;
        NSArray *dataArray = [[NSArray alloc] initWithArray:dict[@"merc"]];
        for (NSDictionary *mod in dataArray) {
//            SHResultData *data = [[SHResultData alloc]init];
//            data.machine_code = [mod[@"serialNos"] objectAtIndex:0];
//            data.shop_code =  mod[@"mercNum"];
//            data.shop_name =  mod[@"mercName"] ;
//            data.status =  mod[@"mercSta"];
//            
//            [self.responseArray addObject:data];
            
        }
        //        self.responseArray = [[NSMutableArray alloc] initWithArray:dict[@"merc"]];
        
        if (_delegate && [_delegate respondsToSelector:@selector(getSearchServiceResult:Result:errorMsg:)]) {
            [_delegate getSearchServiceResult:self Result:YES errorMsg:nil];
        }
    }
}

@end
