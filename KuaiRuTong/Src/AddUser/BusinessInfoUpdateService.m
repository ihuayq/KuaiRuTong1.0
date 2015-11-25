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
    [infoDic setObject:data.mcc forKey:@"mcc"];
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
    
    NSString *username = [[[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfoData"] objectForKey:@"username"];
    [infoDic setObject: username forKey:@"name"];
    
    //压缩数据
    NSString* docPath = [FCFileManager pathForDocumentsDirectory];
    
    ZipArchive *za = [[ZipArchive alloc] init];
    [za CreateZipFile2: [NSString stringWithFormat:@"%@/zipfile.zip",docPath]];
    
    BOOL isbool;
    isbool = [FCFileManager createFileAtPath:@"temp_1.jpg" withContent:data.photo_business_permit overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_1.jpg",docPath] newname:@"new_1.jpg"];
    
    isbool = [FCFileManager createFileAtPath:@"temp_2.jpg" withContent:data.photo_identifier_front  overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_2.jpg",docPath] newname:@"new_2.jpg"];
    
    isbool = [FCFileManager createFileAtPath:@"temp_3.jpg" withContent:data.photo_identifier_back  overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_3.jpg",docPath] newname:@"new_3.jpg"];
    
    isbool = [FCFileManager createFileAtPath:@"temp_4.jpg" withContent:data.photo_business_place  overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_4.jpg",docPath] newname:@"new_4.jpg"];
    
    isbool = [FCFileManager createFileAtPath:@"temp_5.jpg" withContent:data.photo_bankcard_front  overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_5.jpg",docPath] newname:@"new_5.jpg"];
    
    isbool = [FCFileManager createFileAtPath:@"temp_6.jpg" withContent:data.photo_bankcard_back  overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_6.jpg",docPath] newname:@"new_6.jpg"];
    
    isbool = [FCFileManager createFileAtPath:@"temp_7.jpg" withContent:data.photo_contracts  overwrite:YES];
    [za addFileToZip:[NSString stringWithFormat:@"%@/temp_7.jpg",docPath] newname:@"new_7.jpg"];

    
    BOOL success = [za CloseZipFile2];
    NSLog(@"Zipped file with result %d",success);
    
    [self beginUpload:infoDic filePath:@"zipfile.zip"];
    
}



- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    //    [self removeOverFlowActivityView];
    if (receiveMsg.cmdCode == CC_BusinessUpload)
    {
        NSDictionary *item = receiveMsg.jasonItems;
    }
}


@end
