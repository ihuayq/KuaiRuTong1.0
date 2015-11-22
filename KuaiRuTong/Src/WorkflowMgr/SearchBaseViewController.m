//
//  SearchBaseViewController.m
//  KuaiRuTong
//
//  Created by 华永奇 on 15/11/22.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "SearchBaseViewController.h"
#import "BusinessSavedDAO.h"

@interface SearchBaseViewController ()

@end

@implementation SearchBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigation.leftImage  = [UIImage imageNamed:@"nav_backbtn.png"];
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
    [dao getAllSavedHistorysFromDB];
    
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

@end
