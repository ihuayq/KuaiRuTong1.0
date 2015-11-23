//
//  Globle.m
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-27.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import "Globle.h"

@implementation Globle
+(Globle*)shareGloble{
    static Globle *globle=nil;
    if (globle==nil) {
        globle=[[Globle alloc] init];
    }
    return globle;
}

-(id)init
{
    if (self = [super init]) {
    }
    return self;
}

-(NSArray*)titleShDataArray{
    
    if (_titleShDataArray == nil){
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"SHTitleInfo" withExtension:@"plist"];
        _titleShDataArray = [NSArray arrayWithContentsOfURL:url];
    }
    
    return _titleShDataArray;
}




@end
