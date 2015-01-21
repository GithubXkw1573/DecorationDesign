//
//  YXShareApi.m
//  YXShareApi
//
//  Created by 王浩 on 13-12-17.
//  Copyright (c) 2013年 王浩. All rights reserved.
//

#import "YXShareApi.h"

@implementation YXShareApi
@synthesize delegate;

static YXShareApi *yixin;

-(void)dealloc
{
    delegate=nil;
    [super dealloc];
}

+ (YXShareApi *)shared
{
    if (yixin == nil) {
        yixin = [[YXShareApi alloc] init];
    }
    return yixin;
}

- (id)init
{
    if (self=[super init]) {
        //向易信注册
        [YXApi registerApp:@"yx6e08ded209484e62a946408a2e9e9e59"];
    }
    return self;
}

- (BOOL)isYXAppInstalled
{
   return [YXApi isYXAppInstalled];
}

- (BOOL)isYXAppSupportApi
{
    return [YXApi isYXAppSupportApi];
}

- (BOOL)handleOpen:(NSURL *)url
{
   return [YXApi handleOpenURL:url delegate:self];
}

#pragma mark -
#pragma mark - YXApiDelegate method
- (void)onReceiveRequest: (YXBaseReq *)req
{
    
}

- (void)onReceiveResponse: (YXBaseResp *)resp {
    if([resp isKindOfClass:[SendMessageToYXResp class]])
    {
        SendMessageToYXResp *sendResp = (SendMessageToYXResp *)resp;
        
        if (sendResp.code ==0) {
            NSLog(@"成功");
            
            [delegate sharesuccessful:@"YX"];
        }
        else if (resp.code ==-2)
        {
            NSLog(@"失败");
            
            [delegate sharefailed:@"YX"];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送媒体消息结果" message:sendResp.errDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
}

#pragma mark -
#pragma mark - YXViewDelegate method
// 分享 纯文本信息
- (void)sendTextContent
{
    SendMessageToYXReq *req = [[SendMessageToYXReq alloc] init];
    req.bText = YES;
    req.text = @"http://img5.cache.netease.com/photo/ 童鞋，我想跟你说个事呀！童鞋，童鞋，我想跟你说个事呀！";
    req.scene = yxscene;
    
    [YXApi sendReq:req];
    [req release];
}

// 分享 图片Image
// [imageUrl | imageData] 参数不能同时为空
- (void)sendImageContent
{
    NSData *imageData = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image_3" ofType:@"jpg"];
    imageData = [NSData dataWithContentsOfFile:filePath];
    
    YXImageObject *imageObject = [YXImageObject object];
    imageObject.imageUrl = @"http://img5.cache.netease.com/photo/0001/2013-08-30/97IESEHO19BR0001.jpg";
    imageObject.imageData = imageData;  //[imageUrl | imageData] 参数不能同时为空
    
    YXMediaMessage *message = [YXMediaMessage message];
    //imageObject.imageData 为空时，thumbData 图片尺寸必须不小于200*200
    NSData *thumImageData = UIImageJPEGRepresentation([UIImage imageNamed:@"image_2.jpg"], 1.f);
    [message setThumbData:thumImageData];
    message.mediaObject = imageObject;
    
    SendMessageToYXReq *req = [[SendMessageToYXReq alloc] init];
    req.bText = NO;
    req.scene = yxscene;
    req.message = message;
    
    [YXApi sendReq:req];
    [req release];
//    BOOL result = [YXApi sendReq:req];// 返回校验结果
//    if(!result){
//         [self showAlert:@"数据校验有误，请重新检查后 分享"];
//    }
//    [req release];
}

// 分享 音乐music
// [musicUrl | musicDataUrl | musicLowBandDataUrl | musicLowBandUrl] 参数不能同时为空
- (void)sendMusicContent
{
    YXMusicObject *musicObject = [YXMusicObject object];
    musicObject.musicUrl = @"http://music.163.com/#/m/playlist?id=351643";
    musicObject.musicDataUrl = @"http://m1.music.126.net/9wQFXYxsK6RGXlNJCsYPHA==/2101166720692146.mp3";
    musicObject.musicLowBandDataUrl = @"http://m1.music.126.net/9wQFXYxsK6RGXlNJCsYPHA==/2101166720692146.mp3";//低音质 音乐链接，用于网络较差情况
    musicObject.musicLowBandUrl = @"http://music.163.com/#/m/playlist?id=351643";
    
    YXMediaMessage *message = [YXMediaMessage message];
    message.title = @"一曲民谣暖意生";
    message.description = @"欧美音乐频道";
    
    NSData *thumImageData = UIImageJPEGRepresentation([UIImage imageNamed:@"image_1.png"], 1.f);
    [message setThumbData:thumImageData];
    message.mediaObject = musicObject;
    
    SendMessageToYXReq *req = [[SendMessageToYXReq alloc] init];
    req.bText = NO;
    req.scene = yxscene;
    req.message = message;
    
    [YXApi sendReq:req];
    [req release];
//    BOOL result = [YXApi sendReq:req];// 返回校验结果
//    if(!result){
//        [self showAlert:@"数据校验有误，请重新检查后 分享"];
//    }
//    [req release];
}

// 分享 链接webPage
// [webpageUrl] 参数不能为空
- (void)sendWebPageContent:(NSString *)url imageContent:(UIImage *)image title:(NSString *)title detail:(NSString *)detail
{
    YXWebpageObject *pageObject = [YXWebpageObject object];
    pageObject.webpageUrl = url;
    
    YXMediaMessage *message = [YXMediaMessage message];
    message.title = title;
    message.description = detail;
    
    NSData *thumImageData = UIImageJPEGRepresentation(image, 1.f);
    [message setThumbData:thumImageData];
    message.mediaObject = pageObject;
    
    SendMessageToYXReq *req = [[SendMessageToYXReq alloc] init];
    req.bText = NO;
    req.scene = yxscene;
    req.message = message;
    
    [YXApi sendReq:req];
    [req release];
//    BOOL result = [YXApi sendReq:req];// 返回校验结果
//    if(!result){
//        [self showAlert:@"数据校验有误，请重新检查后 分享"];
//    }
//    [req release];
}

// 分享 视频video
// [videoLowBandUrl | videoUrl] 参数不能同时为空
- (void)sendVideoContent
{
    YXVideoObject *videoObject = [YXVideoObject object];
    videoObject.videoLowBandUrl =  @"http://218.59.144.96/mov.bn.netease.com/mobilev/2012/12/7/Q/S8I5E4D7Q.mp4?wsiphost=ipdbm";//低品质视频，用于网络较差情况
    videoObject.videoUrl = @"http://218.59.144.96/mov.bn.netease.com/mobilev/2012/12/7/Q/S8I5E4D7Q.mp4?wsiphost=ipdbm";
    
    YXMediaMessage *message = [YXMediaMessage message];
    message.title = @"斯坦福大学公开课：量子力学> 量子比特实验与狄拉克符号 ";
    message.description = @"http://218.59.144.96/课程简介：量子理论是描述宇宙的基本理论。20世纪前五十年，普朗克，爱因斯坦，玻尔，海森堡，薛定谔的发现改变了整个物理学。量子力学的新逻辑和新数学完全取代了经典物理。本课中我们会探索光的粒子理论，海森堡不确定原理，还有薛定谔方程";
    
    NSData *thumImageData = UIImageJPEGRepresentation([UIImage imageNamed:@"image_1.png"], 1.f);
    [message setThumbData:thumImageData];
    message.mediaObject = videoObject;
    
    SendMessageToYXReq *req = [[SendMessageToYXReq alloc] init];
    req.bText = NO;
    req.scene = yxscene;
    req.message = message;
    
    [YXApi sendReq:req];
    [req release];
//    BOOL result = [YXApi sendReq:req];// 返回校验结果
//    if(!result){
//        [self showAlert:@"数据校验有误，请重新检查后 分享"];
//    }
//    [req release];
}

// 第三方app信息
// 在易信app中 点击分享的内容， 跳转到 第三方app中显示 appExtend
// [url | extInfo | fileData] 参数不能同时为空
- (void)sendAppExtendContent
{
    YXAppExtendObject *extendObject = [YXAppExtendObject object];
    extendObject.url =  @"http://www.yue365.com/play/5194/302634.shtml";
    extendObject.extInfo = @"sdsdsd";
    extendObject.fileData =  nil;
    
    YXMediaMessage *message = [YXMediaMessage message];
    message.title = @"App信息";
    message.description = @"童鞋，我又想跟你说个事呀！童鞋，童鞋，我又想跟你说个事呀！";
    
    NSData *thumImageData = UIImageJPEGRepresentation([UIImage imageNamed:@"image_2.jpg"], 1.f);
    [message setThumbData:thumImageData];
    message.mediaObject = extendObject;
    
    SendMessageToYXReq *req = [[SendMessageToYXReq alloc] init];
    req.bText = NO;
    req.scene = yxscene;
    req.message = message;
    
    [YXApi sendReq:req];
    [req release];
//    BOOL result = [YXApi sendReq:req];// 返回校验结果
//    if(!result){
//        [self showAlert:@"数据校验有误，请重新检查后 分享"];
//    }
//    [req release];
}

- (void)showAlert: (NSString *)msg
{
    if(msg){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void)resetScene:(int)scene
{
    if (scene == 0) {
        yxscene = kYXSceneSession;
    } else{
        yxscene = kYXSceneTimeline;
    }
}

@end
