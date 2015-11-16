//
//  InfoDataView.m
//  KuaiRuTong
//
//  Created by HKRT on 15/11/4.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import "InfoDataView.h"
#import "DeviceManager.h"
@implementation InfoDataView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadBasicView];
        
    }
    return self;
}
- (void)loadDataForTableViewMethod:(NSArray *)dataArray AndTextFieldTag:(NSInteger)tag{
    currentTag = tag;
    infoDataArray = [[NSArray alloc] initWithArray:dataArray];
    NSLog(@"%@",dataArray);
    [infoTableView reloadData];
}
- (void)loadBasicView {
    self.backgroundColor = [UIColor lightGrayColor];
    infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height ) style:UITableViewStylePlain];
    infoTableView.backgroundColor = [UIColor clearColor];
    infoTableView.dataSource = self;
    infoTableView.delegate =self;
    [self addSubview:infoTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return infoDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"InfoDataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [infoDataArray objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_Delegate respondsToSelector:@selector(selectInfoForCell:AndTag:)]) {
        [_Delegate selectInfoForCell:[infoDataArray objectAtIndex:indexPath.row] AndTag:currentTag];
    }
}

@end
