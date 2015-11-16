//
//  ShowImageViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/9/24.
//  Copyright © 2015年 HKRT. All rights reserved.
//

#import "SuperViewController.h"

@interface ShowImageViewController : SuperViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (nonatomic, strong)NSString *navTitle;
@property (nonatomic, assign)NSInteger currentPhotoTag;
@property (nonatomic)BOOL isTakePhoto;
@end
