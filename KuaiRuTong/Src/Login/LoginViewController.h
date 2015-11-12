//
//  LoginViewController.h
//  jxtuan
//
//  Created by 融通互动 on 13-8-19.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import "CommonViewController.h"
#import "LoginDataService.h"


@interface LoginViewController : CommonViewController<UITextFieldDelegate,UIAlertViewDelegate,LoginDelegate>
{
    UITextField * nameTextField;
    UITextField * passwordTextField;
    
    
    
}

@property(nonatomic,copy)NSString *loginName;
@property(nonatomic,assign)int curIndex;

@property(nonatomic,assign)BOOL isSupplerSelected;

@property (nonatomic, strong) LoginDataService *loginService;
//- (void)setUserName:(NSString *)name;
@end
