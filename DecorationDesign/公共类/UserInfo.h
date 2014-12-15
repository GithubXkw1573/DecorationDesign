//
//  UserInfo.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/9.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject{
    
}
@property (assign ,nonatomic)BOOL m_isLogin;
@property (assign ,nonatomic)BOOL m_isMember;
@property (retain ,nonatomic)NSString *m_UserName;
@property (retain ,nonatomic)NSString *m_PassWord;
@property (retain ,nonatomic)NSString *m_Id;
@property (retain ,nonatomic)NSString *m_nikeName;
@property (retain,nonatomic)NSString *m_plateType;

@property (retain,nonatomic) NSString *loc_city;
@property (retain,nonatomic) NSString *curr_city;
@property (retain,nonatomic) NSString *loc_qu;
@property (retain,nonatomic) NSString *loc_lat;
@property (retain,nonatomic) NSString *loc_lng;

+(UserInfo *)shared;
-(void)saveUserInfo;
-(void)removeUserInfo;

@end
