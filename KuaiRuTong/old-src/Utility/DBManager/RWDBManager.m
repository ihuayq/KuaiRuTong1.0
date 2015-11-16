//
//  RWDBManager.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/8.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "RWDBManager.h"
#define TableName1  @"user"
#define TableName2  @"ruwang"

@implementation RWDBManager

/**
 *  单例 创建用户数据管理
 *
 *  @return UserDatabaseManager
 */
+ (RWDBManager *)sharedManager{
    static RWDBManager *userDBManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        userDBManager = [[RWDBManager alloc] init];
    });
    return userDBManager;
}

/**
 *  重写 init 方法  创建数据库
 *
 *  @return self
 */
- (instancetype)init{
    if (self = [super init]) {
        //构造表中对应元素的字典
        //设置数据结构
        ParaDict1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                     @"int",    @"id",                   //ID
                     @"int",    @"userID",               //用户ID
                     @"string", @"username",             //用户名
                     @"string", @"password",             //密码
                     @"string", @"realname",             //用户真名
                     @"string", @"userPhotoImageURL",    //头像地址
                     @"string", @"telephone",            //电话
                     nil];
        
        //判断数据库中是否存在表 表名称 UserInfo
        if (![super isTable:TableName1]) {
            //创建表的sqlite语句
            NSString *createTableSqliteString = [NSString stringWithFormat:@"CREATE TABLE '%@'(id INTEGER PRIMARY KEY AUTOINCREMENT,userID INTEGER,username TEXT,password TEXT,realname TEXT,userPhotoImageURL TEXT,telephone TEXT)",TableName1] ;
            //判断表是否创建成功
            BOOL isSucceed=[DB executeUpdate:createTableSqliteString];
            if (isSucceed) {
                NSLog(@"新创建 用户 的表格成功");
            }else{
                NSLog(@"新创建 用户 的表格失败");
            }
        }else{
            NSLog(@"新建 用户 存在");
        }
        [self isKeyWithTableName:TableName1 AndParaDic:ParaDict1];
        
        //构造表中对应元素的字典
        //设置数据结构
        ParaDict2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                     @"int",    @"id",                   //id           ID
                     @"int",    @"meetingID",            //meetingID    会议ID
                     @"string", @"meetingName",          //meetingName  会议名称
                     @"string", @"meetingType",          //meetingType  会议类型
                     @"int",    @"peopleNumbers",        //peopleNumbers会议人数
                     @"string", @"meetingState",         //meetingState 会议状态
                     @"string", @"planTime",             //planTime     计划时间
                     @"string", @"startTime",            //startTime    开始时间
                     @"string", @"endTime",              //endTime      结束时间
                     @"int",    @"userID",               //userID       用户ID
                     @"string", @"userName",             //username     用户名
                     @"string", @"realName",             //realName     用户真名
                     @"string", @"userPhotoURLString",   //userPhotoURLString 用户头像地址
                     nil];
        
        //判断数据库中是否存在表 表名称 UserInfo
        if (![super isTable:TableName2]) {
            //创建表的sqlite语句
            NSString *createTableSqliteString = [NSString stringWithFormat:@"CREATE TABLE '%@'(id INTEGER PRIMARY KEY AUTOINCREMENT,meetingID INTEGER,meetingName TEXT,meetingType TEXT,peopleNumbers INTEGER DEFAULT 0,meetingState TEXT,planTime TEXT,startTime TEXT,endTime TEXT,userID INTEGER,userName TEXT,realName TEXT,userPhotoURLString TEXT)",TableName2] ;
            //判断表是否创建成功
            BOOL isSucceed=[DB executeUpdate:createTableSqliteString];
            if (isSucceed) {
                NSLog(@"新创建meeting的表格成功");
            }else{
                NSLog(@"新创建meeting的表格失败");
            }
        }else{
            NSLog(@"新建meeting存在");
        }
        
        [self isKeyWithTableName:TableName2 AndParaDic:ParaDict2];
        
    }
    
    return self;
}


