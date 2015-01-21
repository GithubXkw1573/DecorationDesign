//
//  BookingController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/11/24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface BookingController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    UITableView *m_tableView;
    MBProgressHUD *MBProgress;
    UIImageView *backImageView;
}
@property(nonatomic, retain)MBProgressHUD *MBProgress;
@end
