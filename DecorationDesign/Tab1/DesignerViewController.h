//
//  DesignerViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/19.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "PersonIntroduceView.h"
#import "ZuopingView.h"
#import "ArticleView.h"

@interface DesignerViewController : UIViewController<UIScrollViewDelegate>
{
    NSMutableArray *viewControllers;
    UIScrollView *myscrollView;
    UIView *shadow;
}
@property (nonatomic,retain) UIImageView *designerPicView;
@property(nonatomic, retain)NSMutableArray *viewControllers;
@property(nonatomic, retain)UIScrollView *myscrollView;
@end
