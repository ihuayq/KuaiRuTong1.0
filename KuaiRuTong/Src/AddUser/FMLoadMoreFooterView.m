//
//  FMLoadMoreFooterView.m
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-28.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import "FMLoadMoreFooterView.h"
#import "UIView+Additions.h"

#import "AddWebViewController.h"

@implementation FMLoadMoreFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.activeView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(frame.size.width/2-(30+100)/2, frame.size.height/2-30/2, 30, 30)];
        _activeView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:_activeView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_activeView.size.width+_activeView.origin.x, frame.size.height/2-25/2, 100, 25)];
//        _titleLabel.backgroundColor = [UIColor redColor];
        [self addSubview:_titleLabel];
        
        _addWDButton = [[UIButton alloc] initWithFrame:CGRectMake(_activeView.size.width+_activeView.origin.x, frame.size.height/2-25/2, 100, 25)];
        _addWDButton.backgroundColor = RED_COLOR1;
        _addWDButton.layer.masksToBounds = YES;
        [_addWDButton addTarget:self action:@selector(addWDButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_addWDButton setTitle:@"添加网点" forState:UIControlStateNormal];
        _addWDButton.layer.cornerRadius = 5.0;
        [self addSubview:_addWDButton];
    }
    return self;
}


#pragma mark -- Private Method
- (void)addWDButtonClicked{
//    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
//    AddWebViewController *childController = [board instantiateViewControllerWithIdentifier: @"AddWebVC"];
//    [self.navigationController pushViewController:childController animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
