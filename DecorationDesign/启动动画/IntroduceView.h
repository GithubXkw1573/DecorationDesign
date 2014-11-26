//
//  IntroduceView.h
//  QSQ
//
//  Created by ssyz on 13-8-20.
//  Copyright (c) 2013年 luob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface IntroduceView : UIView<UIScrollViewDelegate>{
    NSUInteger kNumberOfPages;
    NSMutableArray *viewControllers;
    BOOL pageControlUsed;
    UIPageControl *pageControl;
    UIScrollView *imagescrollView;
}
@property(nonatomic,retain)UIScrollView *imagescrollView;
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,retain)NSMutableArray *viewControllers;
-(void)loadScrollViewWithPage:(int)page;
-(void)BeganBtnPressed:(id)sender;
@end
