//
//  AdvertisingController.h
//  DecorationDesign
//
//  Created by 许开伟 on 15/2/2.
//  Copyright (c) 2015年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "ImageLooker.h"
#import "LoginViewController.h"
#import "CommentViewController.h"
#import "BookingViewController.h"

@interface AdvertisingController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>
{
    UIScrollView *imagescrollView;
    NSMutableArray *viewControllers;
    NSMutableArray *guanggaoArray;
    NSUInteger kNumberOfPages;
    NSUInteger kCurrentPage;
    UILabel *pageLabel;
    UITextView *descTextView;
    UITextField *textField;
    NSString *productId;
    NSString *produceName;
    NSString *commentNum;
    NSArray *m_array;
}

@property(nonatomic, retain)UIScrollView *imagescrollView;
@property(nonatomic, retain)NSMutableArray *viewControllers;
@property(nonatomic, retain)NSMutableArray *guanggaoArray;
@property(nonatomic, retain)NSString *plateType;
@property(nonatomic, retain)NSString *plateCode;
@property(nonatomic, retain)NSString *pageMark;
@property(nonatomic, retain) NSString *productId;
@property(nonatomic, retain) NSString *produceName;
@property(nonatomic, retain) NSString *commentNum;
@property(nonatomic, retain) NSArray *m_array;
@end
