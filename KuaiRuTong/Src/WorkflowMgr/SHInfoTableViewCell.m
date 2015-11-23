//
//  SHInfoTableViewCell.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/23.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "SHInfoTableViewCell.h"

@implementation SHInfoTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_main"]];
//        self.logo = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
//        self.logo.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:self.logo];
        
        self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MainWidth - 36, 20, 18, 10)];
        self.arrowImageView.backgroundColor = [UIColor clearColor];
        self.arrowImageView.image = [UIImage imageNamed:@"UpAccessory"];
        [self.contentView addSubview:self.arrowImageView];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, MainWidth - 10 * 2, 20)];
        self.title.font = [UIFont systemFontOfSize:16.0f];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.opaque = NO;
        [self.contentView addSubview:self.title];
        
//        self.subTtile = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 230, 14)];
//        self.subTtile.font = [UIFont systemFontOfSize:12.0f];
//        self.subTtile.textColor = [UIColor colorWithRed:158/255.0
//                                                  green:158/255.0
//                                                   blue:158/255.0
//                                                  alpha:1.0];
//        self.subTtile.backgroundColor = [UIColor clearColor];
//        self.subTtile.opaque = NO;
//        [self.contentView addSubview:self.subTtile];
        
//        UILabel *sLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 78, 320, 1)];
//        sLine1.backgroundColor = [UIColor colorWithRed:198/255.0
//                                                 green:198/255.0
//                                                  blue:198/255.0
//                                                 alpha:1.0];
//        UILabel *sLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 79, 320, 1)];
//        sLine2.backgroundColor = [UIColor whiteColor];
//        
//        [self.contentView addSubview:sLine1];
//        [self.contentView addSubview:sLine2];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)changeArrowWithUp:(BOOL)up
{
//    if (up) {
//        self.arrowImageView.image = [UIImage imageNamed:@"UpAccessory"];
//    }else
//    {
//        self.arrowImageView.image = [UIImage imageNamed:@"DownAccessory"];
//    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, DEGREES_TO_RADIANS(180));
    }];
}

@end
