//
//  SearchDataService.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/25.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <Foundation/Foundation.h>



#import "DataService.h"

@class SHDataItem;
@class SearchDataService;
@protocol SearchDataServiceDelegate <NSObject>
@optional

-(void)getSearchServiceResult:(SearchDataService *)service
                                   Result:(BOOL)isSuccess_
                                 errorMsg:(NSString *)errorMsg;

@end

@interface SearchDataService : DataService{
    HttpMessage *updateHttpMsg;
}


@property (nonatomic,strong) NSMutableArray *responseArray;
@property (nonatomic,weak) id<SearchDataServiceDelegate> delegate;

//-(void)beginSearch:(NSDictionary*)parameters;
-(void)beginUploadByShopName:(NSString*)shopName withShopCode:(NSString*)shCode andPosCode:(NSString*)posCode;



@end