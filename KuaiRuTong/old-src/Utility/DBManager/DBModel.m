//
//  DBModel.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/8.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "DBModel.h"
#define TableName1  @"user"
#define TableName2  @"ruwang"

@implementation DBModel
-(id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

//连接数据库
-(void)connect{
    
    //判断有没有数据库
    if(!DB){
        //创建数据库
        DB = [[FMDatabase alloc] initWithPath:[NSString stringWithFormat:@"%@/Documents/app1.db",NSHomeDirectory()]];
    }
    
    
    if (![DB open]) {
        return ;
    }
    
    //保持长连接
    // kind of experimentalish.
    [DB setShouldCacheStatements:YES];
}



//判断数据表是否存在
-(BOOL)isTable:(NSString *)tableName{
    if (!DB) {
        [self connect];
    }
    
    FMResultSet *rs = [DB executeQuery:@" SELECT count(*) as 'count' FROM sqlite_master WHERE type ='table' and name = ? ", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    [rs close];
    
    return NO;
}

//添加数据
-(BOOL)AddData:(NSString *) table data:(NSMutableDictionary *) dict{
    
    NSDictionary *para = [self StitcPara:dict];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@)", table, [para objectForKey:@"para"], [para objectForKey:@"value"]];
    
    if ([DB executeUpdate:sql withParameterDictionary:dict]) {
        return YES;
    }else{
        return NO;
    }
}

//拼接参数
-(NSDictionary *)StitcPara:(NSMutableDictionary *) dict{
    
    NSString *para = @"";
    //得到词典中所有KEY值
    NSEnumerator * enumeratorKey = [dict keyEnumerator];
    
    //快速枚举遍历所有KEY的值
    for (NSObject *object in enumeratorKey) {
        if ([para isEqualToString:@""]) {
            para = [NSString stringWithFormat:@"%@", object];
        }else{
            para = [NSString stringWithFormat:@"%@,%@", para, object];
        }
    }
    
    //得到词典中所有KEY值
    NSEnumerator *Key = [dict keyEnumerator];
    
    NSString *value = @"";
    
    //快速枚举遍历所有KEY的值
    for (NSObject *object in Key) {
        if ([value isEqualToString:@""]) {
            value = [NSString stringWithFormat:@":%@", object];
        }else{
            value = [NSString stringWithFormat:@"%@,:%@", value, object];
        }
    }
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:para,@"para",value,@"value", nil];
}

//判断数据数据是否存在
-(int)isData:(NSString*) table para:(NSString *)para data:(NSString *)data{
    //检查数据是否存在
    int Did = 0;
    //拼接SQL
    NSString *Sql = [NSString stringWithFormat:@" SELECT * FROM %@ WHERE %@ = %@ ", table, para, data];
    FMResultSet *FMset = [DB executeQuery:Sql];
    while ([FMset next]) {
        Did = [FMset intForColumn:@"id"];
    }
    //关闭数据请求
    [FMset close];
    return Did;
}

//删除数据
-(BOOL)delData:(NSString *) table para:(NSString *) para data:(NSString *)data{
    
    NSString *Sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'", table , para, data];
    
    return [DB executeUpdate:Sql];
}

//删除数据
-(BOOL)delAll:(NSString *) table{
    
    NSString *Sql = [NSString stringWithFormat:@"DELETE FROM %@ ", table];
    
    return [DB executeUpdate:Sql];
}

//查询数据
-(NSMutableArray *)SelectData:(NSString *)table para:(NSString *)para data:(NSString *) data{
    
    [ParaDict removeAllObjects];
    if ([table isEqualToString:TableName1]) {
        ParaDict = [[NSMutableDictionary alloc] initWithDictionary:ParaDict1];
        
    }else if([table isEqualToString:TableName2]){
        ParaDict = [[NSMutableDictionary alloc] initWithDictionary:ParaDict2];
    }
    
    NSMutableArray *DataArray = [[NSMutableArray alloc] init];
    
    //拼接SQL
    NSString *Sql = [NSString stringWithFormat:@"SELECT * FROM %@", table];
    
    if (![para isEqualToString:@""]) {
        Sql = [NSString stringWithFormat:@" %@ WHERE %@ = '%@' ", Sql, para, data];
    }
    
    FMResultSet *FMset = [DB executeQuery:Sql];
    
    while ([FMset next]) {
        
        
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        NSEnumerator *Key = [ParaDict keyEnumerator];
        
        for (NSString *paraL in Key) {
            if ([[ParaDict objectForKey:paraL] isEqualToString:@"int"]) {
                [dict setObject:[NSNumber numberWithInt:[FMset intForColumn:paraL]] forKey:paraL];
            }else if([[ParaDict objectForKey:paraL] isEqualToString:@"string"]){
                if ([[FMset stringForColumn:paraL] isKindOfClass:[NSString class]]) {
                    [dict setObject:[FMset stringForColumn:paraL] forKey:paraL];
                };
            }
        }
        
        
        
        [DataArray addObject:dict];
        
    }
    
    //关闭数据请求
    [FMset close];
    return DataArray;
}

