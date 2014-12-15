//
//  ShareView.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/11.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView
@synthesize shareDesc,shareImageUrl,shareTitle,shareUrl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        ShareItem *shoucang = [[ShareItem alloc] initWithFrame:CGRectMake(10*widthRate, 10*widthRate, 90*widthRate, 90*widthRate) withIamge:@"Fenxiang_xinlang" withText:@"新浪微博"];
        shoucang.tag = 11;
        [shoucang addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shoucang];
        [shoucang release];
        
        ShareItem *weixinquan = [[ShareItem alloc] initWithFrame:CGRectMake(115*widthRate, 10*widthRate, 90*widthRate, 90*widthRate) withIamge:@"Fenxiang_weixin" withText:@"微信"];
        weixinquan.tag = 12;
        [weixinquan addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:weixinquan];
        [weixinquan release];
        
        ShareItem *weixinfriend = [[ShareItem alloc] initWithFrame:CGRectMake(220*widthRate, 10, 90*widthRate, 90*widthRate) withIamge:@"Fenxiang_pyq" withText:@"微信朋友圈"];
        weixinfriend.tag = 13;
        [weixinfriend addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:weixinfriend];
        [weixinfriend release];
        
        ShareItem *qq = [[ShareItem alloc] initWithFrame:CGRectMake(10*widthRate, 110*widthRate, 90*widthRate, 90*widthRate) withIamge:@"Fenxiang_QQ" withText:@"QQ"];
        qq.tag = 14;
        [qq addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:qq];
        [qq release];
        
        ShareItem *qqzone = [[ShareItem alloc] initWithFrame:CGRectMake(115*widthRate, 110*widthRate, 90*widthRate, 90*widthRate) withIamge:@"Fenxiang_QQkj" withText:@"QQ空间"];
        qqzone.tag = 15;
        [qqzone addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:qqzone];
        [qqzone release];
        
        ShareItem *sina = [[ShareItem alloc] initWithFrame:CGRectMake(220*widthRate, 110*widthRate, 90*widthRate, 90*widthRate) withIamge:@"腾讯微博" withText:@"腾讯微博"];
        sina.tag = 16;
        [sina addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sina];
        [sina release];
    }
    return self;
}

-(void)dismiss
{
    
    [UIView animateWithDuration:.35f animations:^{
        self.frame = CGRectMake(0, applicationheight+20, self.frame.size.width, self.frame.size.height);
    }completion:^(BOOL flag){
        [_handerView removeFromSuperview];
    }];
    
}
-(void)show
{
    self.handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_handerView setFrame:[UIScreen mainScreen].bounds];
    [_handerView setBackgroundColor:[UIColor clearColor]];
    [_handerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_handerView];
    
    [UIView animateWithDuration:.35f animations:^{
        self.frame = CGRectMake(0, applicationheight-self.frame.size.height+20, self.frame.size.width, self.frame.size.height);
        
    }];
    
}

-(void)buttonClicked:(UIButton*)btn
{
    //self.selectItemAtIndex(btn.tag-10);
    
    if (btn.tag == 11) {
        //新浪微博
        UIImage *image=[self downloadimage];
        
        [XLWeiboApi shared].m_type=@"2";
        [XLWeiboApi shared].m_title=[NSString stringWithFormat:@"%@%@",self.shareTitle,self.shareUrl];
        [XLWeiboApi shared].m_image=image;
        [XLWeiboApi shared].delegate = self;
        [[XLWeiboApi shared] shareButtonPressed];
    }else if (btn.tag == 12){
        //微信会话
        UIImage *image=[self downloadimage];
        
        if ([[WXShareApi shared] isWXAppInstalled]) {
            [[WXShareApi shared] changeScene:WXSceneSession];
            [WXShareApi shared].delegate = self;
            [[WXShareApi shared] sendLinkContent:self.shareUrl imageContent:image title:self.shareTitle detail:self.shareDesc];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请先下载微信客户端" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
            [alert show];
            [alert release];
        }
    }else if (btn.tag == 13){
        //微信朋友圈
        UIImage *image=[self downloadimage];
        
        if ([[WXShareApi shared] isWXAppInstalled]) {
            [[WXShareApi shared] changeScene:WXSceneTimeline];
            [WXShareApi shared].delegate = self;
            [[WXShareApi shared] sendLinkContent:self.shareUrl imageContent:image title:self.shareTitle detail:self.shareDesc];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请先下载微信客户端" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
            [alert show];
            [alert release];
        }
    }else if (btn.tag == 14){
        //QQ好友
        UIImage *image=[self downloadimage];
        [QQkongjianApi shared].delegate = self;
        [[QQkongjianApi shared] sessionLinkContent:self.shareUrl imageContent:image title:self.shareTitle detail:self.shareDesc];
    }else if (btn.tag == 15){
        //QQ空间
        UIImage *image=[self downloadimage];
        [QQkongjianApi shared].delegate = self;
        [[QQkongjianApi shared] kongjianLinkContent:self.shareUrl imageContent:image title:self.shareTitle detail:self.shareDesc];
    }else if (btn.tag == 16){
        //腾讯微博
        [TCWeiboApi shared].delegate = self;
        [[TCWeiboApi shared] onExtend];
    }else if (btn.tag == 17){
        //易信会话
        UIImage *image=[self downloadimage];
        
        if ([[YXShareApi shared] isYXAppInstalled]) {
            [[YXShareApi shared] resetScene:kYXSceneSession];
            [YXShareApi shared].delegate = self;
            [[YXShareApi shared] sendWebPageContent:self.shareUrl imageContent:image title:self.shareTitle detail:self.shareDesc];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请先下载易信客户端" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
            [alert show];
            [alert release];
        }
    }else if (btn.tag == 18){
        //易信朋友圈
        UIImage *image=[self downloadimage];
        
        if ([[YXShareApi shared] isYXAppInstalled]) {
            [[YXShareApi shared] resetScene:kYXSceneTimeline];
            [YXShareApi shared].delegate = self;
            [[YXShareApi shared] sendWebPageContent:self.shareUrl imageContent:image title:self.shareTitle detail:self.shareDesc];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请先下载易信客户端" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
            [alert show];
            [alert release];
        }
    }else if (btn.tag == 19){
        //短信
        if ([MFMessageComposeViewController canSendText]) {
            [self sendSMS:[NSString stringWithFormat:@"%@%@",self.shareTitle,self.shareUrl] recipientList:nil];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                            message:@"该设备不支持短信功能"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            
            [alert show];
            [alert release];
        }
    }
    [self dismiss];
}

- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        
        //[self presentModalViewController:controller animated:YES];
    }
}

// 处理发送完的响应结果
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    //[self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled){
        NSLog(@"Message cancelled");
    }
    else if (result == MessageComposeResultSent)
    {
        NSLog(@"Message sent");
    }
    else
    {
        NSLog(@"Message failed");
    }
}

-(UIImage *)downloadimage
{
    UIImage *image;
    if ([self.shareImageUrl isEqualToString:@""])
    {
        int value = arc4random()%8;
        image=[UIImage imageNamed:[NSString stringWithFormat:@"ic_default_thumb%i.png",value]];
    }
    else
    {
        NSURL *url=[NSURL URLWithString:[self.shareImageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSData *imagedata =[NSData dataWithContentsOfURL:url];
        image=[UIImage imageWithData:imagedata];
        
        NSData *imagedaxiao=UIImageJPEGRepresentation(image, 1.0);
        
        NSLog(@"%i",[imagedaxiao length]);
        if (!image||[imagedaxiao length]>30*1024) {
            int value = arc4random()%8;
            image=[UIImage imageNamed:[NSString stringWithFormat:@"ic_default_thumb%i.png",value]];
        }
    }
    
    return image;
}

-(void)sharesuccessful:(NSString *)str
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"分享成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
    alert.tag=1;
    [alert show];
    [alert release];
}

-(void)sharefailed:(NSString *)str
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"分享失败!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void)checkAuth:(int)ret
{
    if (ret==1) {
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否使用已经绑定的微博帐号!" delegate:self cancelButtonTitle:@"解绑" otherButtonTitles:@"使用", nil];
        alert.tag=3;
        [alert show];
        [alert release];
    }
    else if(ret==2)
    {
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"需要绑定腾讯微博!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag=2;
        [alert show];
        [alert release];
    }
    else if(ret==3)
    {
        UIImage *image=[self downloadimage];
        
        [[TCWeiboApi shared] txweiboimageContent:image title:[NSString stringWithFormat:@"%@%@",self.shareTitle,self.shareUrl]];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            if (buttonIndex==1) {
                [[TCWeiboApi shared] onLogin:nil];
                
                //[[TCWeiboApi shared]onLogout];
            }
        }
            break;
        case 3:
        {
            if (buttonIndex==0) {
                [[TCWeiboApi shared]onLogout];
            }
            else if(buttonIndex==1)
            {
                UIImage *image=[self downloadimage];
                
                [[TCWeiboApi shared] txweiboimageContent:image title:[NSString stringWithFormat:@"%@%@",self.shareTitle,self.shareUrl]];
            }
        }
            break;
        default:
            break;
    }
}

-(NSString*)shareUrl
{
    if (shareUrl==nil || [shareUrl isEqualToString:@""]) {
        return @"http://www.baidu.com";
    }else{
        return  shareUrl;
    }
}

-(NSString*)shareTitle
{
    if (shareTitle==nil || [shareTitle isEqualToString:@""]) {
        return @"许开伟分享测试";
    }else{
        return  shareTitle;
    }
}

-(NSString*)shareDesc
{
    if (shareDesc==nil || [shareDesc isEqualToString:@""]) {
        return @"秋天，是季节平衡的一种需要，比如海涅的诗歌...";
    }else{
        return  shareDesc;
    }
}
@end
