//
//  FaxianViewController.h
//  TGQ2
//
//  Created by 元元 on 14-7-15.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "ScrollMenu.h"
#import "NewsScrollView.h"
#import "NewsTableView.h"
#import "CityItem.h"
#import "DesignerViewController.h"

@interface FaxianViewController : UIViewController<NewsTableViewDelegate>
{
    NewsScrollView *newsScrollView;
    ASIFormDataRequest *queryMenuListRequest;
    ASIFormDataRequest *queryNewsListRequest;
    ScrollMenu *scrollMenu;
    MBProgressHUD *MBProgress;
    UIButton *moreButton;
    UIView *moreView;
}
@property (nonatomic,assign) NSInteger *contentType;
@property (nonatomic,copy) NSMutableArray *menuList;
@property (nonatomic,copy) NSMutableArray *activityList;
@property (nonatomic,copy) NSDictionary *m_dictionary;

@end
