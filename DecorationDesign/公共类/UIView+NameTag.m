//
//  UIView+NameTag.m
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/30.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "UIView+NameTag.h"
#import <objc/runtime.h>

@implementation UIView (NameTag)

static const char nametag_Key;

-(id)nametag
{
    return objc_getAssociatedObject(self, (void*) &nametag_Key);
}

-(void)setNametag:(NSString*) theNametag
{
    objc_setAssociatedObject(self, (void*) &nametag_Key, theNametag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView*)viewWithNameTag:(NSString*)aName
{
    if (!aName) {
        return nil;
    }
    if ([self.nametag isEqualToString:aName]) {
        return self;
    }
    
    for(UIView *subview in self.subviews){
        UIView *resultView = [subview viewNamed:aName];
        if (resultView) {
            return resultView;
        }
    }
    return nil;
}

-(UIView*)viewNamed:(NSString *)aName
{
    if (!aName) {
        return nil;
    }
    return [self viewWithNameTag:aName];
}
@end
