//
//  AdvertisingController.m
//  DecorationDesign
//
//  Created by 许开伟 on 15/2/2.
//  Copyright (c) 2015年 许开伟. All rights reserved.
//

#import "AdvertisingController.h"

@interface AdvertisingController ()

@end

@implementation AdvertisingController
@synthesize imagescrollView,viewControllers,guanggaoArray,productId,produceName,commentNum,m_array;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNaviTitle];
    
    [self initScrollView];
    
    [self initDescView];
    
    [self doWithData:m_array];
    [self reloadComponent];
    [self initBottomView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor=[UIColor blackColor];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_black_bg.png"] forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIImage *shadowimage=[[UIImage alloc]init];
    self.navigationController.navigationBar.shadowImage = shadowimage;//去掉navigationBar阴影黑线
    [shadowimage release];
}

-(void)initNaviTitle
{
    if (iOS7Later) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    titlelabel.backgroundColor=[UIColor clearColor];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=@"广告展示";
    titlelabel.textAlignment=UITextAlignmentCenter;
    titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.navigationItem.titleView=titlelabel;
    [titlelabel release];
    
    UIView *leftbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [leftbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame=CGRectMake(-10, 0, 60, 44);
    leftbtn.tag =2;
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(AdvertiingBackBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtnview addSubview:leftbtn];
    
    UIBarButtonItem *myleftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbtnview];
    self.navigationItem.leftBarButtonItem = myleftitem;
    [myleftitem release];
    [leftbtnview release];
    
    
    UIView *rightbtnview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightbtnview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame=CGRectMake(0, 0, 60, 44);
    rightbtn.tag = 3;
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"loup_4_btn.png"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(AdvertiingBackBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rightbtnview addSubview:rightbtn];
    
    UIBarButtonItem *myrightitem = [[UIBarButtonItem alloc] initWithCustomView:rightbtnview];
    self.navigationItem.rightBarButtonItem = myrightitem;
    [myrightitem release];
    [rightbtnview release];
}

-(void)loadData
{
    NSURL *url = [NSURL URLWithString:MineURL];
    HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
    request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"GET_ADVERTMENT",@"JUDGEMETHOD",self.plateType,@"PLATETYPE",@"A1",@"PLATECODE",@"1",@"PAGEMARK",@"0",@"GETTIMES", nil];
    [request setCompletionBlock:^(NSDictionary *result){
        if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
            //调用成功
            NSArray *list = [[result objectForKey:@"ADVERTLISTINFO"] objectAtIndex:0];
            [self doWithData:list];
            [self reloadComponent];
            [self initBottomView];
        }else {
            NSString *errrDesc = [result objectForKey:@"ERRORDESTRIPTION"];
            NSLog(@"%@",errrDesc);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errrDesc delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }];
    [request setFailedBlock:^{
        NSLog(@"网络错误");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }];
    [request startRequest];
}

-(void)doWithData:(NSArray*)list
{
    self.productId = [NSString stringWithFormat:@"%@",[list objectAtIndex:0]];
    self.produceName = [NSString stringWithFormat:@"%@",[list objectAtIndex:1]];
    self.commentNum = [NSString stringWithFormat:@"%@",[list objectAtIndex:5]];
    NSString *urlStings = [list objectAtIndex:3];
    NSString *textStrigs = [list objectAtIndex:4];
    NSArray *aArray = [urlStings componentsSeparatedByString:@"&::&"];
    NSArray *bArray = [textStrigs componentsSeparatedByString:@"&::&"];
    for (NSInteger i=0; i<aArray.count; i++) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[aArray objectAtIndex:i],@"imagename",[bArray objectAtIndex:i],@"desc", nil];
        [self.guanggaoArray addObject:dic];
    }
}

-(void)updateDescContent
{
    pageLabel.text = [NSString stringWithFormat:@"%li/%li",kNumberOfPages==0?kCurrentPage : kCurrentPage+1,kNumberOfPages];
    NSString *descString = [NSString stringWithFormat:@"         %@",[[guanggaoArray objectAtIndex:kCurrentPage] objectForKey:@"desc"]];
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:descString];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [descString length])];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [descString length])];
    [descTextView setAttributedText:attributedString1];
}

-(void)reloadComponent
{
    kNumberOfPages=[guanggaoArray count];
    kCurrentPage = 0;
    
    [self updateDescContent];
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < kNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
    
    for (int i=0; i<[viewControllers count]; i++) {
        UIView *controller = [viewControllers objectAtIndex:i];
        if ((NSNull *)controller == [NSNull null]) {
            
        }
        else
        {
            [controller removeFromSuperview];
            controller=nil;
        }
    }
    
    imagescrollView.contentSize = CGSizeMake(imagescrollView.frame.size.width * kNumberOfPages, imagescrollView.frame.size.height);
    
    if (kNumberOfPages>=2) {
        [imagescrollView scrollRectToVisible:CGRectMake(0, 0, applicationwidth, imagescrollView.frame.size.height) animated:YES];
        [self loadScrollViewWithPage:0];
        [self loadScrollViewWithPage:1];
    }
    else if(kNumberOfPages==1){
        [imagescrollView scrollRectToVisible:CGRectMake(0, 0, applicationwidth, imagescrollView.frame.size.height) animated:YES];
        [self loadScrollViewWithPage:0];
    }
}

