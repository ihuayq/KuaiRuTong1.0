//
//  TimeLineCell.m
//  KuaiRuTong
//
//  Created by huayq on 15/12/4.
//  Copyright © 2015年 hkrt. All rights reserved.
//

#import "TimeLineCell.h"

@implementation TimeLineCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 225;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
//    self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 0, 306, 306)];
//    self.pictureView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//    [self addSubview:self.pictureView];
    

}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    self.timeLineView = [[TimeLineViewControl alloc] initWithTimeArray:self.item.descriptions
                                               andTimeDescriptionArray:self.item.descriptions
                                                      andCurrentStatus:self.item.nIndex
                                                              andFrame:CGRectMake(10, 10, MainWidth - 30, 300)];
    [self addSubview:self.timeLineView];
}

- (void)cellDidDisappear
{
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
