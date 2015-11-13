//
//  WorkManagerViewController.h
//  KuaiRuTong
//
//  Created by HKRT on 15/6/9.
//  Copyright (c) 2015年 HKRT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TipCollectionViewCell : UICollectionViewCell

//@property(nonatomic ,retain) UIImage *icon;
//@property(nonatomic ,retain) UILabel *title;


@property(nonatomic ,assign) int index;

@end


@interface WorkflowMgrViewController : CommonViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (strong, nonatomic)UICollectionView *collectionView;

@end