//坚持字段是否存在不存在创建
-(void)isKeyWithTableName:(NSString *)tableName AndParaDic:(NSDictionary *)paraDic{
    //获取表内字典并统一为小写
    NSMutableArray *array = [NSMutableArray arrayWithArray:[super Selectkey:tableName]];
    NSLog(@"array == %@",array);
    NSArray *key = [paraDic allKeys];
    NSLog(@"key = %@",key);
    NSMutableDictionary *keyDict = [[NSMutableDictionary alloc] init];
    
    for (int j = 0; j < key.count; j++) {
        [keyDict setObject:[key objectAtIndex:j] forKey:[[key objectAtIndex:j] lowercaseString]];
    }
    
    for (int i = 0; i < array.count; i++) {
        if ([keyDict objectForKey:[array objectAtIndex:i]]) {
            [keyDict removeObjectForKey:[array objectAtIndex:i]];
        }
    }
    
    NSString *sql = @"";
    
    for (id key in keyDict) {
        NSString *keyType = [paraDic objectForKey:[keyDict objectForKey:key]];
        
        if ([keyType isEqualToString:@"string"]) {
            sql = [NSString stringWithFormat:@"alter table %@ add column %@ TEXT", tableName, [keyDict objectForKey:key]];
        }else{
            sql = [NSString stringWithFormat:@"alter table %@ add column %@ INTEGER", tableName, [keyDict objectForKey:key]];
        }
        
        if(![DB executeUpdate:sql]){
            NSLog(@"alter# %@ #error", sql);
        }else{
            NSLog(@"alter# %@ #success", sql);
        }
    }
}


- (void)addUserInfoData:(NSMutableDictionary *)userInfoDic{
    //判断数据是否存在
    int Did = [super isData:TableName1 para:@"userID" data:[userInfoDic objectForKey:@"userID"]];
    
    //不存在添加到数据库
    if (Did == 0) {
        //判断是否入库成功
        if ([super AddData:TableName1 data:userInfoDic]) {
            NSLog(@"YES Insert Data");
        }else{
            NSLog(@"NO Insert Data");
        }
    }else{
        //获取数据
        NSMutableDictionary *data = [super SelectRow:TableName1 para:@"userID" data:[userInfoDic objectForKey:@"userID"]];
        
        //判断是否更新
        if ([super UpdateData:TableName1 OData:data NData:userInfoDic Did:Did]) {
            NSLog(@"UpdateData yes");
        }
    }
    
}



/**
 *  添加数据
 *  @param dict NSMutableDictionary 要添加到数据库的字典
 */
- (void)addMeetingData:(NSMutableDictionary *)meetingDic{
    //判断数据是否存在
    int Did = [super isData:TableName2 para:@"meetingID" data:[meetingDic objectForKey:@"meetingID"]];
    
    //不存在添加到数据库
    if (Did == 0) {
        //判断是否入库成功
        if ([super AddData:TableName2 data:meetingDic]) {
            NSLog(@"YES Insert Data");
        }else{
            NSLog(@"NO Insert Data");
        }
    }else{
        //获取数据
        NSMutableDictionary *data = [super SelectRow:TableName2 para:@"meetingID" data:[meetingDic objectForKey:@"meetingID"]];
        
        //判断是否更新
        if ([super UpdateData:TableName2 OData:data NData:meetingDic Did:Did]) {
            NSLog(@"UpdateData yes");
        }
    }
    
}


- (void)deleteUserInfoDataForUserID:(int)userID{
    [self delData:TableName1 para:@"userID" data:[NSString stringWithFormat:@"%d",userID]];
}


- (void)deleteMeetingDataForMeetingID:(int)meetingID{
    [self delData:TableName2 para:@"meetingID" data:[NSString stringWithFormat:@"%d",meetingID]];
}

- (NSArray *)fetchUserListData{
    return [super SelectData:TableName1 para:@"" data:@""];
}

- (NSArray *)fetchMeetingListData{
    return [super SelectData:TableName2 para:@"" data:@""];
}
- (NSDictionary *)fetchUserDataSearchUsername:(NSString *)username{
    return [super SelectRow:TableName1 para:@"username" data:username];
}
- (NSDictionary *)fetchUserDataSearchUserID:(int)userID{
    return [super SelectRow:TableName1 para:@"userID" data:[NSString stringWithFormat:@"%d",userID]];
}

- (NSDictionary *)fetchMeetingDataSearchMeetingID:(int)meetingID{
    return [super SelectRow:TableName2 para:@"meetingID" data:[NSString stringWithFormat:@"%d",meetingID]];
}
- (NSArray *)fetchUserDataSearchKey:(NSString *)key AndValue:(NSString *)value{
    return [super SelectData:TableName1 para:key data:value];
}

- (NSArray *)fetchMeetingDataSearchKey:(NSString *)key AndValue:(NSString *)value{
    return [super SelectData:TableName2 para:key data:value];
}


@end
