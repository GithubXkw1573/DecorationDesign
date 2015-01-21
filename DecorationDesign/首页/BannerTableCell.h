//
//  BannerTableCell.h
//  TGQ2
//
//  Created by 许开伟 on 14-8-25.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface BannerTableCell : UITableViewCell<UIScrollViewDelegate>
{
    NSUInteger kNumberOfPages;
    BOOL pageControlUsed;
    NSMutableArray *guanggaoArray;
    UIScrollView *imagescrollView;
    UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    
}
@property(nonatomic, retain)NSMutableArray *viewControllers;
@property (nonatomic,retain) NSDictionary  *m_dictionary;
@property(nonatomic, retain)NSMutableArray *guanggaoArray;
@property(nonatomic, retain)UIScrollView *imagescrollView;
@property(nonatomic, retain)UIPageControl *pageControl;
@property(nonatomic, retain)NSString *plateType;
@property(nonatomic, retain)NSString *plateCode;
- (void)setCell:(NSDictionary *)dic row:(int)row;
-(void)loadContent;
@end