-(void)initScrollView
{
    self.guanggaoArray = [NSMutableArray array];
    kNumberOfPages=[guanggaoArray count];
    kCurrentPage = 0;
    CGFloat imageHeight = 340-88;
    if (IS_IPHONE5) {
        imageHeight = 340;
    }
    UIScrollView *guanggaoscrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, imageHeight*widthRate)];
    guanggaoscrollView.backgroundColor=[UIColor clearColor];
    guanggaoscrollView.tag=1;
    self.imagescrollView=guanggaoscrollView;
    [self.view addSubview:guanggaoscrollView];
    [guanggaoscrollView release];
    guanggaoscrollView.bounces=NO;
    guanggaoscrollView.pagingEnabled = YES;
    guanggaoscrollView.showsHorizontalScrollIndicator = NO;
    guanggaoscrollView.showsVerticalScrollIndicator = NO;
    guanggaoscrollView.scrollsToTop = NO;
    guanggaoscrollView.delegate = self;
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < kNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
    
    for (int i=0; i<[viewControllers count]; i++) {
        UIView *controller = [viewControllers objectAtIndex:i];
        if ((NSNull *)controller == [NSNull null]) {
            
        }
        else
        {
            [controller removeFromSuperview];
            controller=nil;
        }
    }
    imagescrollView.contentSize = CGSizeMake(imagescrollView.frame.size.width * kNumberOfPages, imagescrollView.frame.size.height);
    
    if (kNumberOfPages>=2) {
        [imagescrollView scrollRectToVisible:CGRectMake(0, 0, applicationwidth, imagescrollView.frame.size.height) animated:YES];
        [self loadScrollViewWithPage:0];
        [self loadScrollViewWithPage:1];
    }
    else if(kNumberOfPages==1){
        [imagescrollView scrollRectToVisible:CGRectMake(0, 0, applicationwidth, imagescrollView.frame.size.height) animated:YES];
        [self loadScrollViewWithPage:0];
    }
}

-(void)initDescView
{
    UILabel *angelLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, imagescrollView.frame.size.height+15, 60, 30)];
    angelLabel.textAlignment = UITextAlignmentLeft;
    angelLabel.textColor = [UIColor whiteColor];
    angelLabel.font = font(18);
    angelLabel.backgroundColor = [UIColor clearColor];
    pageLabel = angelLabel;
    [self.view addSubview:angelLabel];
    [angelLabel release];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(8, imagescrollView.frame.size.height+15, applicationwidth-16, 95)];
    textView.backgroundColor = [UIColor clearColor];
    textView.font = font(13);
    textView.editable = NO;
    textView.textColor = [UIColor whiteColor];
    descTextView = textView;
    [self.view addSubview:textView];
    [textView release];
}

