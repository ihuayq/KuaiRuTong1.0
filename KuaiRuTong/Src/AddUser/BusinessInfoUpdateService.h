//
//  BusinessInfoUpdateService.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/19.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "DataService.h"

@class SHDataItem;
@class BusinessInfoUpdateService;
@protocol BusinessInfoUpdateServiceDelegate <NSObject>
@optional

-(void)getBusinessInfoUpdateServiceResult:(BusinessInfoUpdateService *)service
                               Result:(BOOL)isSuccess_
                             errorMsg:(NSString *)errorMsg;

-(void)getIssuedBusinessInfoServiceResult:(BusinessInfoUpdateService *)service
                                   Result:(BOOL)isSuccess_
                                 errorMsg:(NSString *)errorMsg;

@end

@interface BusinessInfoUpdateService : DataService{
    HttpMessage *updateHttpMsg;
    
    HttpMessage *downLoadIssueHttpMsg;
}

@property (nonatomic,weak) id<BusinessInfoUpdateServiceDelegate> delegate;

-(void)beginUpload:(NSDictionary*)parameters filePath:(NSString*)path;

-(void)beginUpload:(SHDataItem*)data;

-(void)downLoadWithMerName:(NSString*)MerName;

@end