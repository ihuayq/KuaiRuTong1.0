//
//  RWDBManager.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/8.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "DBModel.h"

@interface RWDBManager : DBModel
//获取用户信息数据库管理
+ (RWDBManager *)sharedManager;
//添加用户信息数据
- (void)addMeetingData:(NSMutableDictionary *)meetingDic;
//根据用户id删除用户信息
- (void)deleteMeetingDataForMeetingID:(int)meetingID;
//获取用户的全部信息
- (NSArray *)fetchMeetingListData;
//根据会议id查找单条信息
- (NSDictionary *)fetchMeetingDataSearchMeetingID:(int)meetingID;
//根据关键字搜查数据
- (NSArray *)fetchMeetingDataSearchKey:(NSString *)key AndValue:(NSString *)value;
//获取用户数据 根据用户名称
- (NSDictionary *)fetchUserDataSearchUsername:(NSString *)username;

- (void)addUserInfoData:(NSMutableDictionary *)userInfoDic;
- (void)deleteUserInfoDataForUserID:(int)userID;
- (NSArray *)fetchUserListData;
- (NSDictionary *)fetchUserDataSearchUserID:(int)userID;
- (NSArray *)fetchUserDataSearchKey:(NSString *)key AndValue:(NSString *)value;
@end
