//
//  CodeTableViewCell.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/18.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeTableViewCell : UITableViewCell{
    UITextField *addressTextField;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property(nonatomic,copy) NSString *code;

@end
