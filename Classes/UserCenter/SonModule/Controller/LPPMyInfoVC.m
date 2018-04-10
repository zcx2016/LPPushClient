//
//  LPPMyInfoVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/7.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPMyInfoVC.h"
#import "LPPSetFooterView.h"
#import "LPPCommonTBCell.h"
//跳转vc
#import "LPPChangePwdVC.h"
#import "LPPInvitePersonVC.h"
#import "LPPCompleteInfoVC.h"
#import "LPPLoginVC.h"
//弹窗view
#import "LPPChangeNickNameView.h"

@interface LPPMyInfoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSMutableAttributedString  *richTextStr;

@property (nonatomic, copy) NSString  *phoneNum;

@property (nonatomic, copy) NSString  *nickName;

@end

@implementation LPPMyInfoVC

- (void)viewWillAppear:(BOOL)animated{
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的资料";
    
    [self tableView];
    
    //邀请人 按钮
    UIButton *invitePersonBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [invitePersonBtn setImage:[UIImage imageNamed:@"myInfo_add"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:invitePersonBtn];
    [invitePersonBtn addTarget:self action:@selector(invitePersonEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    //调数据
    [self loadData];
    //修改昵称的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nickNameChangedNoti:) name:@"nickNameChanged" object:nil];
}

- (void)nickNameChangedNoti:(NSNotification *)noti{
    //修改完昵称，再调一次数据来刷新
    [self loadData];
}

- (void)loadData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSDictionary *dict = @{@"user_id" : user_id };
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/buyer/index_update_user.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"-我的资料---%@",responseObject);
        self.phoneNum = responseObject[@"tel"];
        self.nickName = responseObject[@"name"];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

- (void)invitePersonEvent:(UIButton *)btn{
    LPPInvitePersonVC *invitePersonVc = [LPPInvitePersonVC new];
    [self.navigationController pushViewController:invitePersonVc animated:YES];
}

- (void)changeNickName{
    LPPChangeNickNameView *popView = [[NSBundle mainBundle] loadNibNamed:@"LPPChangeNickNameView" owner:nil options:nil].firstObject;
    popView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    popView.nickNameTextField.text = self.nickName;
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:popView];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LPPCommonTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCommonTBCell" forIndexPath:indexPath];

    if (indexPath.row == 0) {
        cell.diyTitleLabel.text = @"登录账号";
        cell.diyDetailLabel.text = self.phoneNum;
        cell.diyDetailLabel.textColor = [UIColor darkGrayColor];
        cell.diyDetailLabelTrailingConstraint.constant = 15;
        cell.diyIndicatorBtn.hidden = YES;
    }else{
        if (indexPath.row == 1) {
            cell.diyTitleLabel.text = @"昵称";
            cell.diyDetailLabel.text = self.nickName;
        }else{
            cell.diyTitleLabel.text = @"修改密码";
            cell.diyDetailLabel.text = @"";
        }
    }
    return cell;
}

#pragma mark - cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 1){  //修改昵称
        [self changeNickName];
        
    }else if (indexPath.row == 2){  //修改密码
        LPPChangePwdVC *changePwdVc = [LPPChangePwdVC new];
        [self.navigationController pushViewController:changePwdVc animated:YES];
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200+64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200+64)];
    //设置背景图片
    NSString *path = [[NSBundle mainBundle]pathForResource:@"userCenter_bg"ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    view.layer.contents = (id)image.CGImage;
    //设置头像
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myInfoLogo"]];
    CGFloat x = (kScreenWidth - 100)/2;
    imageView.frame = CGRectMake(x, 50+64, 100, 100);
    [view addSubview:imageView];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LPPSetFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LPPSetFooterView"];
    if(!footerView){
        footerView = [[LPPSetFooterView alloc] initWithReuseIdentifier:@"LPPSetFooterView"];
    }
    [footerView.quitLoginBtn addTarget:self action:@selector(quitLogin:) forControlEvents:UIControlEventTouchUpInside];
    return footerView;
}

- (void)quitLogin:(UIButton *)btn{
    LPPLoginVC *vc = [LPPLoginVC new];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight+64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCommonTBCell class]) bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"LPPCommonTBCell"];
        //注册footerView
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPSetFooterView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"LPPSetFooterView"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
