//
//  MachineCodeCell.h
//  KuaiRuTong
//
//  Created by HKRT on 15/9/28.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MachineCodeCellDelegate;
@interface MachineCodeCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic, assign) id<MachineCodeCellDelegate> Delegate;
@end
@protocol MachineCodeCellDelegate <NSObject>

- (void)addButtonForCell:(MachineCodeCell *)cell;
- (void)writeTextFieldForCell:(MachineCodeCell *)cell AndText:(NSString *)text;
@end