-(void)initBottomView
{
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, applicationheight-94, applicationwidth, 150)];
    commentView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:commentView];
    [commentView release];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, applicationwidth, .5)];
    line.image = [UIImage imageNamed:@"线"];
    [commentView addSubview:line];
    [line release];
    
    UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 220, 30)];
    inputField.placeholder = @" 我也说两句";
    [inputField setBackground:[UIImage imageNamed:@"PingLun_bg"]];
    inputField.font = font(15);
    textField = inputField;
    inputField.returnKeyType = UIReturnKeySend;
    inputField.delegate = self;
    [commentView addSubview:inputField];
    [inputField release];
    //在弹出的键盘上面加一个view来放置退出键盘的Done按钮
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    [btnSpace release];
    [doneButton release];
    [topView setItems:buttonsArray];
    [inputField setInputAccessoryView:topView];
    [topView release];
    
    UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 10, 60, 30)];
    [detailBtn setTitle:[NSString stringWithFormat:@"%@",commentNum] forState:UIControlStateNormal];
    [detailBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    detailBtn.backgroundColor = [UIColor clearColor];
    detailBtn.titleLabel.font = font(13);
    [detailBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [detailBtn setBackgroundImage:[UIImage imageNamed:@"pinglun_btn_bg_03"] forState:UIControlStateNormal];
    detailBtn.tag = 23;
    [detailBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:detailBtn];
    [detailBtn release];
}

-(void)startCommonrequest
{
    if ([UserInfo shared].m_isLogin) {
        NSURL *url = [NSURL URLWithString:MineURL];
        HessianFormDataRequest *request = [[[HessianFormDataRequest alloc] initWithURL:url] autorelease];
        request.postData = [NSDictionary dictionaryWithObjectsAndKeys:@"CUSTOM-COMMENTTEXT",@"JUDGEMETHOD",self.productId,@"ID",[UserInfo shared].m_Id,@"USERID",@"6666688888",@"COMMENTEDID",@"A",@"WORKSTYPE",textField.text,@"COMMENT",[UserInfo shared].m_session,@"SESSION", nil];
        [request setCompletionBlock:^(NSDictionary *result){
            if ([[result objectForKey:@"ERRORCODE"] isEqualToString:@"0000"]) {
                //调用成功
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评论成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                textField.text = @"";
            }else {
                NSString *errrDesc = [result objectForKey:@"ERRORDESTRIPTION"];
                NSLog(@"%@",errrDesc);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errrDesc delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
        }];
        [request setFailedBlock:^{
            NSLog(@"网络错误");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }];
        [request startRequest];
    }else{
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        [login release];
    }
}

-(void)buttonClicked:(UIButton*)btn
{
    if (btn.tag ==23){
        //评论页
        if ([UserInfo shared].m_isLogin) {
            CommentViewController *comment = [[CommentViewController alloc] init];
            comment.designerId = @"6666688888";
            comment.designerName = @"广告";
            comment.worksId = productId;
            comment.commentNums = commentNum;
            comment.worksDate = [[productId componentsSeparatedByString:@":"] objectAtIndex:1];
            comment.commentTitle = produceName;
            comment.worksType = @"A";
            [self.navigationController pushViewController:comment animated:YES];
            [comment release];
        }else{
            LoginViewController *login = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
            [login release];
        }
    }
}

-(void)AdvertiingBackBtnPressed:(UIButton*)sender
{
    if (sender.tag ==2) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }else if (sender.tag ==3){
        ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, applicationheight, applicationwidth, 220)];
        [self.view addSubview:shareView];
        [shareView show];
        [shareView release];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==1) {
        
        CGFloat pageWidth = imagescrollView.frame.size.width;
        int page2 = floor((imagescrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        kCurrentPage = page2;
        [self updateDescContent];
        [self loadScrollViewWithPage:page2 - 1];
        [self loadScrollViewWithPage:page2];
        [self loadScrollViewWithPage:page2 + 1];
    }
}

- (void)loadScrollViewWithPage:(NSInteger)page2 {
    if (page2 < 0) return;
    if (page2 >= kNumberOfPages) return;
    
    // replace the placeholder if necessary
    UIView *controller = [viewControllers objectAtIndex:page2];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[UIView alloc] init];
        
        UIImageView *mypageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, (imagescrollView.frame.size.height-160*widthRate)/2+20, applicationwidth, 160*widthRate)];
        NSLog(@"image:%@",[[guanggaoArray objectAtIndex:page2] objectForKey:@"imagename"]);
        [mypageview setImageWithURL:[NSURL URLWithString:[[guanggaoArray objectAtIndex:page2] objectForKey:@"imagename"]] placeholderImage:[UIImage imageNamed:@"首页切换图1.png"]];
        mypageview.tag = 33;
        mypageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [mypageview addGestureRecognizer:tap];
        [tap release];
        [controller addSubview:mypageview];
        [mypageview release];
        
        [viewControllers replaceObjectAtIndex:page2 withObject:controller];
        [controller release];
    }
    
    // add the controller's view to the scroll view
    if (nil == controller.superview) {
        CGRect frame = imagescrollView.frame;
        frame.origin.x = frame.size.width * page2;
        frame.origin.y = 0;
        controller.frame = frame;
        [imagescrollView addSubview:controller];
    }
}

-(void)tapClick:(UITapGestureRecognizer*)tap
{
    if (tap.view.tag == 33) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *currController = [viewControllers objectAtIndex:kCurrentPage];
        UIImageView *currImageView = (UIImageView*)[currController viewWithTag:33];
        ImageLooker *looker = [[ImageLooker alloc] initWithFrame:window.frame withImage:currImageView.image];
        [window addSubview:looker];
        looker.backgroundColor = [UIColor blackColor];
        
        looker.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.35f animations:^{
            looker.transform = CGAffineTransformMakeScale(1, 1);
        }];
        [looker release];
    }
}

-(void)buttonClicked3:(UIButton*)btn
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    ImageLooker *looker = [[ImageLooker alloc] initWithFrame:window.frame withImage:[UIImage imageNamed:[[guanggaoArray objectAtIndex:kCurrentPage] objectForKey:@"imagename"]]];
    [window addSubview:looker];
    looker.backgroundColor = [UIColor blackColor];
    
    looker.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.35f animations:^{
        looker.transform = CGAffineTransformMakeScale(1, 1);
    }];
    [looker release];
}

-(void)dismissKeyBoard
{
    [self.view endEditing:YES];
    [self movoTo:64];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([UserInfo shared].m_isLogin) {
        [self movoTo:-200];
        return YES;
    }else{
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        [login release];
        return NO;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)_textField
{
    //发送
    if (![textField.text isEqualToString:@""]) {
        [self startCommonrequest];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评论不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    [_textField resignFirstResponder];
    [self movoTo:64];
    return YES;
}

-(void)movoTo:(CGFloat)dh
{
    [UIView animateWithDuration:0.35f animations:^{
        self.view.frame = CGRectMake(0, dh, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
}

@end
