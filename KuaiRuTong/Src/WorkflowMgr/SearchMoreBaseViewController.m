//
//  SearchMoreBaseViewController.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/23.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "SearchMoreBaseViewController.h"
#import "RETableViewManager.h"
#import "RETableViewOptionsController.h"

@interface SearchMoreBaseViewController ()<RETableViewManagerDelegate>{
    UITableView *tableView;
}

//@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) RETableViewManager *manager;
@property (strong, nonatomic) RETableViewSection *basicControlsSection;
@property (strong, nonatomic) RETableViewSection *buttonSection;


//@property (strong, readwrite, nonatomic) RETextItem *fullLengthFieldItem;
@property (strong, readwrite, nonatomic) RETextItem *textItem;
//@property (strong, readwrite, nonatomic) RENumberItem *numberItem;
//@property (strong, readwrite, nonatomic) RETextItem *passwordItem;
//@property (strong, readwrite, nonatomic) REBoolItem *boolItem;
//@property (strong, readwrite, nonatomic) REFloatItem *floatItem;
@property (strong, readwrite, nonatomic) REDateTimeItem *dateTimeItem;

@end

@implementation SearchMoreBaseViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigation.title = self.NavTitle;
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT) style:UITableViewStyleGrouped];
    tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:tableView delegate:self];
    
    self.basicControlsSection = [self addBasicControls];
    self.buttonSection = [self addButton];
}

- (RETableViewSection *)addBasicControls
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"搜索条件"];
    [self.manager addSection:section];
    
    self.textItem = [RETextItem itemWithTitle:@"商户" value:nil placeholder:@"请输入商户名"];

    self.dateTimeItem = [REDateTimeItem itemWithTitle:@"日期" value:[NSDate date] placeholder:@"请输入日期" format:@"MM/dd/yyyy" datePickerMode:UIDatePickerModeDate];
    self.dateTimeItem.onChange = ^(REDateTimeItem *item){
        NSLog(@"Value: %@", item.value.description);
    };
    
    self.dateTimeItem.inlineDatePicker = YES;
    
    [section addItem:self.textItem];
    [section addItem:self.dateTimeItem];

    return section;
}

#pragma mark -
#pragma mark Button Example

- (RETableViewSection *)addButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"搜索" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        //item.title = @"Pressed!";
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
    return section;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 0) {
        return 2;
    }
    else{
        return 1;
    } 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
