//
//  KuCunSearchCell.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/16.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "KuCunSearchCell.h"
#import "DeviceManager.h"
#import "ViewModel.h"
@implementation KuCunSearchCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadBasicView];
    }
    return self;
}
/**
 *  加载基础视图
 *  @return void
 */
- (void)loadBasicView{
    self.backgroundColor = [UIColor clearColor];
    //商户名称Text
    UILabel *shmcText = [ViewModel createLabelWithFrame:CGRectMake(5, 0, 100, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@"商户名称:"];
    [self.contentView addSubview:shmcText];

    //商户名称
    _shmcLabel = [ViewModel createLabelWithFrame:CGRectMake(105, 0, 215, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:nil];
    [self.contentView addSubview:_shmcLabel];
    
    
    //网点名称Text
    UILabel *wdmcText = [ViewModel createLabelWithFrame:CGRectMake(5, 30, 100, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@"网点名称:"];
    [self.contentView addSubview:wdmcText];

    //网点名称
    _wdmcLabel = [ViewModel createLabelWithFrame:CGRectMake(105, 30, 215, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:nil];
    [self.contentView addSubview:_wdmcLabel];
    
    //机身序列号Text
    UILabel *machineCodeText = [ViewModel createLabelWithFrame:CGRectMake(5, 55, 100, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@"机身序列号:"];
    [self.contentView addSubview:machineCodeText];
    //机身序列号
    _machineCodeLabel = [ViewModel createLabelWithFrame:CGRectMake(105, 55, 215, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:nil];
    [self.contentView addSubview:_machineCodeLabel];
    
    
    //line
    UIView *lineView = [ViewModel createViewWithFrame:CGRectMake(0, 79, 320, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
   
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
