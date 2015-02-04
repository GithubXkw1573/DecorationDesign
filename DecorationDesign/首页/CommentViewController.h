//
//  CommentViewController.h
//  DecorationDesign
//
//  Created by 许开伟 on 14/12/16.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "CommentCell.h"
#import "ShareView.h"

@interface CommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *m_tableView;
    MBProgressHUD *MBProgress;
    NSArray *m_array;
    NSString *worksId;
    NSString *worksType;
    NSString *designerId;
    NSString *designerName;
    NSArray *m_jsonArr;
    NSMutableArray *n_jsonArr;
    NSString *lastcommentNums;
    NSString *commentTitle;
    UITextField *commentField;
    BOOL isCommented;
    UILabel *support1;
    UILabel *support2;
    UILabel *support3;
}
@property (nonatomic,retain) NSArray *m_array;
@property (nonatomic,retain) NSArray *m_jsonArr;
@property (nonatomic,retain) NSMutableArray *n_jsonArr;
@property (nonatomic,retain) NSString *worksId;//被评论的对象id
@property (nonatomic,retain) NSString *worksType;//被评论对象类型（Z 设计师作品；B设计师博文；z装饰公司作品；b装饰公司博文;L楼盘；C材料；A评论广告）
@property (nonatomic,retain) NSString *designerId;//被评论对象的作品人id（设计师/装饰公司/材料商/楼盘id）
@property (nonatomic,retain) NSString *designerName;//被评论对象的作品人名称（设计师/装饰公司/材料商/楼盘/广告（固定6666688888）名称）
@property (nonatomic,retain) NSString *commentTitle;//评论标题
@property (nonatomic,retain) NSString *commentNums;//评论数目
@property (nonatomic,retain) NSString *worksDate;//被评论对象创建日期
@end
