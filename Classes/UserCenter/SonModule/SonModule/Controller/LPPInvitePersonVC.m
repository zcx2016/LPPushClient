//
//  LPPInvitePersonVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/7.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPInvitePersonVC.h"
#import "LPPCommonTBCell.h"

@interface LPPInvitePersonVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString  *inviteCode;
@property (nonatomic, copy) NSString  *inviteName;
@property (nonatomic, copy) NSString  *invitePhone;
@end

@implementation LPPInvitePersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"入住资料";
    [self tableView];
    
    [self.navigationController.navigationBar setBackgroundImage:
     [UIImage imageNamed:@"writeOrder_bg"] forBarMetrics:UIBarMetricsDefault];
    
    [self loadData];
}

- (void)loadData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSDictionary *dict = @{@"user_id" : user_id};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/buyer/data.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.inviteCode = responseObject[@"invitationCode"];
        self.inviteName = responseObject[@"userName"];
        self.invitePhone = responseObject[@"jobNumber"];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
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
    cell.diyIndicatorBtn.hidden = YES;
    cell.diyDetailLabelTrailingConstraint.constant = 15;
    cell.diyTitleLabel.textColor = [UIColor blackColor];
    cell.diyDetailLabel.textColor = [UIColor lightGrayColor];
    if (indexPath.row == 0) {
        cell.diyTitleLabel.text = @"邀请码";
        cell.diyDetailLabel.text = self.inviteCode;
    }else if (indexPath.row == 1){
        cell.diyTitleLabel.text = @"邀请人姓名";
        cell.diyDetailLabel.text = self.inviteName;
    }else{
        cell.diyTitleLabel.text = @"邀请人联系方式";
        cell.diyDetailLabel.text = self.invitePhone;
    }
    
    return cell;
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCommonTBCell class]) bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"LPPCommonTBCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
