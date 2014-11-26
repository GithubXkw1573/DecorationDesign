//
//  YXShareApi.h
//  YXShareApi
//
//  Created by 王浩 on 13-12-17.
//  Copyright (c) 2013年 王浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXApi.h"

@protocol yixindelegate

-(void)sharesuccessful:(NSString *)str;
-(void)sharefailed:(NSString *)str;

@end

@interface YXShareApi : NSObject< YXApiDelegate,UIAlertViewDelegate>{
    enum YXScene yxscene;
    id<yixindelegate>delegate;
}
@property(assign,nonatomic)id<yixindelegate>delegate;
+ (YXShareApi *)shared;
- (BOOL)handleOpen:(NSURL*)url;
//判断是否安装
- (BOOL)isYXAppInstalled;
//判断当前易信客户端的版本是否支持易信分享
- (BOOL)isYXAppSupportApi;
//选择模式
- (void)resetScene:(int)scene;
- (void)sendTextContent;
- (void)sendWebPageContent:(NSString *)url imageContent:(UIImage *)image title:(NSString *)title detail:(NSString *)detail;
@end
