//
//  CityAndMccInfoService.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/19.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "DataService.h"

@class CityAndMccInfoService;


@protocol CityAndMccInfoDelegate <NSObject>
@optional

-(void)getCityAndMccInfoServiceResult:(CityAndMccInfoService *)service
                      Result:(BOOL)isSuccess_
                    errorMsg:(NSString *)errorMsg;

@end

@interface CityAndMccInfoService : DataService{
    HttpMessage *infoHttpMsg;
}

@property (nonatomic,weak) id<CityAndMccInfoDelegate> delegate;

-(void)beginRequest;

@end
