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

    infoHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:nil cmdCode:CC_Login];

    [self.httpMsgCtrl sendHttpMsg:infoHttpMsg];
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    //    [self removeOverFlowActivityView];
    if (receiveMsg.cmdCode == CC_Login)
    {
        NSDictionary *item = receiveMsg.jasonItems;
        //DLog(@"THE Login info:%@",item);
        
        NSArray *categoryItem = [item objectForKey:@"categoryList"];
        DLog(@"THE categoryItem info:%@",[categoryItem objectAtIndex:0]);
        
        NSDictionary *category= [categoryItem objectAtIndex:0];
        
        NSArray *categoryDetail= [category allKeys];
        DLog(@"THE first key info:%@",[category allKeys]);
//
        NSArray *categoryCode = [category objectForKey:[[category allKeys] objectAtIndex:0]];
        DLog(@"THE second key info:%@",categoryCode);
        
        
//        -[CityAndMccInfoService receiveDidFinished:] #46 THE first key info:(
//                                                                             "\U6c11\U751f\U7c7b",
//                                                                             "\U6279\U53d1\U7c7b",
//                                                                             "\U4e00\U822c\U7c7b",
//                                                                             "\U623f\U4ea7\U7c7b",
//                                                                             "\U9910\U996e\U7c7b"
//                                                                             )
//        [;[fg0,0,0;[DEBUG] > -[CityAndMccInfoService receiveDidFinished:] #49 THE second key info:{
//            4111 = "\U672c\U5e02\U548c\U5e02\U90ca\U901a\U52e4\U65c5\U5ba2\U8fd0\U8f93\Uff08\U5305\U62ec\U8f6e\U6e21\Uff09";
//            4112 = "\U94c1\U8def\U5ba2\U8fd0";
//            4121 = "\U51fa\U79df\U8f66\U670d\U52a1";
//            4131 = "\U516c\U8def\U5ba2\U8fd0";
//            4511 = "\U822a\U7a7a\U516c\U53f8";
//            4784 = "\U8def\U6865\U901a\U884c\U8d39";
//            4814 = "\U7535\U4fe1\U670d\U52a1\Uff0c \U5305\U62ec\U672c\U5730\U548c\U957f\U9014\U7535\U8bdd\U3001\U4fe1\U7528\U5361\U7535\U8bdd\U3001\U78c1\U5361\U7535\U8bdd\U548c\U4f20\U771f";
//            4899 = "\U6709\U7ebf\U548c\U5176\U4ed6\U4ed8\U8d39\U7535\U89c6\U670d\U52a1";
//            4900 = "\U516c\U5171\U4e8b\U4e1a\Uff08 \U7535\U529b\U3001\U7164\U6c14\U3001\U81ea\U6765\U6c34\U3001\U6e05\U6d01\U670d\U52a1\Uff09";
//            5411 = "\U5927\U578b\U4ed3\U50a8\U5f0f\U8d85\U7ea7\U5e02\U573a \Uff08\U5feb\U9012\U3001\U7269\U6d41\Uff09";
//            5541 = "\U52a0\U6cb9\U7ad9\U3001\U670d\U52a1\U7ad9";
//            5542 = "\U81ea\U52a9\U52a0\U6cb9\U7ad9";
//            5722 = "\U5bb6\U7528\U7535\U5668\U5546\U5e97";
//            5994 = "\U62a5\U4ead\U3001\U62a5\U644a";
//            6300 = "\U4fdd\U9669\U9500\U552e\U3001\U4fdd\U9669\U4e1a\U548c\U4fdd\U9669\U91d1";
//            7523 = "\U505c\U8f66\U573a";
//            8651 = "\U653f\U6cbb\U7ec4\U7ec7\Uff08\U653f\U5e9c\U673a\U6784\Uff09";
//            9211 = "\U6cd5\U5ead\U8d39\U7528\Uff0c\U5305\U62ec\U8d61\U517b\U8d39\U548c\U5b50\U5973\U629a\U517b\U8d39";
//            9222 = "\U7f5a\U6b3e";
//            9223 = "\U4fdd\U91ca\U91d1";
//            9311 = "\U7eb3\U7a0e";
//            9399 = "\U672a\U5217\U5165\U5176\U4ed6\U4ee3\U7801\U7684\U653f\U5e9c\U670d\U52a1\Uff08\U793e\U4f1a\U4fdd\U969c\U670d\U52a1\Uff0c\U56fd\U5bb6\U5f3a\U5236\Uff09";
//            9400 = "\U4f7f\U9886\U9986\U6536\U8d39";
//            9402 = "\U56fd\U5bb6\U90ae\U653f\U670d\U52a1";
//        }

        
//        DLog(@"THE third key info:%@",[categoryItem objectForKey:[[categoryItem allKeys] objectAtIndex:0]]);
        
        //1.记录返回信息
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:item forKey:@"UserInfoData"];
//        [userDefaults synchronize];
        
        if (_delegate && [_delegate respondsToSelector:@selector(getLoginServiceResult:Result:errorMsg:)]) {
            //[_delegate getLoginServiceResult:self Result:YES errorMsg:nil];
        }
        
    }
}

@end
