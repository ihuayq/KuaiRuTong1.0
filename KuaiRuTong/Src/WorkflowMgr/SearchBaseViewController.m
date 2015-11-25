//
//  SearchBaseViewController.m
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/22.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "SearchBaseViewController.h"
#import "BusinessSavedDAO.h"
#import "SearchMoreBaseViewController.h"
#import "CateViewController.h"

@interface SearchBaseViewController ()

@end

@implementation SearchBaseViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    //self.view.backgroundColor = [UIColor whiteColor];
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    self.navigation.rightImage = nil;
    self.navigation.title = @"搜索";

    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f,self.navigation.size.height+self.navigation.origin.y, self.view.size.width, 44.0f)];
    _searchBar.delegate =self;
    _searchBar.placeholder = @"输入要搜索的内容";
    //_searchBar.tintColor = [UIColor lightGrayColor];
    _searchBar.showsCancelButton = YES;
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchBar.size.height+self.searchBar.origin.y, self.view.size.width, self.view.size.height-self.searchBar.size.height-self.searchBar.origin.y-48.5f)];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self.view addSubview:_searchBar];
    
    BusinessSavedDAO *dao = [[BusinessSavedDAO alloc] init];
    array = [NSMutableArray arrayWithArray:[dao getAllSavedHistorysSimpleInfoFromDB]];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark Encode Chinese to ISO8859-1 in URL
-(NSString *)encodeUTF8Str:(NSString *)encodeStr{
    CFStringRef nonAlphaNumValidChars = CFSTR("![        DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");
    NSString *preprocessedString = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)encodeStr, CFSTR(""), kCFStringEncodingUTF8));
    NSString *newStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingUTF8));
    return newStr;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // called when keyboard search button pressed
    [_searchBar resignFirstResponder];
    
    if ([array count]!=0) {
        [array removeAllObjects];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier];
    }
    
    SHDataItem * model = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"商户:%@",model.shop_name];
//    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    SearchMoreBaseViewController* pushController = [[SearchMoreBaseViewController alloc] init];
//    [self.navigationController pushViewController:pushController animated:YES];
    
    
    CateViewController *vc = [[CateViewController alloc] init];
    
    SHDataItem * model = [array objectAtIndex:indexPath.row];
    vc.shopName = model.shop_name;
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
