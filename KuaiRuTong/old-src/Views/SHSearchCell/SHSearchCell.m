//
//  SHSearchCell.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/12.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "SHSearchCell.h"
#import "DeviceManager.h"
#import "ViewModel.h"
@implementation SHSearchCell
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
   
    //商户名称
    _shmcLabel = [ViewModel createLabelWithFrame:CGRectMake(5, 0, 320, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:nil];
    [self.contentView addSubview:_shmcLabel];
    
    
    //商户编号
    UILabel *shbhText = [ViewModel createLabelWithFrame:CGRectMake(5, 22, 100, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@"商户编号"];
    [self.contentView addSubview:shbhText];
    
    //商户类别
    UILabel *shlbText = [ViewModel createLabelWithFrame:CGRectMake(105, 22, 100, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@"商户类别"];
    [self.contentView addSubview:shlbText];
    
    //商户状态
    UILabel *shztText = [ViewModel createLabelWithFrame:CGRectMake(205, 22, 100, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@"商品状态"];
    [self.contentView addSubview:shztText];
    
    //商户编号1
    _shbhLabel = [ViewModel createLabelWithFrame:CGRectMake(5, 44, 100, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@""];
    [self.contentView addSubview:_shbhLabel];
    
    //商户类别1
    _shlbLabel = [ViewModel createLabelWithFrame:CGRectMake(105, 44, 100, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@""];
    [self.contentView addSubview:_shlbLabel];
    
    
    //商户状态1
    _shztLabel = [ViewModel createLabelWithFrame:CGRectMake(205, 44, 100, 21) Font:[UIFont boldSystemFontOfSize:17.0] Text:@""];
    [self.contentView addSubview:_shztLabel];
    
    //line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 66 * HEIGHT_SCALE, 320 * WIDTH_SCALE, 1 * HEIGHT_SCALE)];
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
