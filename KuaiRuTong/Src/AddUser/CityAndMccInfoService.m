//
//  CityAndMccInfoService.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/19.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "CityAndMccInfoService.h"

@implementation CityAndMccInfoService



-(void)beginRequest{
    

    NSString *dealWithURLString =  [API_RequestAddressAndMccInfo stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];

    infoHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:nil cmdCode:CC_CITYANDMCC_QUERY];

    [self.httpMsgCtrl sendHttpMsg:infoHttpMsg];
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
        if (receiveMsg.cmdCode == CC_CITYANDMCC_QUERY)
    {
        NSDictionary *item = receiveMsg.jasonItems;
        //DLog(@"THE Login info:%@",item);
        
        NSArray *categoryItem = [item objectForKey:@"categoryList"];
        //DLog(@"THE categoryItem info:%@",[categoryItem objectAtIndex:0]);
        
        NSDictionary *category= [categoryItem objectAtIndex:0];
        self.pickerDic = category;
        
        if (_delegate && [_delegate respondsToSelector:@selector(getCityAndMccInfoServiceResult:Result:errorMsg:)]) {
            [_delegate getCityAndMccInfoServiceResult:self Result:YES errorMsg:nil];
        }
        
    }
}

@end
