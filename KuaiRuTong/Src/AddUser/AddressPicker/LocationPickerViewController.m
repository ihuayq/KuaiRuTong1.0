//
//  LocationPickerViewController.m
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/17.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "LocationPickerViewController.h"

#import "Header.h"

@interface LocationPickerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>{
    UILabel *label;
}

@property (strong, nonatomic)  UIPickerView *myPicker;
@property (strong, nonatomic)  UIView *pickerBgView;
@property (strong, nonatomic) UIView *maskView;


@property (strong, nonatomic)  UIButton *okBtn;
@property (strong, nonatomic)  UIButton *cancelBtn;

//data
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;



@end

@implementation LocationPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPickerData];
    [self initView];
}

#pragma mark - init view
- (void)initView {
    self.navigation.title = @"省市区选择";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(10, NAVIGATION_OUTLET_HEIGHT + 20,MainWidth - 10*2,120)];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    //label.text = [NSString stringWithFormat:@"快入通"];
    label.textAlignment = NSTextAlignmentCenter;
    //    label.layer.borderWidth = 1;
    //    label.layer.borderColor = color;
    [self.view addSubview:label];
    
//    self.maskView = [[UIView alloc] initWithFrame:kScreen_Frame];
//    self.maskView.backgroundColor = [UIColor blackColor];
//    self.maskView.alpha = 0;
//    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
//    [self.view addSubview:self.maskView];
    
    self.pickerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, MainHeight - 320 - 48, MainWidth, 320)];
    //self.pickerBgView.backgroundColor = [UIColor light_Gray_Color];
    [self.view addSubview:self.pickerBgView];
    
    self.myPicker = [[UIPickerView alloc] initWithFrame:self.pickerBgView.bounds];
    // 显示选中框
    self.myPicker.showsSelectionIndicator=YES;
    self.myPicker.dataSource = self;
    self.myPicker.delegate = self;
    [self.pickerBgView addSubview:self.myPicker];
    
    self.okBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    [self.okBtn addTarget:self action:@selector(touchOkBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.okBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [self.okBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [self.pickerBgView addSubview:self.okBtn];
    
    self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth -120, 0, 120, 40)];
    [self.cancelBtn addTarget:self action:@selector(touchCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [self.cancelBtn setTitle:@"取 消" forState:UIControlStateNormal];
    [self.pickerBgView addSubview:self.cancelBtn];
    
}

#pragma mark - get data
- (void)getPickerData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
    
    NSString *strProvince = [self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
    NSString *strCity = [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1]];
    NSString *strTown = [self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]];
    label.text = [NSString stringWithFormat:@"%@ %@ %@",strProvince,strCity,strTown];
}

-(void)touchOkBtn{
    
    if (self.block) {
        
        NSString *strProvince = [self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
        NSString *strCity = [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1]];
        NSString *strTown = [self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]];
        
        self.block(strProvince,strCity,strTown);
    }
    
    [self.navigationController popViewControllerAnimated:NO];
}


-(void)touchCancelBtn{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - private method
- (IBAction)showMyPicker:(id)sender {
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    self.maskView.alpha = 0;
    self.pickerBgView.top = self.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        self.pickerBgView.bottom = self.view.height;
    }];
}

- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBgView.top = self.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
}

#pragma mark - xib click

- (IBAction)cancel:(id)sender {
    [self hideMyPicker];
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)ensure:(id)sender {
    [self hideMyPicker];
    [self.navigationController popViewControllerAnimated:NO];
}



@end
