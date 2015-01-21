//
//  TypeButton.h
//  TGQ2
//
//  Created by 许开伟 on 14-8-21.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface TypeButton : UIButton
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *typeId;
@property (nonatomic,assign) BOOL selected;

- (id)initWithFrame:(CGRect)frame Title:(NSString*)cityName TypeId:(NSString*)typeId;
@end
