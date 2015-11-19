//
//  CodeTableViewCell.h
//  KuaiRuTong
//
//  Created by huayq on 15/11/18.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^enter)(NSString * enteredString) ;

@interface CodeTableViewCell : UITableViewCell{
    UITextField *textField;
}

@property(nonatomic,copy) NSString *code;
@property(nonatomic,strong) enter onTextEntered;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
