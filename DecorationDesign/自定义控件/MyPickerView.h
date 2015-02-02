//
//  MyPickerView.h
//  DecorationDesign
//
//  Created by 许开伟 on 15/1/30.
//  Copyright (c) 2015年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *myPick;
}
@property (nonatomic,retain) NSArray *dataList;
@property (nonatomic, copy) void (^selectItemAtIndex)(NSInteger index);
-(void)show;
@end
