//
//  SearchBaseViewController.h
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/22.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchBaseViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView * _tableView;
    NSMutableArray * array ;
}

@property (strong,nonatomic) UISearchBar *searchBar;

@end
