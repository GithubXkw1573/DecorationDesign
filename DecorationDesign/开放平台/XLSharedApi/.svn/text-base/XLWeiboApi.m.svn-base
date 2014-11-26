//
//  XLWeiboApi.m
//  QSQ2
//
//  Created by 王浩 on 14-3-28.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "XLWeiboApi.h"

@implementation XLWeiboApi
@synthesize m_type;
@synthesize m_title;
@synthesize m_image;
@synthesize delegate;
@synthesize logindelegate;

static XLWeiboApi *xlweibo;

-(void)dealloc
{
    logindelegate=nil;
    delegate=nil;
    [m_type release];
    [m_title release];
    [m_image release];
    [super dealloc];
}

+ (XLWeiboApi *)shared
{
    if (xlweibo == nil) {
        xlweibo = [[XLWeiboApi alloc] init];
    }
    return xlweibo;
}

- (id)init
{
    if (self=[super init]) {
        //新浪微博
        [WeiboSDK enableDebugMode:YES];
        [WeiboSDK registerApp:@"3197533337"];
    }
    return self;
}

- (BOOL)handleOpen:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)ssoButtonPressed
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"https://api.weibo.com/oauth2/default.html";
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)ssoOutButtonPressed
{
    
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = @"收到网络回调";
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",result]
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = @"请求异常";
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark -
#pragma mark - 新浪
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSLog(@"didReceiveWeiboResponse");
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSLog(@"WBSendMessageToWeiboResponse");
        
//        NSString *title = @"发送结果";
//        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        [alert release];
        
        if ((int)response.statusCode==0) {
            [delegate sharesuccessful:@"XL"];
        }
        else
        {
            [delegate sharefailed:@"XL"];
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSLog(@"WBAuthorizeResponse");
        
//        NSString *title = @"认证结果";
//        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//
////        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
//
//        [alert show];
//        [alert release];
        
        NSLog(@"tencentDidLogin%@",[(WBAuthorizeResponse *)response accessToken]);
        
        if ((int)response.statusCode==0) {
            NSString *url_str=[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?uid=%@&access_token=%@",[(WBAuthorizeResponse *)response userID],[(WBAuthorizeResponse *)response accessToken]];
            NSURL *url=[NSURL URLWithString:[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            ASIFormDataRequest *request=[[[ASIFormDataRequest alloc] initWithURL:url] autorelease];
            
            request.timeOutSeconds=ktimeOutSeconds;
            [request setCompletionBlock:^{
                NSDictionary *dic=[[request responseString] JSONValue];
                if (dic) {
                    NSLog(@"requestFinished:%@",dic);
                    
                    [logindelegate loginsuccessful:@"XLlogin" OAuth:response userinfo:dic];
                }
                else
                {
                    NSLog(@"json解析错误!");
                    
                    [logindelegate loginfailed:@"XLlogin"];
                }
            }];
            [request setFailedBlock:^{
                NSLog(@"requestFailed");
                
                [logindelegate loginfailed:@"XLlogin"];
            }];
            [request startAsynchronous];
        }
        else
        {
            [logindelegate loginfailed:@"XLlogin"];
        }
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    NSLog(@"didReceiveWeiboRequest");
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
        NSLog(@"WBProvideMessageForWeiboRequest");
    }
}

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    if ([m_type isEqual:@"1"])
    {
        message.text = m_title;
    }
    
    if ([m_type isEqual:@"2"])
    {
        message.text = m_title;
        
        WBImageObject *image = [WBImageObject object];
        image.imageData = UIImageJPEGRepresentation(m_image, 1.0);
        message.imageObject = image;
    }
    
    if ([m_type isEqual:@"3"])
    {
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = @"分享网页标题";
        webpage.description = [NSString stringWithFormat:@"分享网页内容简介-%.0f", [[NSDate date] timeIntervalSince1970]];
        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
        webpage.webpageUrl = @"http://sina.cn?a=1";
        message.mediaObject = webpage;
    }
    
    return message;
}

//直接发送
- (void)shareButtonPressed
{
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

@end
