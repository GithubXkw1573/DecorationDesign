//
//  WXShareApi.h
//  MyShared
//
//  Created by 王浩 on 13-12-16.
//  Copyright (c) 2013年 王浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "common.h"

@protocol weixindelegate

-(void)sharesuccessful:(NSString *)str;
-(void)sharefailed:(NSString *)str;

@end

@protocol wxlogindelegate

-(void)loginsuccessful:(NSString *)str OAuth:(id)OAuth userinfo:(NSDictionary *)dic;
-(void)loginfailed:(NSString *)str;

@end

@interface WXShareApi : NSObject<WXApiDelegate,UIAlertViewDelegate>{
    enum WXScene wxscene;
    id<weixindelegate>delegate;
    id<wxlogindelegate>logindelegate;
}
@property(assign,nonatomic)id<weixindelegate>delegate;
@property(assign,nonatomic)id<wxlogindelegate>logindelegate;
+(WXShareApi *)shared;
//判断是否安装
-(BOOL)isWXAppInstalled;
//下载微信app
-(void)weiXinDownLoad;
//切换使用场景
-(void)changeScene:(NSInteger)scene;
//分享文字
-(void)sendTextContent;
-(void)sendLinkContent:(NSString *)url imageContent:(UIImage *)image title:(NSString *)title detail:(NSString *)detail;
-(BOOL)handleOpen:(NSURL*)url;
-(void)weixinlogin;
@end
