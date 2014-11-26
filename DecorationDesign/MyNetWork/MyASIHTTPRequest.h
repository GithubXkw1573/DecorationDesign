//
//  MyASIHTTPRequest.h
//  Demo
//
//  Created by 元元 on 13-12-16.
//  Copyright (c) 2013年 元元. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@interface MyASIHTTPRequest : ASIFormDataRequest{
    NSString *reqType;
}
@property(nonatomic,retain)NSString *reqType;
-(void)setPostValue:(NSDictionary *)postvalue;
@end
