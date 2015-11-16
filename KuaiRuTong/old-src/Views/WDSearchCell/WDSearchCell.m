//
//  WDSearchCell.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/12.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "WDSearchCell.h"
#import "DeviceManager.h"

@implementation WDSearchCell
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
    
    //网点名称
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(15 * WIDTH_SCALE , 0, 100 * WIDTH_SCALE, 21 * HEIGHT_SCALE)];
    name.backgroundColor = [UIColor clearColor];
    name.font = [UIFont systemFontOfSize:17.0];
    name.text = @"网点名称";
    [self.contentView addSubview:name];
    //网点名称1
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 *WIDTH_SCALE, 21* HEIGHT_SCALE, 100 * WIDTH_SCALE, 21 * HEIGHT_SCALE)];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
    _nameLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_nameLabel];
    
    //网点地址
    UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(15 * WIDTH_SCALE, 45 * HEIGHT_SCALE, 100 * WIDTH_SCALE, 21 * HEIGHT_SCALE)];
    address.backgroundColor = [UIColor clearColor];
    address.font = [UIFont boldSystemFontOfSize:17.0];
    address.text = @"网点地址";
    [self.contentView addSubview:address];
    //网点地址1
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * WIDTH_SCALE, 66 * HEIGHT_SCALE, 200 * WIDTH_SCALE, 21 * HEIGHT_SCALE )];
    _addressLabel.backgroundColor = [UIColor clearColor];
    _addressLabel.font = [UIFont boldSystemFontOfSize:15.0];
    _addressLabel.textColor  = [UIColor lightGrayColor];
    [self.contentView addSubview:_addressLabel];
    
    //增加机具
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(200 * WIDTH_SCALE, 10 * HEIGHT_SCALE, 100 * WIDTH_SCALE, 30  * HEIGHT_SCALE)];
    addButton.backgroundColor = [UIColor grayColor];
    [addButton setTitle:@"增加机具" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    addButton.layer.masksToBounds = YES;
    addButton.layer.borderWidth = 1.0;
    [self.contentView addSubview:addButton];
}
- (void)addButtonClicked{
    if ([_Delegate respondsToSelector:@selector(addButtonDelegate)]) {
        [_Delegate addButtonDelegate];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
