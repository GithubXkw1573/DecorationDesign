//
//  Myprogress.h
//  Demo
//
//  Created by 元元 on 13-12-16.
//  Copyright (c) 2013年 元元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol MyprogressDelegate <NSObject>

- (void)DelegatecancleBtnPressed;
- (void)DelegaterequestBtnPressed;

@end

@interface Myprogress : UIView{
    UILabel *textLabel;
    UILabel *detailTextLabel;
    UIButton *canclebtn;
    UIButton *requestbtn;
    id<MyprogressDelegate> delegate;
}
@property(nonatomic,assign)id<MyprogressDelegate> delegate;
@property(nonatomic,retain)UIButton *requestbtn;
@property(nonatomic,retain)UIButton *canclebtn;
@property(nonatomic,retain)UILabel *detailTextLabel;
@property(nonatomic,retain)UILabel *textLabel;
-(void)settextLabel:(NSString *)titlestr detailTextLabel:(NSString *)detailstr;
-(void)cancleBtnPressed:(id)sender;
-(void)requestBtnPressed:(id)sender;
-(void)setmode:(int)mod;
@end
