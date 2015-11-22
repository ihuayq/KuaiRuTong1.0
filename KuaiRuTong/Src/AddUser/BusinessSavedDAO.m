//
//  BrowsingHistoryDAO.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "BusinessSavedDAO.h"

@implementation BusinessSavedDAO


- (void)deleteAllHistorysFromDB
{
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"delete from %@", @"browsing_history_n"];
        
        [db executeUpdate:sql];
    }];
}

- (NSArray *)getAllSavedHistorysFromDB
{
    __block NSMutableArray *array = nil;
	[self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select * from info_saved_business "];
        //order by julianday(add_dttm) desc limit 50
        
        FMResultSet *rs = [db executeQuery:sql];	
        if(!rs){
            [rs close];
            return;
        }
        array = [[NSMutableArray alloc] init];	
        while ([rs next]) {			
            SHDataItem *dto = [[SHDataItem alloc] init];
            dto.shop_name = [rs stringForColumn:@"shop_name"];
            dto.pos_code = [rs stringForColumn:@"pos_code"];
            dto.branch_add = [rs stringForColumn:@"branch_add"];
            dto.industry = [rs stringForColumn:@"industry"];
//            dto.price = [NSNumber numberWithFloat:[[rs stringForColumn:@"price"] doubleValue]];
//            dto.evaluation = [rs stringForColumn:@"evaluation"];
//            dto.cityCode = [rs stringForColumn:@"city_code"];
//            dto.special = [rs stringForColumn:@"aux_description"];
//            dto.productImageURL = [NSURL URLWithString:[rs stringForColumn:@"product_imageurl"]];
            [array addObject:dto];
//            TT_RELEASE_SAFELY(dto);
        }
        [rs close]; 
    }];
	return array;
}




//info_saved_business (\
//                     userinfo_id INTEGER PRIMARY KEY NOT NULL,\
//                     shop_name TEXT NOT NULL,\
//                     pos_code TEXT,\
//                     branch_add TEXT,\
//                     industry TEXT,\
//                     industry_subclass TEXT,\
//                     mcc TEXT,\
//                     account_name TEXT,\
//                     bank_card_num TEXT,\
//                     pub_pri TEXT,\
//                     invitation_code TEXT,\
//                     bank_province TEXT,\
//                     bank_city TEXT,\
//                     bank_add TEXT,\
//                     phone_num TEXT,\
//                     phone_verify TEXT,\
//                     network_name_verify TEXT\
//                     photo_business_permit blob    \
//                     photo_identifier_front blob  \
//                     photo_identifier_back blob    \
//                     photo_business_place blob    \
//                     photo_bankcard_front blob    \
//                     photo_bankcard_back blob    \
//                     photo_contracts blob)"

- (BOOL)writeProductToDB:(SHDataItem *)data
{
    if (data == nil || data.shop_name.trim.length == 0
        )
    {
        return NO;
    }
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        
        NSString *sql = [NSString stringWithFormat:
                         @"replace into info_saved_business"
                         "(shop_name,pos_code,branch_add,industry,industry_subclass,mcc,account_name,bank_card_num,pub_pri,invitation_code,bank_province,bank_city,bank_add,"
                         "photo_business_permit,photo_identifier_front,photo_identifier_back,"
                         "photo_business_place,photo_bankcard_front,photo_bankcard_back,photo_contracts)"
                         "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"
                                 ];
        BOOL success = [db executeUpdate:
         sql,data.shop_name,data.pos_code,data.branch_add,data.industry,data.industry_subclass,data.mcc,data.account_name,data.bank_card_num,
         data.pub_pri,data.invitation_code,data.bank_province,data.bank_city,data.bank_add,
         data.photo_business_permit,data.photo_identifier_front,data.photo_identifier_back,data.photo_business_place,
         data.photo_bankcard_front,data.photo_bankcard_back,data.photo_contracts
         ];
        
//        NSString *sql = [NSString stringWithFormat:
//                         @"replace into info_saved_business"
//                         "(shop_name,pos_code,branch_add,industry,industry_subclass,mcc,account_name,bank_card_num,pub_pri,invitation_code,bank_province,bank_city,bank_add)"
//                         "values(?,?,?,?,?,?,?,?,?,?,?,?,?);"
//                         ];
//        BOOL success = [db executeUpdate:
//                        sql,data.shop_name,data.pos_code,data.branch_add,data.industry,data.industry_subclass,data.mcc,data.account_name,data.bank_card_num,
//                        data.pub_pri,data.invitation_code,data.bank_province,data.bank_city,data.bank_add
//                        ];
        
        
        DLog(@"The sql excute suceed:%d",success);
        
//        NSString *sql = [NSString stringWithFormat:@"replace into browsing_history_n(product_code,product_id,shop_code,product_name,price,evaluation,city_code,aux_description,product_imageurl,add_dttm)values(?,?,?,?,?,?,?,?,?,?);"];
//        [db executeUpdate:sql,data.productCode,data.productId,data.shopCode,data.productName,[data.price stringValue],data.evaluation,data.cityCode,data.special,[data.productImageURL absoluteString],[NSDate date]];
    }];
    
    return YES;
}


- (BOOL)insertSuNingSellDAOFromDB:(NSString*)sourceChannel channelDetail:(NSString*)channelDetail produceCode:(NSString*)produceCode producePrice:(NSString*)producePrice
{
    __block BOOL isInsearch = NO;
    
    if (IsStrEmpty(sourceChannel)&&IsStrEmpty(channelDetail)&&IsStrEmpty(produceCode)&&IsStrEmpty(producePrice))
    {
        return isInsearch;
    }
    
    NSString* resultStr = [self searchSuNingSellDAOToDB:produceCode];
    NSUInteger length = [resultStr length];
    if (length)
    {//数据库中已经存在
        return isInsearch;
    }
    
    NSString* tempSourceChannel = sourceChannel;
    NSString* tempChannelDetail = channelDetail;
    [self.databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *insertSql = @"insert into dic_sell(source_channel,channel_detail,produce_code,produce_price)values(?,?,?,?)";
        if (![db executeUpdate:insertSql,tempSourceChannel,tempChannelDetail,produceCode,producePrice])
        {
            *rollback = YES;
            return;
        }
        isInsearch = YES;
    }];
    return isInsearch;
}
- (NSString*)searchSuNingSellDAOToDB:(NSString*)produceCode
{
    __block NSString* resultStr = nil;
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select * from dic_sell where produce_code = ?"];
        
        FMResultSet *rs = [db executeQuery:sql, produceCode];
        if(!rs)
        {
            [rs close];
            return;
        }
        while ([rs next])
        {
            resultStr = [NSString stringWithFormat:@"%@_%@_%@_%@",[rs stringForColumn:@"source_channel"],[rs stringForColumn:@"channel_detail"],[rs stringForColumn:@"produce_code"],[rs stringForColumn:@"produce_price"]];
        }
        
        [rs close];
    }];
    return resultStr;
}

- (BOOL)deleteProductByData:(SHDataItem *)data
{
    if (data == nil)
    {
        return NO;
    }
    
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"delete from browsing_history_n where product_id = ?"];
        
        //[db executeUpdate:sql,data.productId];
        
    }];
    
    
    return YES;
}

@end
