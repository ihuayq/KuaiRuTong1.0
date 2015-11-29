//
//  SHSearchDataService.H
//  KuaiRuTong
//
//  Created by huayq on 15/11/25.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <Foundation/Foundation.h>



#import "DataService.h"

@class SHDataItem;
@class SHResultData;
@class SHSearchDataService;
@protocol SHSearchDataServiceDelegate <NSObject>
@optional

-(void)getSearchServiceResult:(SHSearchDataService *)service
                                   Result:(BOOL)isSuccess_
                                 errorMsg:(NSString *)errorMsg;


-(void)getSHDetailDataServiceResult:(SHSearchDataService *)service
                       Result:(BOOL)isSuccess_
                     errorMsg:(NSString *)errorMsg;

-(void)upLoadMachineInfoServiceResult:(SHSearchDataService *)service
                               Result:(BOOL)isSuccess_
                             errorMsg:(NSString *)errorMsg;

@end

@interface SHSearchDataService : DataService{
    HttpMessage *searchSHHttpMsg;
    
    HttpMessage *searchSHDetailIndoHttpMsg;
    
    HttpMessage *bindHttpMsg;
}


@property (nonatomic,strong) NSMutableArray *responseArray;

@property (nonatomic,strong) SHResultData *detailData;
@property (nonatomic,weak) id<SHSearchDataServiceDelegate> delegate;

-(void)beginSearchSHDetail:(NSString*)merCode;
-(void)beginUploadByShopName:(NSString*)shopName withShopCode:(NSString*)shCode andPosCode:(NSString*)posCode;

-(void)beginBindWithPara:(NSMutableDictionary*)dic;




@end