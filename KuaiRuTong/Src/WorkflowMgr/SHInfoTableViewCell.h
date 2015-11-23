//
//  SHInfoTableViewCell.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/23.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHInfoTableViewCell : UITableViewCell

//@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *title, *subTtile;
@property (strong, nonatomic) UIImageView *arrowImageView;


- (void)changeArrowWithUp:(BOOL)up;
@end
