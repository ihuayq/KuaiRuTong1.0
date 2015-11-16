//
//  InfoDataView.h
//  KuaiRuTong
//
//  Created by HKRT on 15/11/4.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol InfoDataViewDelegate;
@interface InfoDataView : UIView<UITableViewDataSource,UITableViewDelegate>{
    UITableView *infoTableView;
    NSArray *infoDataArray;
    NSInteger currentTag;
}
@property (nonatomic, assign)id <InfoDataViewDelegate>Delegate;
- (void)loadDataForTableViewMethod:(NSArray *)dataArray AndTextFieldTag:(NSInteger)tag;
@end

@protocol InfoDataViewDelegate <NSObject>

- (void)selectInfoForCell:(NSString *)info AndTag:(NSInteger)tag;

@end