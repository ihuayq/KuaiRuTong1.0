//
//  DAContexMenuViewController.h
//  DAContextMenuTableViewControllerDemo
//
//  Created by huayq on 15/11/18.
//  Copyright © 2015年 Daria Kopaliani. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DAContextMenuCell.h"
#import "SuperViewController.h"
#import "TPKeyboardAvoidingTableView.h"

@interface DAContexMenuViewController : SuperViewController<DAContextMenuCellDelegate>

//@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TPKeyboardAvoidingTableView *tableView;

@property (assign, nonatomic) BOOL shouldDisableUserInteractionWhileEditing;

@end
