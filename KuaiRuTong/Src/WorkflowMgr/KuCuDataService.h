//
//  KuCuDataService.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/26.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"


@class KuCuDataService;
@protocol KuCuDataServiceDelegate <NSObject>
@optional

-(void)getSearchServiceResult:(KuCuDataService *)service
                       Result:(BOOL)isSuccess_
                     errorMsg:(NSString *)errorMsg;


-(void)deleteBindServiceResult:(KuCuDataService *)service
                       Result:(BOOL)isSuccess_
                     errorMsg:(NSString *)errorMsg;

@end




@interface KuCuDataService : DataService{
    HttpMessage *updateHttpMsg;
    
    HttpMessage *deleteBindHttpMsg;
}


@property (nonatomic,strong) NSMutableArray *responseArray;
@property (nonatomic,weak) id<KuCuDataServiceDelegate> delegate;

//-(void)beginSearch:(NSDictionary*)parameters;
-(void)beginUploadByShopName:(NSString*)shopName withShopCode:(NSString*)shCode andPosCode:(NSString*)posCode andPosStatus:(NSString*)posStatus ;

-(void)deleteBindRelationshipByCode:(NSString*)code;

@end