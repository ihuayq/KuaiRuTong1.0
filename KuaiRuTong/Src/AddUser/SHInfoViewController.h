//
//  SHInfoViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
@interface SHInfoViewController : SuperViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    
}

//已经添加的网点数据的数量
@property(nonatomic,assign) int nNetAddressCount;

@end
