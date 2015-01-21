//
//  ScrollMenu.h
//  TGQ2
//
//  Created by 许开伟 on 14-8-21.
//  Copyright (c) 2014年 元元. All rights reserved.
//
@protocol MyListScrollViewDelegate <NSObject>

@optional
-(void)ButtonListDidSelectWithItem:(NSNumber*)index;
@end

@class NewsScrollView;

#import <UIKit/UIKit.h>
#import "common.h"
#import "TypeButton.h"
#import "CityItem.h"

@interface ScrollMenu : UIScrollView<UIScrollViewDelegate>
{
    NSArray *itemList;
    NSInteger preIndex;
    NSInteger currIndex;
    CGFloat offsetx;
}
@property (nonatomic,assign) id<MyListScrollViewDelegate> myDelegate;
@property (nonatomic,retain) NewsScrollView *newsScrollView;
-(void)updateListItem:(NSArray *)_itemList;
-(void)changeNaviItem:(NSInteger)index;
-(void)selectItem:(UIButton*)btn;
@end