-(NSArray *)Selectkey:(NSString *) table{
    
    //拼接SQL
    NSString *Sql = [NSString stringWithFormat:@"SELECT * FROM %@ LIMIT 1", table];
    FMResultSet *FMset = [DB executeQuery:Sql];
    
    [FMset columnIsNull:@"id"];
    NSArray *array = [FMset.columnNameToIndexMap allKeys];
    
    [FMset close];
    
    return array;
}

//查询单条数据
-(NSMutableDictionary *)SelectRow:(NSString *) table para:(NSString *)para data:(NSString *) data{
    
    [ParaDict removeAllObjects];
    if ([table isEqualToString:TableName1]) {
        ParaDict = [[NSMutableDictionary alloc] initWithDictionary:ParaDict1];
        
    }else if([table isEqualToString:TableName2]){
        ParaDict = [[NSMutableDictionary alloc] initWithDictionary:ParaDict2];
    }
    
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSEnumerator *Key = [ParaDict keyEnumerator];
    //拼接SQL
    NSString *Sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'", table, para, data];
    FMResultSet *FMset = [DB executeQuery:Sql];
    
    while ([FMset next]) {
        for (NSString *paraL in Key) {
            if ([[ParaDict objectForKey:paraL] isEqualToString:@"int"]) {
                [dict setObject:[NSNumber numberWithInt:[FMset intForColumn:paraL]] forKey:paraL];
            }else if([[ParaDict objectForKey:paraL] isEqualToString:@"string"]){
                if ([[FMset stringForColumn:paraL] isKindOfClass:[NSString class]]) {
                    [dict setObject:[FMset stringForColumn:paraL] forKey:paraL];
                };
            }
        }
    }
    
    [FMset close];
    
    return dict;
}

//更新数据
-(BOOL)UpdateData:(NSString *) table OData:(NSMutableDictionary *)odata NData:(NSDictionary *)ndata Did:(int) did{
    
    //获取新旧数据
    NSString *sValue = @"";
    NSString *aValue = @"";
    
    for (id sdata in ndata) {
        sValue = [NSString stringWithFormat:@"%@%@", sValue, [odata objectForKey:sdata]];
        aValue = [NSString stringWithFormat:@"%@%@", aValue, [ndata objectForKey:sdata]];
    }
    
    //判断两次数据是否相等
    if (![sValue isEqualToString:aValue]) {
        //不相等更新数据
        NSString *para = [self StitcUpdatePara:ndata];
        
        NSString *Sql = [NSString stringWithFormat:@" UPDATE %@ SET %@ WHERE id = %d ", table, para, did];
        
        [DB executeUpdate:Sql];
        
        return YES;
    }else{
        return NO;
    }
}

//更新数据
-(BOOL)Updata:(NSString *) table Data:(NSDictionary *)data did:(int) Did{
    //不相等更新数据
    NSString *para = [self StitcUpdatePara:data];
    
    NSString *Sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE id = %d", table, para, Did];
    return [DB executeUpdate:Sql];
}

//拼接更新参数
-(NSString *)StitcUpdatePara:(NSDictionary *) dict{
    NSString *para = @"";
    
    //得到词典中所有KEY值
    NSEnumerator * enumeratorKey = [dict keyEnumerator];
    
    //快速枚举遍历所有KEY的值
    for (NSObject *object in enumeratorKey) {
        if ([para isEqualToString:@""]) {
            para = [NSString stringWithFormat:@" %@ ='%@'", object, [dict objectForKey:object]];
        }else{
            para = [NSString stringWithFormat:@"%@, %@ ='%@'", para, object, [dict objectForKey:object]];
        }
    }
    
    return para;
}

