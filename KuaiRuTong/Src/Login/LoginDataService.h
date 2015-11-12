//
//  LoginDataService.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/12.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "DataService.h"

@class LoginDataService;

@protocol LoginDelegate <NSObject>
@optional

-(void)getLoginServiceResult:(LoginDataService *)service
                      Result:(BOOL)isSuccess_
                    errorMsg:(NSString *)errorMsg;

@end

@interface LoginDataService : DataService{
    HttpMessage *loginHttpMsg;
}

@property (nonatomic,weak) id<LoginDelegate> delegate;

-(void)beginLogin:(NSString*)userName  Passport:(NSString*)passort;
@end
