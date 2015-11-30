//
//  NewMachineDataService.h
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/28.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataService.h"


@class NewMachineDataService;
@protocol NewMachineDataServiceDelegate <NSObject>
@optional

-(void)getManufacturerStorageServiceResult:(NewMachineDataService *)service
                             Result:(BOOL)isSuccess_
                           errorMsg:(NSString *)errorMsg;


-(void)checkPosCodeServiceResult:(NewMachineDataService *)service
                       Result:(BOOL)isSuccess_
                     errorMsg:(NSString *)errorMsg;

-(void)upLoadMachineInfoServiceResult:(NewMachineDataService *)service
                             Result:(BOOL)isSuccess_
                           errorMsg:(NSString *)errorMsg;


@end

@interface NewMachineDataService : DataService{
    HttpMessage *queryManufactorInfoHttpMsg;
    
    HttpMessage *checkCodeHttpMsg;
    
    HttpMessage *upLoadHttpMsg;
}

@property (nonatomic,strong)  NSArray *versionArray;
@property (nonatomic,strong)  NSArray *companyNamesArray;
@property (nonatomic,strong) NSArray *machineTypesArray;

@property (nonatomic,weak) id<NewMachineDataServiceDelegate> delegate;

-(void)beginUploadByShopName:(NSMutableDictionary*)dic;
-(void)checkPosCode:(NSString*)posCode;
-(void)getManufacturerStorageData;

@end