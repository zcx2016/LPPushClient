//
//  LPPBuyNowVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/15.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPBuyNowVC.h"
#import "LPPWriteOrderAddressCell.h"
#import "LPPWriteOrderCommodityCell.h"
#import "LPPWriteOrderBottomView.h"
#import "LPPPayMethodFooterView.h"
#import "LPPWriteOrderAddressModel.h"
#import "LPPSuccessPayVC.h"

#import "LPPBuyNowOrderCell.h"
#import "LPPBuyNowOutCell.h"

@interface LPPBuyNowVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPPWriteOrderBottomView *writeOrderBottomView;

@property (nonatomic, strong) UIView *barView;

@property (nonatomic, strong) NSArray *orderArr;

@property (nonatomic, copy) NSString  *addarea;
@property (nonatomic, copy) NSString  *addareaInfo;
@property (nonatomic, copy) NSString  *addrName;
@property (nonatomic, copy) NSString  *addrPhone;
@property (nonatomic, copy) NSString  *addressId;
@end

@implementation LPPBuyNowVC

- (void)viewWillAppear:(BOOL)animated{
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //加载数据
    [self loadOrderData];
}

- (void)viewWillDisappear:(BOOL)animated{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //立即购买
    self.navigationItem.title = @"填写订单";
    self.orderArr = [NSArray array];
    
    self.barView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 20)];
    self.barView.backgroundColor = ZCXColor(225, 61, 38);
    [self.navigationController.navigationBar addSubview:self.barView];
    
    [self tableView];
    [self writeOrderBottomView];
    

}

- (void)loadOrderData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSString *token = [ZcxUserDefauts objectForKey:@"token"];
    
    NSDictionary *dict = @{@"user_id" : user_id , @"token" : token , @"goods_id" : self.goods_id , @"count" : @"1" ,@"price" : self.price , @"gsp" : self.gsp};
    NSLog(@"DICT----%@",dict);
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/goods_cart0.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"-立即购买---%@",responseObject);
        NSString *str = responseObject[@"addressMsg"];
        if (str.length != 0) {
            [SVProgressHUD showInfoWithStatus:@"请完善订单地址信息"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }else{
            self.addarea = responseObject[@"addarea"];
            self.addareaInfo = responseObject[@"addareaInfo"];
            self.addrName = responseObject[@"addrName"];
            self.addrPhone = responseObject[@"addrPhone"];
            //地址id保存下来，立即支付时使用
            self.addressId = responseObject[@"addressId"];
        }
        
        self.orderArr = responseObject[@"goods_map_list"];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

- (LPPWriteOrderBottomView *)writeOrderBottomView{
    if (!_writeOrderBottomView) {
        _writeOrderBottomView = [[NSBundle mainBundle] loadNibNamed:@"LPPWriteOrderBottomView" owner:nil options:nil].lastObject;
        [_writeOrderBottomView.payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_writeOrderBottomView];
        [_writeOrderBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view).with.offset(0);
            make.height.equalTo(@50);
        }];
    }
    return _writeOrderBottomView;
}

- (void)payBtnClick:(UIButton *)btn{
    
    LPPSuccessPayVC *vc = [LPPSuccessPayVC new];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LPPWriteOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPWriteOrderAddressCell" forIndexPath:indexPath];
        cell.receiverLabel.text = self.addrName;
        cell.phoneNumLabel.text = self.addrPhone;
        cell.addressLabel.text = [self.addarea stringByAppendingString:self.addareaInfo];
        
        return cell;
    }else{
        LPPBuyNowOutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPBuyNowOutCell" forIndexPath:indexPath];
        NSString *str = [NSString stringWithFormat:@"%ld" ,self.orderArr.count];
        cell.dataSource = self.orderArr;
        cell.AllCountLabel.text = [str stringByAppendingString:@"件商品"];
        return cell;
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 90;
    }else{
        CGFloat h = self.orderArr.count * 150+30;
        return h;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    return 300;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return [[UIView alloc] init];
    }else{
        LPPPayMethodFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LPPPayMethodFooterView"];
        if (!footView) {
            footView = [[LPPPayMethodFooterView alloc] initWithReuseIdentifier:@"LPPPayMethodFooterView"];
        }
        return footView;
    }
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-50) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //设置tableView背景图片
        NSString *path = [[NSBundle mainBundle]pathForResource:@"writeOrder_bg"ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        _tableView.layer.contents = (id)image.CGImage;
        
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPWriteOrderAddressCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPWriteOrderAddressCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPBuyNowOutCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPBuyNowOutCell"];
        //注册footView
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPPayMethodFooterView class]) bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"LPPPayMethodFooterView"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UIColor *color= ZCXColor(225, 61, 38);
    CGFloat offset=scrollView.contentOffset.y;
    
    if (offset<0) {
        
        self.navigationController.navigationBar.backgroundColor = [color colorWithAlphaComponent:0];
        self.barView.backgroundColor = [color colorWithAlphaComponent:0];
    }else {
        CGFloat alpha=1-((64-offset)/64);
        self.navigationController.navigationBar.backgroundColor=[color colorWithAlphaComponent:alpha];
        self.barView.backgroundColor = [color colorWithAlphaComponent:alpha];
    }
}
@end
