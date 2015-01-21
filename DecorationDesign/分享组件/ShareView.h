//
//  ShareView.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/11.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareItem.h"
#import "WXShareApi.h"
#import "YXShareApi.h"
#import "XLWeiboApi.h"
#import "QQkongjianApi.h"
#import "TCWeiboApi.h"
#import <MessageUI/MFMessageComposeViewController.h>
@interface ShareView : UIView<UIAlertViewDelegate,weixindelegate,yixindelegate,xinlangdelegate,qqkongjiandelegate,tengxundelegate,MFMessageComposeViewControllerDelegate>
{
    UIImageView *backBackImageView;
}
@property (nonatomic, strong) UIButton *handerView;
@property (nonatomic, copy) void (^selectItemAtIndex)(NSInteger index);
@property (nonatomic,retain) NSString *shareUrl;
@property (nonatomic,retain) NSString *shareTitle;
@property (nonatomic,retain) NSString *shareDesc;
@property (nonatomic,retain) NSString *shareImageUrl;
-(void)show;
@end
