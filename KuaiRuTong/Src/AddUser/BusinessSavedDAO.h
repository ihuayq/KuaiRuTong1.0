//
//  BrowsingHistoryDAO.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DAO.h"
//#import "DataProductBasic.h"
#import "SHDataItem.h"



@interface BusinessSavedDAO : DAO


- (void)deleteAllHistorysFromDB;


- (NSArray *)getAllSavedHistorysFromDB;

- (NSArray *)getAllSavedHistorysSimpleInfoFromDB;

-(BOOL)isSHItemExistInDB:(NSString*)shopName;

- (SHDataItem *)searchSHItemDAOFromDB:(NSString*)shopName;

- (BOOL)writeProductToDB:(SHDataItem *)data;

- (BOOL)deleteProductByData:(SHDataItem *)data;

@end
