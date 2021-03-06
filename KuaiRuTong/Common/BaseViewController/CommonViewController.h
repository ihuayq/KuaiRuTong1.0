//
//  BaseViewController.h
//  Canada
//
//  Created by zhaojianguo on 13-10-9.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZNavigationView.h"
#import "BBAlertView.h"

#define NAVIGATION_OUTLET_HEIGHT self.navigation.frame.origin.y+ self.navigation.frame.size.height

#define SCREEN_BODY_HEIGHT self.navigation.frame.origin.y+ self.navigation.frame.size.height + 48

@class NSTimerHelper;
@interface CommonViewController : UIViewController<ZZNavigationViewDelegate,BBAlertViewDelegate>
{
}
@property (nonatomic,strong) ZZNavigationView * navigation;

@property (nonatomic, strong) NSTimerHelper     *dlgTimer;

- (void)displayOverFlowActivityView:(NSString *)indiTitle;

- (void)displayOverFlowActivityView:(NSString *)indiTitle maxShowTime:(CGFloat)time;

- (void)displayOverFlowActivityView;

- (void)displayOverFlowActivityView:(NSString *)indiTitle yOffset:(CGFloat)y;

- (void)removeOverFlowActivityView;
- (void)presentSheet:(NSString *)indiTitle timer:(int)aTimer;
- (void)presentSheet:(NSString *)indiTitle;
- (void)presentSheet:(NSString *)indiTitle posY:(CGFloat)y;
- (void)presentSheetOnNav:(NSString *)indiTitle;

//添加可展示两行的sheet
- (void)presentSheet:(NSString *)indiTitle subMessage:(NSString *)msg;
- (void)presentSheet:(NSString *)indiTitle subMessage:(NSString *)msg posY:(CGFloat)y;


- (void)presentCustomDlg:(NSString *)indiTitle;

@end
