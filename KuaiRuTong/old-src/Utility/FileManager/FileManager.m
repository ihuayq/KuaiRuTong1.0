//
//  FileManager.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/10.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "FileManager.h"

#import <sys/types.h>
#import <sys/xattr.h>
#include <sys/stat.h>
#include <dirent.h>
@implementation FileManager

//创建文件管理器
-(NSFileManager *)createFile{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[[self getDocumentsFiles] stringByExpandingTildeInPath]];
    
    [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:[self getDocumentsFiles]]];
    
    return fileManager;
}
//设置文件不备份
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    const char* filePath = [[URL path] fileSystemRepresentation];
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

//获取Documents路径
- (NSString *)getDocumentsFiles{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}


//判断Documents目录下文件是否存在
- (BOOL)IsFileExist:(NSString * )fileName{
    NSString *appFile = [[self getDocumentsFiles] stringByAppendingPathComponent:fileName];
    if([[NSFileManager defaultManager] fileExistsAtPath:appFile]){
        return YES;
    }
    return NO;
}
- (BOOL)isFileExistAtPathName:(NSString *)pathName{
    
    if([[NSFileManager defaultManager] fileExistsAtPath:pathName]){
        return YES;
    }
    return NO;
}

//获取Documents目录下文件目录地址
- (NSString *)getFilePath:(NSString *)name{
    //    NSLog(@"getFilePath:%@", [[self getDocumentsFiles] stringByAppendingPathComponent:name]);
    
    return [[self getDocumentsFiles] stringByAppendingPathComponent:name];
}

- (NSString *)getFileTagPath:(NSString *)name{
    return [[[self getDocumentsFiles] stringByAppendingPathComponent:@"UserPhotos"] stringByAppendingPathComponent:name];
}

//删除Documents目录下的文件
-(void)removeFile:(NSString *)fileName{
    NSFileManager *fileManager = [self createFile];
    //删除待删除的文件
    [fileManager removeItemAtPath:fileName error:nil];
}



//有用- 用户头像写入指定的文件夹下面 图片名称为 用户名.jpg
- (void)writeData:(NSData *)data andName:(NSString *)name{
    NSString *path = [[[self getDocumentsFiles] stringByAppendingPathComponent:@"UserPhotos"] stringByAppendingPathComponent:name];
    
    if ([self isFileExistAtPathName:path]) {
        [self removeFile:path];
    }

    [data writeToFile:path atomically:YES];
}

//有用- 用户头像写入指定的文件夹下面 图片名称为 用户名.jpg
- (void)writeDataForSHTemp:(NSData *)data andName:(NSString *)name{
    NSString *path = [[[self getDocumentsFiles] stringByAppendingPathComponent:@"SHPhotosTemp"] stringByAppendingPathComponent:name];
    
    if ([self isFileExistAtPathName:path]) {
        [self removeFile:path];
    }
    
    [data writeToFile:path atomically:YES];
}


//Documents下文本写入写文件
-(void)FileWrite:(NSString *)str name:(NSString *)name {
    NSFileManager *fileManager = [self createFile];
    NSString *path = [[self getDocumentsFiles] stringByAppendingPathComponent:name];
    if ([self IsFileExist:name]) {
        [self removeFile:name];
    }
    //创建文件
    [fileManager createFileAtPath:path contents:nil attributes:nil];
    
    //创建数据缓冲
    NSMutableData *writer = [[NSMutableData alloc] init];
    NSLog(@"FileWrite str：%@", str);
    NSLog(@"FileWrite name:%@", name);
    [writer appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    [writer writeToFile:path atomically:YES];
}
@end
