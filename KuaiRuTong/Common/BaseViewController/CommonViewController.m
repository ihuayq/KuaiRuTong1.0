//
//  BaseViewController.m
//  Canada
//
//  Created by zhaojianguo on 13-10-9.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import "CommonViewController.h"
#import "UIView+ActivityIndicator.h"
#import "BBTipView.h"
#import "BBAlertView.h"
#import "NSTimerHelper.h"

@interface CommonViewController ()

@end

@implementation CommonViewController
@synthesize navigation = _navigation;
@synthesize  dlgTimer = _dlgTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString * systeam = [UIDevice currentDevice].systemVersion;
    float number = [systeam floatValue];
    
    CGFloat height = 0.0f;
    NSInteger type = 0;
    if (number <= 6.9) {
        type = 0;
        height = 44.0f;
    }else{
        type = 1;
        height = 66.0f;
    }
    
    //globle = [Globle shareGloble];
    
    self.navigation = [[ZZNavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    _navigation.type = type;
    //_navigation.leftImage  = [UIImage imageNamed:@"nav_backbtn.png"];
    _navigation.delegate = self;
    _navigation.backgroundColor = UISTYLECOLOR;
    [self.view addSubview:_navigation];
    
     NSLog(@"the title navigation is:%@",self.navigation);

	// Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (UIColor *)getRandomColor
{
    UIColor *color = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return color;
}

#pragma mark ##### ZZNavigationViewDelegate ####
-(void)previousToViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClickEvent
{
    
}


- (void)setDlgTimer:(NSTimerHelper *)dlgTimer
{
    if (dlgTimer != _dlgTimer) {
        TT_INVALIDATE_TIMER(_dlgTimer);
        _dlgTimer = dlgTimer;
    }
}

- (void)displayOverFlowActivityView:(NSString*)indiTitle{
    
    [self.view showHUDIndicatorViewAtCenter:indiTitle];
    
    self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT*1.5
                                                           target:self
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil
                                                          repeats:NO];
    
    return;
    
}

- (void)displayOverFlowActivityView:(NSString *)indiTitle maxShowTime:(CGFloat)time
{
    [self.view showHUDIndicatorViewAtCenter:indiTitle];
    
    if (time > 0.0f) {
        self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:time*1.5
                                                               target:self
                                                             selector:@selector(timeOutRemoveHUDView)
                                                             userInfo:nil
                                                              repeats:NO];
    }else{
        self.dlgTimer = nil;
    }
    
    return;
}


- (void)displayOverFlowActivityView{
    
    [self.view showHUDIndicatorViewAtCenter:L(@"Loading...")];
    
    self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT*1.5
                                                           target:self
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil
                                                          repeats:NO];
    
    return;
    
}

- (void)displayOverFlowActivityView:(NSString*)indiTitle yOffset:(CGFloat)y{
    
    [self.view showHUDIndicatorViewAtCenter:indiTitle yOffset:y];
    
    self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT*1.5
                                                           target:self
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil
                                                          repeats:NO];
    
    return;
    
}

- (void)timeOutRemoveHUDView
{
    [self.view hideHUDIndicatorViewAtCenter];
}


- (void)timerOutRemoveOverFlowActivityView
{
    
    [self.view hideActivityViewAtCenter ];
    
    return;
    
    
}

- (void)removeOverFlowActivityView
{
    [self.view hideHUDIndicatorViewAtCenter];
    
    TT_INVALIDATE_TIMER(_dlgTimer);
    
}

- (void)presentSheet:(NSString*)indiTitle{
    
    if (!indiTitle.length)
    {
        indiTitle = kServerBusyErrorMsg;
    }
    [self.view showTipViewAtCenter:indiTitle];
}
- (void)presentSheet:(NSString *)indiTitle timer:(int)aTimer
{
    if (!indiTitle.length)
    {
        indiTitle = kServerBusyErrorMsg;
    }
    [self.view showTipViewAtCenter:indiTitle timer:aTimer];
}

- (void)presentSheet:(NSString*)indiTitle posY:(CGFloat)y{
    
    if (!indiTitle.length)
    {
        indiTitle = kServerBusyErrorMsg;
    }
    [self.view showTipViewAtCenter:indiTitle posY:y];
    
}

- (void)presentSheetOnNav:(NSString *)indiTitle
{
    [self.navigationController.view showTipViewAtCenter:indiTitle];
}


//添加可展示两行的sheet
- (void)presentSheet:(NSString *)indiTitle subMessage:(NSString *)msg
{
    [self.view showTipViewAtCenter:indiTitle message:msg];
}

- (void)presentSheet:(NSString *)indiTitle subMessage:(NSString *)msg posY:(CGFloat)y
{
    [self.view showTipViewAtCenter:indiTitle message:msg posY:y];
}



- (void)presentCustomDlg:(NSString*)indiTitle{
    
    BBAlertView *alert = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault
                                                      Title:L(@"system-info")
                                                    message:indiTitle
                                                 customView:nil
                                                   delegate:self
                                          cancelButtonTitle:L(@"Confirm")
                                          otherButtonTitles:nil];
    [alert show];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
