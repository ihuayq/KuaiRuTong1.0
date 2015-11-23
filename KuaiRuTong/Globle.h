//
//  Globle.h
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-27.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Globle : NSObject

+(Globle*)shareGloble;

@property (nonatomic,strong) NSArray *titleShDataArray;

@end
