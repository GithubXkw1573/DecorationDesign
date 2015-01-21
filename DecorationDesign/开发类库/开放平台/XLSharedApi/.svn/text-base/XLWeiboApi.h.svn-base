//
//  XLWeiboApi.h
//  QSQ2
//
//  Created by 王浩 on 14-3-28.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#import "common.h"

@protocol xinlangdelegate

-(void)sharesuccessful:(NSString *)str;
-(void)sharefailed:(NSString *)str;

@end

@protocol xllogindelegate

-(void)loginsuccessful:(NSString *)str OAuth:(id)OAuth userinfo:(NSDictionary *)dic;
-(void)loginfailed:(NSString *)str;

@end

@interface XLWeiboApi : NSObject<WBHttpRequestDelegate,WeiboSDKDelegate>{
    NSString *m_type;
    NSString *m_title;
    UIImage *m_image;
    id<xinlangdelegate>delegate;
    id<xllogindelegate>logindelegate;
}
@property(assign,nonatomic)id<xinlangdelegate>delegate;
@property(assign,nonatomic)id<xllogindelegate>logindelegate;
@property(nonatomic,retain)NSString *m_type;
@property(nonatomic,retain)NSString *m_title;
@property(nonatomic,retain)UIImage *m_image;
+(XLWeiboApi *)shared;
-(void)ssoButtonPressed;
-(void)shareButtonPressed;
-(BOOL)handleOpen:(NSURL *)url;
@end
