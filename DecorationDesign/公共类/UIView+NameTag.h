//
//  UIView+NameTag.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/30.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NameTag)
-(void)setNametag:(NSString*) theNametag;
-(UIView*)viewWithNameTag:(NSString*)aName;
@end
