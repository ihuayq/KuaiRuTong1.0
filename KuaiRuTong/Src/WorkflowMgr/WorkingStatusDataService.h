//
//  WorkingStatusDataService.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/26.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <Foundation/Foundation.h>



#import "DataService.h"

@class SHDataItem;
@class WorkingStatusDataService;
@protocol WorkingStatusDataServiceDelegate <NSObject>
@optional

-(void)getSearchServiceResult:(WorkingStatusDataService *)service
                       Result:(BOOL)isSuccess_
                     errorMsg:(NSString *)errorMsg;

@end

@interface WorkingStatusDataService : DataService{
    HttpMessage *updateHttpMsg;
}


@property (nonatomic,copy) NSString *formStatus;
@property (nonatomic,copy) NSString *mercNum;
@property (nonatomic,copy) NSString *mercName;
@property (nonatomic,copy) NSString *processId;

@property (nonatomic,assign) int pos;
@property (nonatomic,copy) NSString *operation;
@property (nonatomic,copy) NSString *sales;
@property (nonatomic,copy) NSString *inrecodr;
@property (nonatomic,copy) NSString *success;

@property (nonatomic,strong) NSMutableArray *responseArray;
@property (nonatomic,weak) id<WorkingStatusDataServiceDelegate> delegate;

-(void)beginUploadByShopName:(NSString*)shopName withShopCode:(NSString*)shCode;



@end