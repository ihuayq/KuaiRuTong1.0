//
//  DBModel.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/8.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DBModel : NSObject{
    FMDatabase *DB;
    
    NSMutableDictionary *ParaDict;
    NSDictionary *ParaDict1;
    NSDictionary *ParaDict2;
}

-(void)connect;
-(BOOL)isTable:(NSString *)tableName;
-(BOOL)AddData:(NSString *) table data:(NSMutableDictionary *) dict;
-(int)isData:(NSString*) table para:(NSString *)para data:(NSString *)data;
-(BOOL)delData:(NSString *) table para:(NSString *) para data:(NSString *)data;
-(NSMutableArray *)SelectData:(NSString *) table para:(NSString *)para data:(NSString *) data;
-(NSMutableDictionary *)SelectRow:(NSString *) table para:(NSString *)para data:(NSString *) data;
-(BOOL)UpdateData:(NSString *) table OData:(NSMutableDictionary *)odata NData:(NSDictionary *)ndata Did:(int) did;
-(BOOL)Updata:(NSString *) table Data:(NSDictionary *)data did:(int) Did;
-(NSMutableArray *)GetData:(NSString *) table para:(NSDictionary *)dict;
-(NSMutableArray *)GetTopData:(NSString *) table para:(NSDictionary *)dict;
-(NSArray *)Selectkey:(NSString *) table;
-(BOOL)delAll:(NSString *) table;
-(void)close;
-(void)beginTransaction;
-(void)commit;

@end
