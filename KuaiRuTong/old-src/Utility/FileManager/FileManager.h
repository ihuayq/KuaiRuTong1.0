//
//  FileManager.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/10.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject
- (void)writeData:(NSData *)data andName:(NSString *)name;
- (NSString *)getFileTagPath:(NSString *)name;
- (void)writeDataForSHTemp:(NSData *)data andName:(NSString *)name;
-(void)removeFile:(NSString *)fileName;
@end
