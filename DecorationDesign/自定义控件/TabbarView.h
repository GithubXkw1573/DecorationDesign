//
//  TabbarView.h
//  TGQ2
//
//  Created by 元元 on 14-7-16.
//  Copyright (c) 2014年 元元. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabbarViewDelegate <NSObject>

-(void)TabbarViewDelegateBtnPressed:(int)tag;

@end

@interface TabbarView : UIView{
    UIImageView *tabimage;
    UILabel *tablab;
    id<TabbarViewDelegate> delegate;
}
@property(nonatomic, assign)id<TabbarViewDelegate> delegate;
@property(nonatomic,retain)UIImageView *tabimage;
@property(nonatomic,retain)UILabel *tablab;
-(void)TabbarViewBtnPressed:(id)sender;
-(void)setselect:(BOOL)bol;
@end
