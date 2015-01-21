//
//  TCWeiboApi.m
//  QSQ2
//
//  Created by 王浩 on 14-3-31.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "TCWeiboApi.h"

@implementation TCWeiboApi
@synthesize wbapi;
@synthesize delegate;

static TCWeiboApi *tcweibo;

-(void)dealloc
{
    delegate=nil;
    [wbapi release];
    [super dealloc];
}

+ (TCWeiboApi *)shared
{
    if (tcweibo == nil) {
        tcweibo = [[TCWeiboApi alloc] init];
    }
    return tcweibo;
}

- (id)init
{
    if (self=[super init]) {
        self->wbapi = [[WeiboApi alloc]initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUri:REDIRECTURI andAuthModeFlag:0 andCachePolicy:0] ;
    }
    return self;
}

//点击登录按钮
- (void)onLogin:(UIViewController*)ctr
{
    [wbapi loginWithDelegate:self andRootController:ctr];
}

- (void)onLogout
{
    // 注销授权
    [wbapi  cancelAuth];
    
    NSString *resStr = [[NSString alloc]initWithFormat:@"取消授权成功！"];
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:resStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [self showMsg:resStr];
    [resStr release];
}

//获取token有效性
- (void)onExtend
{
    [wbapi checkAuthValid:TCWBAuthCheckServer andDelegete:self];
}

//获取主时间线
- (void)onGetHometimeline
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                   @"0", @"pageflag",
                                   @"30", @"reqnum",
                                   @"0", @"type",
                                   @"0", @"contenttype",
                                   nil];
    [wbapi requestWithParams:params apiName:@"statuses/home_timeline" httpMethod:@"GET" delegate:self];
    [params release];
}

//发表带图微博
-(void)txweiboimageContent:(UIImage *)image title:(NSString *)title
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                   title, @"content",
                                   image, @"pic",
                                   nil];
    [wbapi requestWithParams:params apiName:@"t/add_pic" httpMethod:@"POST" delegate:self];
    [params release];
}

- (void)showMsg:(NSString *)msg
{
    NSLog(@"%@",msg);
}

#pragma mark WeiboRequestDelegate

/**
 * @brief   接口调用成功后的回调
 * @param   INPUT   data    接口返回的数据
 * @param   INPUT   request 发起请求时的请求对象，可以用来管理异步请求
 * @return  无返回
 */
- (void)didReceiveRawData:(NSData *)data reqNo:(int)reqno
{
    NSString *strResult = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:strResult];
    });
    
    [strResult release];
    
    [delegate sharesuccessful:@"TX"];
}

/**
 * @brief   接口调用失败后的回调
 * @param   INPUT   error   接口返回的错误信息
 * @param   INPUT   request 发起请求时的请求对象，可以用来管理异步请求
 * @return  无返回
 */
- (void)didFailWithError:(NSError *)error reqNo:(int)reqno
{
    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:str];
    });
    
    [str release];
    
    [delegate sharefailed:@"TX"];
}

#pragma mark WeiboAuthDelegate

/**
 * @brief   重刷授权成功后的回调
 * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
 * @return  无返回
 */
- (void)DidAuthRefreshed:(WeiboApiObject *)wbobj
{
    //UISwitch
    NSString *str = [[NSString alloc]initWithFormat:@"accesstoken = %@\r openid = %@\r appkey=%@ \r appsecret=%@\r",wbobj.accessToken, wbobj.openid, wbobj.appKey, wbobj.appSecret];
    
    NSLog(@"result = %@",str);
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:str];
    });
    
    [str release];
}

/**
 * @brief   重刷授权失败后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
- (void)DidAuthRefreshFail:(NSError *)error
{
    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:str];
    });
    
    [str release];
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
 * @return  无返回
 */
- (void)DidAuthFinished:(WeiboApiObject *)wbobj
{
    NSString *str = [[NSString alloc]initWithFormat:@"accesstoken = %@\r\n openid = %@\r\n appkey=%@ \r\n appsecret=%@ \r\n refreshtoken=%@ ", wbobj.accessToken, wbobj.openid, wbobj.appKey, wbobj.appSecret, wbobj.refreshToken];
    
    NSLog(@"result = %@",str);
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:str];
    });
    
    [str release];
    
    [delegate checkAuth:3];
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   wbapi   weiboapi 对象，取消授权后，授权信息会被清空
 * @return  无返回
 */
- (void)DidAuthCanceled:(WeiboApi *)wbapi_
{
    
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
- (void)DidAuthFailWithError:(NSError *)error
{
    NSString *str = [[NSString alloc] initWithFormat:@"get token error, errcode = %@",error.userInfo];
    
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:str];
    });
    
    [str release];
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
-(void)didCheckAuthValid:(BOOL)bResult suggest:(NSString *)strSuggestion
{
    NSString *str = [[NSString alloc] initWithFormat:@"ret=%d, suggestion = %@", bResult, strSuggestion];
    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showMsg:str];
    });
    
    [str release];
    
    if (bResult) {
        [delegate checkAuth:1];
    }
    else
    {
        [delegate checkAuth:2];
    }
}

@end
