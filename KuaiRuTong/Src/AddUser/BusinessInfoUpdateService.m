//
//  BusinessInfoUpdateService.m
//  KuaiRuTong
//
//  Created by huayq on 15/11/19.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "BusinessInfoUpdateService.h"
#import "FCFileManager.h"
#import "SHDataItem.h"
#import "ZipArchive.h"

@implementation BusinessInfoUpdateService


-(void)beginUpload:(NSDictionary*)parameters filePath:(NSString*)path{
    
    NSString *dealWithURLString =  [API_Upload_MercData stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];

    NSData * data = [FCFileManager readFileAtPathAsData:path];
    
    updateHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:parameters cmdCode:CC_BusinessUpload];
    updateHttpMsg.requestMethod = RequestMethodPostStream;
    updateHttpMsg.postData = data;
    
    [self.httpMsgCtrl sendHttpMsg:updateHttpMsg];
}


-(void)beginUpload:(SHDataItem*)data{
    NSMutableDictionary *infoDic = [[NSMutableDictionary alloc] init];
    //商户名
    [infoDic setObject:data.shop_name forKey:@"shop_name"];
    //mcc
    [infoDic setObject:data.industry forKey:@"industry"];
    [infoDic setObject:data.industry_subclass forKey:@"industry_subclass"];
//#ifdef Test
//    [infoDic setObject:@"5945" forKey:@"mcc"];
//#else
    [infoDic setObject:data.mcc forKey:@"mcc"];
//#endif
    [infoDic setObject:data.account_name forKey:@"account_name"];
    //邀请码
    [infoDic setObject:data.pub_pri forKey:@"pub_pri"];
    [infoDic setObject:data.invitation_code forKey:@"invitation_code"];
    //银行卡信息
    [infoDic setObject:data.bank_card_num forKey:@"bank_card_num"];
    [infoDic setObject:data.bank_province forKey:@"bank_province"];
    [infoDic setObject:data.bank_city forKey:@"bank_city"];
    [infoDic setObject:data.bank_add forKey:@"bank_add"];
    //手机号
    [infoDic setObject:@"" forKey:@"phone_num"];
    [infoDic setObject:@"" forKey:@"phone_verify"];
    //网点信息
    [infoDic setObject:data.pos_code forKey:@"pos_code"];
    [infoDic setObject:data.branch_add  forKey:@"branch_add"];
    
    //推销员登陆名

#ifdef Test
    [infoDic setObject:@"agesales" forKey:@"name"];

#else
    NSString *username = [[[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfoData"] objectForKey:@"username"];
    [infoDic setObject: username forKey:@"name"];
#endif

    
    //压缩数据
    NSString* docPath = [FCFileManager pathForDocumentsDirectory];
    
    ZipArchive *za = [[ZipArchive alloc] init];
    [za CreateZipFile2: [NSString stringWithFormat:@"%@/zipfile.zip",docPath]];
    
    BOOL isbool;
    isbool = [FCFileManager createFileAtPath:@"temp_1.jpg" withContent:data.photo_business_permit overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_1.jpg",docPath] newname:@"1.jpg"];
    
    isbool = [FCFileManager createFileAtPath:@"temp_2.jpg" withContent:data.photo_identifier_front  overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_2.jpg",docPath] newname:@"2.jpg"];
    
    isbool = [FCFileManager createFileAtPath:@"temp_3.jpg" withContent:data.photo_identifier_back  overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_3.jpg",docPath] newname:@"3.jpg"];
    
    isbool = [FCFileManager createFileAtPath:@"temp_4.jpg" withContent:data.photo_business_place  overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_4.jpg",docPath] newname:@"4.jpg"];
    
    isbool = [FCFileManager createFileAtPath:@"temp_5.jpg" withContent:data.photo_bankcard_front  overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_5.jpg",docPath] newname:@"5.jpg"];
    
    isbool = [FCFileManager createFileAtPath:@"temp_6.jpg" withContent:data.photo_bankcard_back  overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_6.jpg",docPath] newname:@"6.jpg"];
    
    isbool = [FCFileManager createFileAtPath:@"temp_7.jpg" withContent:data.photo_contracts  overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_7.jpg",docPath] newname:@"7.jpg"];

    
    BOOL success = [za CloseZipFile2];
    NSLog(@"Zipped file with result %d",success);
    
    [self beginUpload:infoDic filePath:@"zipfile.zip"];
    
}


-(void)downLoadWithMerName:(NSString*)MerName{
    NSString *dealWithURLString =  [API_Download_MercData stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [[userDefaults objectForKey:@"UserInfoData"] objectForKey:@"username"];
#ifdef Test
    [postDic setObject:@"agesales" forKey:@"name"];
    [postDic setObject:@"Pi"  forKey:@"shop_name"];
#else
    [postDic setObject:username forKey:@"name"];
    [postDic setObject:shopName  forKey:@"shop_name"];
#endif

    
    downLoadIssueHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:postDic cmdCode:CC_IssueBusinessDownload];
//    downLoadIssueHttpMsg.requestMethod = RequestMethodPostStream;
//    downLoadIssueHttpMsg.postData = data;
    
    [self.httpMsgCtrl sendHttpMsg:downLoadIssueHttpMsg];
}


-(void)downLoadFileWithFlowID:(NSString*)flowID
{
    
    NSString *dealWithURLString =  [API_Download_IssueFile stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
   
#ifdef Test
    [postDic setObject:@"201511061054171045948" forKey:@"flowId"];
#else
    [postDic setObject:flowID forKey:@"name"];
#endif
    
    
    downLoadFileHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:dealWithURLString postDataDic:postDic cmdCode:CC_IssueBusinessDownloadFile];
    downLoadFileHttpMsg.requestMethod = RequestMethodDownLoad;
    //    downLoadIssueHttpMsg.postData = data;
    
    [self.httpMsgCtrl sendHttpMsg:downLoadFileHttpMsg];
}

-(SHDataItem *)issueData{
    if (!_issueData) {
        _issueData = [[SHDataItem alloc]init];
    }
    return _issueData;
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    //    [self removeOverFlowActivityView];
    if (receiveMsg.cmdCode == CC_BusinessUpload)
    {
        NSDictionary *item = receiveMsg.jasonItems;
        DLog(@"THE upload info:%@",item);
        
        if (_delegate && [_delegate respondsToSelector:@selector(getBusinessInfoUpdateServiceResult:Result:errorMsg:)]) {
            [_delegate getBusinessInfoUpdateServiceResult:self Result:YES errorMsg:item[@"msg"]];
        }

    }
    else if (receiveMsg.cmdCode == CC_IssueBusinessDownload)
    {
        NSDictionary *item = receiveMsg.jasonItems;
        DLog(@"THE download info:%@",item);
        
        self.issueData.shop_name = item[@"mercName"];
        self.issueData.industry = item[@"category"];
        self.issueData.industry_subclass = item[@"mccName"];
        self.issueData.mcc = item[@"mcc"];
        self.issueData.account_name = item[@"bankName"];
        self.issueData.bank_card_num = item[@"bankNo"];
        
        self.issueData.pub_pri = item[@"pub_pri"];
        //self.issueData.invitation_code = item[@"invitation_code"];
        self.issueData.bank_province = item[@"province"];
        self.issueData.bank_city = item[@"city"];
        //self.issueData.bank_add = item[@"bank_add"];
        
        self.issueData.applyDate = item[@"applyDate"];
        self.issueData.examineComment = item[@"examineComment"];
        self.issueData.flowId = item[@"flowId"];
        
        self.issueData.phone_num = item[@"phoneNo"];
        //self.issueData.pub_pri = item[@"pub_pri"];
        
        //self.issueData.pos_code = item[@"pos_code"];
        //self.issueData.branch_add = item[@"branch_add"];
        NSMutableArray *arrayNetPointAddress =[[NSMutableArray alloc]init];
        NSMutableArray *arrayNetPointPosNo=[[NSMutableArray alloc]init];
        
        NSArray *dataArray = [[NSArray alloc] initWithArray:item[@"shop"]];
        for (NSDictionary *mod in dataArray) {
            NSString *strCityInfo = [NSString stringWithFormat:@"%@,%@,%@,%@",mod[@"provn"],mod[@"city"],mod[@"coun"],mod[@"address"]];
            [arrayNetPointAddress addObject:strCityInfo];
            [arrayNetPointPosNo addObject:mod[@"serialNos"]];
        }
        
        self.issueData.pos_code = [arrayNetPointPosNo componentsJoinedByString:@";"];
        self.issueData.branch_add = [arrayNetPointAddress componentsJoinedByString:@";"];
        
        if (_delegate && [_delegate respondsToSelector:@selector(getIssuedBusinessInfoServiceResult:Result:errorMsg:)]) {
            [_delegate getIssuedBusinessInfoServiceResult:self Result:YES errorMsg:nil];
        }
    }
    
    else if (receiveMsg.cmdCode == CC_IssueBusinessDownloadFile)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(getIssuedBusinessPictureServiceResult:Result:errorMsg:)]) {
            [_delegate getIssuedBusinessPictureServiceResult:self Result:YES errorMsg:nil];
        }
        
    }
}


@end
