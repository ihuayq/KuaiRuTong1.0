//
//  CateViewController.m
//  top100
//
//  Created by Dai Cloud on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CateViewController.h"
#import "SubCateViewController.h"
#import "SHInfoTableViewCell.h"
#import "Globle.h"
#import "SHDataItem.h"
#import "BusinessSavedDAO.h"

@interface CateViewController () <UIFolderTableViewDelegate>{
    UIButton *uploadBtn;        //上传按钮
    UIButton *saveBtn;          //保存按钮
}

@property (strong, nonatomic) SubCateViewController *subVc;
@property (strong, nonatomic) NSDictionary *currentCate;


@end

@implementation CateViewController

@synthesize cates=_cates;
@synthesize subVc=_subVc;
@synthesize currentCate=_currentCate;
@synthesize tableView=_tableView;


-(NSArray *)cates
{
    if (_cates == nil){
        
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"Category" withExtension:@"plist"];
//        _cates = [NSArray arrayWithContentsOfURL:url];
        _cates = [Globle shareGloble].titleShDataArray;
        
    }
    
    return _cates;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView =  [[UIFolderTableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - SCREEN_BODY_HEIGHT - 240) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    uploadBtn = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth/4 - MainWidth/6,self.tableView.origin.y + self.tableView.size.height + 10,MainWidth/3,40)];
    //[cancelButton setFrame:CGRectMake(40,MainHeight -200, MainWidth-2*40, 40)];
    [uploadBtn addTarget:self action:@selector(uploadBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [uploadBtn setTitle:@"上   传" forState:UIControlStateNormal];
    [uploadBtn.layer setMasksToBounds:YES];
    [uploadBtn.layer setCornerRadius:uploadBtn.frame.size.height/2.0f]; //设置矩形四个圆角半径
    uploadBtn.backgroundColor = ORANGE_COLOR;
    [self.view  addSubview:uploadBtn];
    
    // MainHeight - 48 - NAVIGATION_OUTLET_HEIGHT
    saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(MainWidth/2 + MainWidth/4 - MainWidth/6 , self.tableView.origin.y + self.tableView.size.height + 10, MainWidth/3, 40)];
    [saveBtn addTarget:self action:@selector(saveBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitle:@"保   存" forState:UIControlStateNormal];
    saveBtn.backgroundColor = ORANGE_COLOR;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn.layer setCornerRadius:uploadBtn.frame.size.height/2.0f];
    [self.view addSubview:saveBtn];
    
    BusinessSavedDAO *dao= [[BusinessSavedDAO alloc] init];
    self.SHData = [dao searchSHItemDAOFromDB:self.shopName];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.cates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cate_cell";

    SHInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SHInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    

    //cell.logo.image = [UIImage imageNamed:[[cate objectForKey:@"imageName"] stringByAppendingString:@".png"]];
    cell.title.text = [self.cates objectAtIndex:indexPath.row];

//    NSMutableArray *subTitles = [[NSMutableArray alloc] init];
//    NSArray *subClass = [cate objectForKey:@"subClass"];
//    for (int i=0; i < MIN(4,  subClass.count); i++) {
//        [subTitles addObject:[[subClass objectAtIndex:i] objectForKey:@"name"]];
//    }
//    cell.subTtile.text = [subTitles componentsJoinedByString:@"/"];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row == 0 ) {
        
        return;
    }
    
    
    SHInfoTableViewCell *cell = (SHInfoTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    SubCateViewController *subVc = [[SubCateViewController alloc] init];
    subVc.cateVC = self;
    
    if ( indexPath.row == 1 ) {
        subVc.imageData= self.SHData.photo_business_permit;
    }
    else if ( indexPath.row == 2 ) {
        subVc.imageData= self.SHData.photo_identifier_front;
    }
    else if ( indexPath.row == 3 ) {
        subVc.imageData= self.SHData.photo_identifier_back;
    }
    else if ( indexPath.row == 4 ) {
        subVc.imageData= self.SHData.photo_business_place;
    }
    else if ( indexPath.row == 5 ) {
        subVc.imageData= self.SHData.photo_bankcard_front;
    }
    else if ( indexPath.row == 6 ) {
        subVc.imageData= self.SHData.photo_bankcard_back;
    }
    else if ( indexPath.row == 7 ) {
        subVc.imageData= self.SHData.photo_contracts;
    }

    subVc.imageData= self.SHData.photo_bankcard_back;
    [cell changeArrowWithUp:YES];
    
    self.tableView.scrollEnabled = NO;
    UIFolderTableView *folderTableView = (UIFolderTableView *)tableView;
    [folderTableView openFolderAtIndexPath:indexPath WithContentView:subVc.view 
                                 openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                     // opening actions
                                     //[cell changeArrowWithUp:NO];
                                 } 
                                closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                    // closing actions
                                    [cell changeArrowWithUp:YES];
                                } 
                           completionBlock:^{
                               // completed actions
                               self.tableView.scrollEnabled = YES;
                           }];
    
}

-(CGFloat)tableView:(UIFolderTableView *)tableView xForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)selectPhotoGroup:(UIButton *)btn
{

//    NSDictionary *subCate = [[self.currentCate objectForKey:@"subClass"] objectAtIndex:btn.tag];
//    NSString *name = [subCate objectForKey:@"name"];
//    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"子类信息"
//                                                         message:[NSString stringWithFormat:@"名称:%@, ID: %@", name, [subCate objectForKey:@"classID"]]
//                                                        delegate:nil
//                                               cancelButtonTitle:@"确认"
//                                               otherButtonTitles:nil];
//    [Notpermitted show];
//    [Notpermitted release];
    
    UIActionSheet *sheetImage = [[UIActionSheet alloc]initWithTitle:@"请选择方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    //sheetImage.tag = indexPath.row;
    [sheetImage showInView:[UIApplication sharedApplication].keyWindow];
    
}

-(void)selectCamera:(UIButton *)btn
{
}


#pragma mark -- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //currentPhotoTag = actionSheet.tag;
    if (buttonIndex != 2) {
        //实例化Controller
        UIImagePickerController*picker;
        if (!picker) {
            picker = [[UIImagePickerController alloc]init];
            //设置代理
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
        
        //默认选择是相册
        if (buttonIndex == 0) {
            //开启相机模式之前需要判断相机是否可用
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
        }
    }
}
@end
