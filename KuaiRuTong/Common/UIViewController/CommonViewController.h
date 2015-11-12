//
//  CommonViewController.h
//  WingLetter
//
//  Created by zhaojw on 10-10-11.
//  Copyright 2010 Wingletter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+ActivityIndicator.h"
#import "AppDelegate.h"
#import "BBTipView.h"
#import "BBAlertView.h"
#import "NSTimerHelper.h"
#import "TPKeyboardAvoidingTableView.h"
#import "SNNetworkErrorView.h"
#import "BottomNavBar.h"


// XZoscaradd 2014-06-18
// 首页 navigation controller
#define KHomePage       0   //首页开关的性能统计


@interface CommonViewController : UIViewController<BBAlertViewDelegate>


@property (nonatomic, strong) NSTimerHelper     *dlgTimer; 

@property (nonatomic, strong) NSString          *pageInTime;

@property (nonatomic, strong) NSString          *specialViewTitle;

@property (nonatomic, assign) BOOL              isNeedBackItem;

@property (nonatomic, assign) BOOL              isLotteryController;

@property (nonatomic, strong) UIBarButtonItem   *rightBtnItem;

@property (nonatomic, strong) UILabel           *titleViewLabel;

@property (nonatomic, assign) BOOL              hasNav; //default is YES;

@property (nonatomic, assign) BOOL bSupportPanUI;//是否支持拖动pop手势，默认yes

@property (nonatomic, assign, getter=isIOS7FullScreenLayout) BOOL  iOS7FullScreenLayout;   //default is NO;

@property (nonatomic, strong) BottomNavBar *bottomNavBar;

@property (nonatomic, strong) UIButton     *suspendButton;

@property (nonatomic, assign) BOOL              hasSuspendButton;   //是否展示底部悬浮按钮

//add by zhangbeibei:20141021 增加此字段，若为YES，则在控制器的返回按钮方法中优先返回上一页
@property (nonatomic, assign) BOOL              needBackForePage;

@property (nonatomic, assign) BOOL        hasAnalyzeButton; //检测请求的button，add by chupeng
@property (nonatomic, strong) UIButton    *analyzeButton;   //检测button

//展示侧滑
- (void)orderYiGouBtnShowRightSideView;

- (void)useBottomNavBar;

+ (id)controller;

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

- (void)HttpRelease;

//- (void)login;
//- (LoginViewController *)checkLoginWithLoginedBlock:(SNBasicBlock)loginedBlock
//                                   loginCancelBlock:(SNBasicBlock)cancelBlock;
//- (LoginViewController *)checkLoginWithLoginedBlockAfterDismissed:(SNBasicBlock)loginedBlock
//                                   loginCancelBlock:(SNBasicBlock)cancelBlock;
//
//
//- (void)backForePage;//左边item
//- (void)righBarClick;//右边item
//
//- (UIBarButtonItem *)rightBtnItemWithTitle:(NSString *)name;
//
////工具方法计算visibileRect
//- (CGRect)visibleBoundsShowNav:(BOOL)hasNav showTabBar:(BOOL)hasTabBar;
//
////去逛逛
//- (void)goAround;
//- (void)goAroundWithCompleteBlock:(SNBasicBlock)callback;
//
////路由到路由器逻辑
//- (void)routeWithUrl:(NSString *)url complete:(void(^)(BOOL isSuccess, NSString *errorMsg))completeBlock;
//- (void)routeWithAdTypeCode:(NSString *)adTypeCode adId:(NSString *)adId complete:(void(^)(BOOL isSuccess))completeBlock;
//
//
//- (void)handleTargetType:(NSString *)targetType targetURLString:(NSString *)targetURL;
@end