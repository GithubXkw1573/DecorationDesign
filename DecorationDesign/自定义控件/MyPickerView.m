//
//  MyPickerView.m
//  DecorationDesign
//
//  Created by 许开伟 on 15/1/30.
//  Copyright (c) 2015年 许开伟. All rights reserved.
//

#import "MyPickerView.h"

@implementation MyPickerView
@synthesize dataList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height-30)];
        picker.delegate = self;
        picker.dataSource = self;
        picker.showsSelectionIndicator = YES;
        [self addSubview:picker];
        myPick = picker;
        [picker release];
        //在弹出的键盘上面加一个view来放置退出键盘的Done按钮
        UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        [topView setBarStyle:UIBarStyleDefault];
        UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
        [btnSpace release];
        [doneButton release];
        [topView setItems:buttonsArray];
        [self addSubview:topView];
        [topView release];
    }
    return self;
}

-(void)dismissKeyBoard
{
    NSInteger row=[myPick selectedRowInComponent:0];
    if (self.selectItemAtIndex) {
        self.selectItemAtIndex(row);
    }
    [self hide];
}

-(void)show
{
    [myPick selectRow:2 inComponent:0 animated:YES];
    [UIView animateWithDuration:0.35f animations:^{
        CGRect oldframe = self.frame;
        self.frame = CGRectMake(oldframe.origin.x, oldframe.origin.y-self.frame.size.height, oldframe.size.width, oldframe.size.height);
    }];
}

-(void)hide
{
    [UIView animateWithDuration:0.35f animations:^{
        CGRect oldframe = self.frame;
        self.frame = CGRectMake(oldframe.origin.x, oldframe.origin.y+self.frame.size.height, oldframe.size.width, oldframe.size.height);
    }];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [dataList count];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = (UILabel*)view;
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = UITextAlignmentCenter;
        label.font = font(13);
        label.backgroundColor = [UIColor clearColor];
    }
    label.text = [dataList objectAtIndex:row%dataList.count];
    return label;
}

@end
