//
//  TCWeiboApi.h
//  QSQ2
//
//  Created by 王浩 on 14-3-31.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboApi.h"

#define WiressSDKDemoAppKey     @"801213517"
#define WiressSDKDemoAppSecret  @"9819935c0ad171df934d0ffb340a3c2d"
#define REDIRECTURI             @"http://www.ying7wang7.com"

//需要导入库 Security Social Accounts

@protocol tengxundelegate

-(void)sharesuccessful:(NSString *)str;
-(void)sharefailed:(NSString *)str;
-(void)checkAuth:(int)ret;

@end

@interface TCWeiboApi : NSObject<WeiboRequestDelegate,WeiboAuthDelegate>{
    WeiboApi  *wbapi;
    id<tengxundelegate>delegate;
}
@property(assign,nonatomic)id<tengxundelegate>delegate;
@property(nonatomic,retain)WeiboApi *wbapi;
+(TCWeiboApi *)shared;
-(void)onExtend;
-(void)onLogin:(UIViewController*)ctr;
-(void)txweiboimageContent:(UIImage *)image title:(NSString *)title;
-(void)onLogout;
@end
