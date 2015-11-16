//
//  NewSHCell.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/17.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewSHCell : UITableViewCell{
    UILabel *titleLabel;
    UIButton *cunButton;
    UIImageView *selectedImg;
}


@property (nonatomic, assign) int nIndex;

@property (nonatomic, assign) BOOL bShowSuccessImg;




//@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UIButton *cunButton;
//@property (nonatomic, strong) UIView *intoInfoView;

@end
