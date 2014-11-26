//
//  NewsScrollView.h
//  TGQ2
//
//  Created by 许开伟 on 14-8-22.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTableView.h"
#import "ScrollMenu.h"
@class NewsTableView;
@interface NewsScrollView : UIScrollView<UIScrollViewDelegate,NewsTableViewDelegate,MyListScrollViewDelegate>
{
    NSUInteger kNumberOfPages;
    UIPageControl *pageControl;
    BOOL pageControlUsed;
}
@property (nonatomic,retain) NSMutableArray *viewControllers;
@property(nonatomic,retain)NSMutableArray *zixunleibieused;
@property (nonatomic,retain) ScrollMenu *navigationScrollView;
@property (nonatomic,assign) id<NewsTableViewDelegate> t_delegate;
-(void)reloadscrollview:(NSMutableArray*)menuList;
@end
