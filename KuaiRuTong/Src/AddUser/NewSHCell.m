//
//  NewSHCell.m
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import "NewSHCell.h"
#import "DeviceManager.h"
#import "ViewModel.h"

static NSArray *titlesArray;

@implementation NewSHCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (titlesArray  == nil) {
            titlesArray = [[NSArray alloc] initWithObjects:@"商户信息填写",@"营业执照",@"身份证证面",@"身份证反面",@"店面照",@"结算卡正面",@"结算卡反面",@"合同照片", nil];
        }
        
        [self loadBasicView];
    }
    return self;
}
/**
 *  加载基础视图
 *  @return void
 */
- (void)loadBasicView{
    //标题
    titleLabel =  [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 160, 21)];;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:titleLabel];
    
    //是否保存按钮
//    cunButton = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth - 60 , 4, 36, 36)];
//    [cunButton addTarget:self action:@selector(pickImageMethod) forControlEvents:UIControlEventTouchUpInside];
//    [cunButton setBackgroundImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
//    cunButton.layer.masksToBounds = YES;
//    [self.contentView addSubview:cunButton];
    
    
}

-(void)setNIndex:(int)nIndex{
    _nIndex = nIndex;
    
    CGSize titleSize = [titlesArray[nIndex] sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(MainWidth/2, CGFLOAT_MAX) lineBreakMode:NSLineBreakByClipping];
    if (titleSize.width>MainWidth/2) {
        titleSize.width = MainWidth/2;
    }
    titleLabel.frame = CGRectMake(16, 0, titleSize.width, 44);
    titleLabel.text = titlesArray[nIndex];
    
//    if (nIndex == 0) {
//        [cunButton setBackgroundImage:[UIImage imageNamed:@"addInfo"] forState:UIControlStateNormal];
//    }
}

-(void)setBShowSuccessImg:(BOOL)bShowSuccessImg{
    _bShowSuccessImg = bShowSuccessImg;
    
    if (bShowSuccessImg == true) {
        //被选择的图片
        selectedImg = [[UIImageView alloc] initWithFrame:CGRectMake(MainWidth - 60 -40, 6,30,30)];
        selectedImg.image = [UIImage imageNamed:@"成功"];
        [self.contentView addSubview:selectedImg];
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
