//
//  ZuopingLookViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/20.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "ImageLooker.h"

@interface ZuopingLookViewController : UIViewController<UIScrollViewDelegate>
{
    NSMutableArray *zuopingList;
    NSMutableArray *viewControllers;
    ImageLooker *imagescrollView;
    UIScrollView *myscrollView;
    NSUInteger kNumberOfPages;
    UIPageControl *pageControl;
    BOOL pageControlUsed;
    UILabel *descLabel;
    UILabel *authorLabel;
}
@property(nonatomic, retain)NSMutableArray *viewControllers;
@property(nonatomic, retain)ImageLooker *imagescrollView;
@property(nonatomic, retain)UIScrollView *myscrollView;
@property (nonatomic,retain) NSMutableArray *zuopingList;
@property (nonatomic,retain)UIPageControl *pageControl;
@end