//拼接更新参数
-(NSString *)StitcSelectPara:(NSDictionary *) dict{
    NSString *para = @"";
    
    //得到词典中所有KEY值
    NSEnumerator * enumeratorKey = [dict keyEnumerator];
    
    //快速枚举遍历所有KEY的值
    for (NSObject *object in enumeratorKey) {
        if ([para isEqualToString:@""]) {
            para = [NSString stringWithFormat:@" %@ ='%@'", object, [dict objectForKey:object]];
        }else{
            para = [NSString stringWithFormat:@"%@ AND %@ ='%@'", para, object, [dict objectForKey:object]];
        }
    }
    
    return para;
}

//获取数据
-(NSMutableArray *)GetData:(NSString *) table para:(NSDictionary *)dict{
    
    [ParaDict removeAllObjects];
    if ([table isEqualToString:TableName1]) {
        ParaDict = [[NSMutableDictionary alloc] initWithDictionary:ParaDict1];
        
    }else if([table isEqualToString:TableName2]){
        ParaDict = [[NSMutableDictionary alloc] initWithDictionary:ParaDict2];
    }
    
    
    
    NSMutableArray *DataArray = [[NSMutableArray alloc] init];
    //拼接SQL
    NSString *Sql = [NSString stringWithFormat:@"SELECT * FROM %@", table];
    
    Sql = [NSString stringWithFormat:@"%@ WHERE %@", Sql, [self StitcSelectPara:dict]];
    
    FMResultSet *FMset = [DB executeQuery:Sql];
    
    while ([FMset next]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        NSEnumerator *Key = [ParaDict keyEnumerator];
        
        for (NSString *paraL in Key) {
            if ([[ParaDict objectForKey:paraL] isEqualToString:@"int"]) {
                [dict setObject:[NSNumber numberWithInt:[FMset intForColumn:paraL]] forKey:paraL];
            }else if([[ParaDict objectForKey:paraL] isEqualToString:@"string"]){
                [FMset stringForColumn:paraL];
                [dict setObject:[FMset stringForColumn:paraL] forKey:paraL];
            }
        }
        
        [DataArray addObject:dict];
    }
    
    //关闭数据请求
    [FMset close];
    
    return DataArray;
}

//获取数据
-(NSMutableArray *)GetTopData:(NSString *) table para:(NSDictionary *)dict{
    
    [ParaDict removeAllObjects];
    if ([table isEqualToString:TableName1]) {
        ParaDict = [[NSMutableDictionary alloc] initWithDictionary:ParaDict1];
        
    }else if([table isEqualToString:TableName2]){
        ParaDict = [[NSMutableDictionary alloc] initWithDictionary:ParaDict2];
    }
    
    
    NSMutableArray *DataArray = [[NSMutableArray alloc] init];
    
    //拼接SQL
    NSString *Sql = [NSString stringWithFormat:@"SELECT * FROM %@", table];
    
    Sql = [NSString stringWithFormat:@"%@ WHERE %@ order by istop desc, rid desc", Sql, [self StitcSelectPara:dict]];
    
    FMResultSet *FMset = [DB executeQuery:Sql];
    
    while ([FMset next]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        NSEnumerator *Key = [ParaDict keyEnumerator];
        
        for (NSString *paraL in Key) {
            if ([[ParaDict objectForKey:paraL] isEqualToString:@"int"]) {
                [dict setObject:[NSNumber numberWithInt:[FMset intForColumn:paraL]] forKey:paraL];
            }else if([[ParaDict objectForKey:paraL] isEqualToString:@"string"]){
                [FMset stringForColumn:paraL];
                [dict setObject:[FMset stringForColumn:paraL] forKey:paraL];
            }
        }
        
        [DataArray addObject:dict];
    }
    
    //关闭数据请求
    [FMset close];
    
    return DataArray;
}

-(void)close{
    [DB close];
}

-(void)beginTransaction{
    [DB beginTransaction];
}

-(void)commit{
    [DB commit];
}

@end
