//
//  SubCateViewController.m
//  top100
//
//  Created by Dai Cloud on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SubCateViewController.h"
#define COLUMN 4

@interface SubCateViewController ()

@end

@implementation SubCateViewController

@synthesize cateVC=_cateVC;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 180)];
    self.image.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.image];
    
    self.btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth/4 - MainWidth/6,self.image.origin.y + self.image.size.height + 10,MainWidth/3,40)];
    [self.btnLeft addTarget:self.cateVC  action:@selector(selectPhotoGroup:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnLeft setTitle:@"上   传" forState:UIControlStateNormal];
    [self.btnLeft.layer setMasksToBounds:YES];
    [self.btnLeft.layer setCornerRadius:self.btnLeft.frame.size.height/2.0f];
    self.btnLeft.backgroundColor = ORANGE_COLOR;
    [self.view  addSubview:self.btnLeft];
    
    // MainHeight - 48 - NAVIGATION_OUTLET_HEIGHT
    self.btnRight = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth/2 + MainWidth/4 - MainWidth/6 , self.image.origin.y + self.image.size.height + 10, MainWidth/3, 40)];
    [self.btnRight addTarget:self.cateVC  action:@selector(selectCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnRight setTitle:@"保   存" forState:UIControlStateNormal];
    self.btnRight.backgroundColor = ORANGE_COLOR;
    self.btnRight.layer.masksToBounds = YES;
    [self.btnRight.layer setCornerRadius:self.btnRight.frame.size.height/2.0f];
    [self.view addSubview:self.btnRight];
    
    CGRect viewFrame = self.view.frame;
    viewFrame.size.height = 220 + 20;
    self.view.frame = viewFrame;
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

@end
