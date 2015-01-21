//
//  QQkongjianApi.m
//  TGQ2
//
//  Created by 元元 on 14-9-28.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import "QQkongjianApi.h"

@implementation QQkongjianApi
@synthesize tencentOAuth;
@synthesize delegate;
@synthesize logindelegate;

static QQkongjianApi *QQkongjian;

-(void)dealloc
{
    logindelegate=nil;
    delegate=nil;
    [tencentOAuth release];
    [super dealloc];
}

+ (QQkongjianApi *)shared
{
    if (QQkongjian == nil) {
        QQkongjian = [[QQkongjianApi alloc] init];
    }
    return QQkongjian;
}

- (id)init
{
    if (self=[super init]) {
        //app注册，这里委托可以为空，因为新版分享空间已经不再需要手动授权验证登录了
        tencentOAuth=[[TencentOAuth alloc] initWithAppId:@"222222" andDelegate:self];
    }
    return self;
}

-(void)QQlogin
{
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            nil];
    
    [tencentOAuth authorize:permissions inSafari:NO];
}

-(void)kongjianLinkContent:(NSString *)url imageContent:(UIImage *)image title:(NSString *)title detail:(NSString *)detail
{
    //QQ空间分享
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:detail previewImageData:UIImagePNGRepresentation(image)];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
}

-(void)sessionLinkContent:(NSString *)url imageContent:(UIImage *)image title:(NSString *)title detail:(NSString *)detail
{
    //QQ好友分享
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:detail previewImageData:UIImagePNGRepresentation(image)];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}

-(BOOL)handleOpen:(NSURL *)url
{
    [QQApiInterface handleOpenURL:url delegate:self];//用于QQ分享指定页面的回调触发
    return [TencentOAuth HandleOpenURL:url];
}

#pragma mark - QQApiInterfaceDelegate
-(void)onReq:(QQBaseReq *)req
{
    switch (req.type)
    {
        case EGETMESSAGEFROMQQREQTYPE:
        {
            break;
        }
        default:
        {
            break;
        }
    }
}

-(void)onResp:(QQBaseResp *)resp
{
    switch (resp.type)
    {
        case ESENDMESSAGETOQQRESPTYPE:
        {
            SendMessageToQQResp* sendResp = (SendMessageToQQResp*)resp;
            if ([sendResp.result isEqualToString:@"0"]) {
                [delegate sharesuccessful:@"kongjian"];
            }
            else
            {
                if (![sendResp.result isEqualToString:@"-4"]) {
                    [delegate sharefailed:@"kongjian"];
                }
            }
            break;
        }
        default:
        {
            break;
        }
    }
}

-(void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQZONENOTSUPPORTTEXT:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"空间分享不支持纯文本分享，请使用图文分享" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQZONENOTSUPPORTIMAGE:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"空间分享不支持纯图片分享，请使用图文分享" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response
{
    NSLog(@"isOnlineResponse");
}

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin
{
    NSLog(@"tencentDidLogin:%@",tencentOAuth.openId);
    
    if (![tencentOAuth getUserInfo]) {
        [logindelegate loginfailed:@"QQlogin"];
    }
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"tencentDidNotLogin");
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork
{
    NSLog(@"tencentDidNotNetWork");
    
    [logindelegate loginfailed:@"QQlogin"];
}

- (void)getUserInfoResponse:(APIResponse*) response
{
    NSLog(@"response:%@",[response jsonResponse]);
    
    [logindelegate loginsuccessful:@"QQlogin" OAuth:tencentOAuth userinfo:[response jsonResponse]];
}

@end
