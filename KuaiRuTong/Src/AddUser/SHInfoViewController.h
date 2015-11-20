//
//  SHInfoViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "CityAndMccInfoService.h"
//#import "DAContexMenuViewController.h"
@class SHDataItem;

typedef void (^AllBusinessInfo)(NSMutableDictionary *BussineDic);
typedef void (^AllBusinessTextInfo)(SHDataItem *BussinessDataItem);

@class TPKeyboardAvoidingTableView;

@interface SHInfoViewController :SuperViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    
}

@property(nonatomic,strong)  CityAndMccInfoService *service;
@property(nonatomic,strong) NSMutableArray *BussineDic; //商户种类数组

@property (strong, nonatomic)  AllBusinessInfo block;

@property (strong, nonatomic)  AllBusinessTextInfo Tblock;


@end


//    chooseArray = [NSMutableArray arrayWithArray:@[@[@"原创",@"电视剧",@"动漫",@"电影",],
//                                                   @[@"人气最旺",@"最新发布",@"收藏最多",@"打分最高",@"评论最狠",@"土豆推荐",@"清晰视频序",],
//                                                   ]];

//        DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,0,MainWidth,40) dataSource:self delegate:self];
//        //dropDownView.mSuperView = cell.contentView;
//        dropDownView.mSuperView = infoTableView;
//        [cell.contentView addSubview:dropDownView];