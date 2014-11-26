//
//  ScrollMenu.m
//  TGQ2
//
//  Created by 许开伟 on 14-8-21.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "ScrollMenu.h"

@implementation ScrollMenu
@synthesize newsScrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator=NO;
        self.backgroundColor = [UIColor whiteColor];
        self.directionalLockEnabled = YES;
        self.delegate = self;
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height-1);
    }
    return self;
}

-(void)updateListItem:(NSArray *)_itemList
{
    itemList = _itemList;
    [itemList retain];
    for(UIView *v in self.subviews)
        [v removeFromSuperview];
    
    for(int i=0; i<itemList.count;i++)
    {
        NSDictionary *dic =[PublicFunction fixDictionary:[itemList objectAtIndex:i]] ;
        TypeButton *tBtn = [[TypeButton alloc] initWithFrame:CGRectMake(i*64, 4, 64, 44)];
        tBtn.title = [dic objectForKey:@"name"];
        tBtn.typeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        tBtn.tag = 100+i;
        if (i == 0) {
            currIndex = i;
            tBtn.selected = YES;
        }
        else{
            tBtn.selected = NO;
        }
        [tBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tBtn];
    }
    if (itemList.count*64 <= self.frame.size.width) {
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height-1);
    }
    else{
        self.contentSize = CGSizeMake(itemList.count*64+64, self.frame.size.height-1);
    }
}

-(void)btnClick:(UIButton*)btn
{
    preIndex = currIndex;
    currIndex = btn.tag -100;
    if(preIndex != currIndex){
        if (_myDelegate && [_myDelegate respondsToSelector:@selector(ButtonListDidSelectWithItem:)]) {
            [_myDelegate performSelector:@selector(ButtonListDidSelectWithItem:) withObject:[NSNumber numberWithInteger:currIndex]];
        }
        btn.selected = YES;
        TypeButton *preBtn = (TypeButton*)[self viewWithTag:preIndex+100];
        preBtn.selected = NO;
        
        [newsScrollView setContentOffset:CGPointMake(currIndex*applicationwidth, 0)];
    }
}

-(void)selectItem:(UIButton*)btn
{
    preIndex = currIndex;
    currIndex = btn.tag -200;
    if(preIndex != currIndex){
        if (_myDelegate && [_myDelegate respondsToSelector:@selector(ButtonListDidSelectWithItem:)]) {
            [_myDelegate performSelector:@selector(ButtonListDidSelectWithItem:) withObject:[NSNumber numberWithInteger:currIndex]];
        }
        TypeButton *currBtn = (TypeButton*)[self viewWithTag:currIndex+100];
        currBtn.selected = YES;
        TypeButton *preBtn = (TypeButton*)[self viewWithTag:preIndex+100];
        preBtn.selected = NO;
        
        [newsScrollView setContentOffset:CGPointMake(currIndex*applicationwidth, 0)];
        CGRect frame = self.frame;
        frame.origin.x = currIndex*64;
        frame.origin.y = 0;
        [self scrollRectToVisible:frame animated:YES];
    }
}

-(void)changeNaviItem:(NSInteger)index
{
    if (index>=0) {
        preIndex = currIndex;
        currIndex = index;
        TypeButton *preBtn = (TypeButton*)[self viewWithTag:(100+preIndex)];
        preBtn.selected = NO;
        TypeButton *Btn = (TypeButton*)[self viewWithTag:(100+currIndex)];
        Btn.selected = YES;
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    offsetx = scrollView.contentOffset.x;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    offsetx = scrollView.contentOffset.x;
}

@end
