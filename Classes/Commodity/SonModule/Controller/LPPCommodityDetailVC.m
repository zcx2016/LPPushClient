//
//  LPPCommodityDetailVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/7.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPCommodityDetailVC.h"
#import "LPPCDTopImgViewCell.h"
#import "LPPCDPriceNameCell.h"
#import "LPPCDCommodityStyleCell.h"
#import "LPPCDComparePriceCell.h"
#import "LPPCDCommodityInfoCell.h"
#import "LPPCDImgIntroductCell.h"
#import "LPPCommodityDetailBottomView.h"

#import "ZCXActionSheetView.h"

@interface LPPCommodityDetailVC ()<UITableViewDataSource,UITableViewDelegate,LPPCDImgIntroductCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LPPCommodityDetailBottomView *bottomView;

//数据源数据
@property (nonatomic, copy) NSString  *currentPrice;
@property (nonatomic, copy) NSString  *oldPrice;
@property (nonatomic, copy) NSString  *goodsName;
//库存
@property (nonatomic, strong) NSNumber  *inventory;

@property (nonatomic, strong) NSArray *colorListArr;
@property (nonatomic, strong) NSArray *sizeListArr;
@property (nonatomic, copy) NSString  *goodsID;
@property (nonatomic, copy) NSString  *webStr;

@property (nonatomic, assign) CGFloat webHeight;

@property (nonatomic, copy) NSString  *colorID;
@property (nonatomic, copy) NSString  *sizeID;

@property (nonatomic, strong) NSArray *lunboImgArr;

@end

@implementation LPPCommodityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"商品详情";
    
    self.colorListArr = [NSArray array];
    self.sizeListArr = [NSArray array];
    self.lunboImgArr = [NSArray array];
    
    [self tableView];
    
    [self bottomView];
    
    //分享按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"sharePost"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    //商品详情
    [self loadData];
}

- (void)loadData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSString *token = [ZcxUserDefauts objectForKey:@"token"];
    NSDictionary *dict = @{@"user_id" : user_id, @"token" : token, @"id" : self.deliverID};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/goods.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"商品详情----%@",responseObject);
        //第一行
        self.goodsName = responseObject[@"goods_name"];
        self.currentPrice = responseObject[@"goods_current_price"];
        self.oldPrice = responseObject[@"goods_price"];
        self.inventory = responseObject[@"goods_inventory"];
        //商品id
        self.goodsID = responseObject[@"id"];
        //第二行
        self.colorListArr = responseObject[@"colorList"];
        //第三行
        self.sizeListArr = responseObject[@"sizeList"];
        //图文详情webView数据源
        self.webStr = responseObject[@"goods_detail"];
        
        //同时要记住第一个商品和规格
        self.colorID = self.colorListArr[0][@"colorid"];
        self.sizeID = self.sizeListArr[0][@"id"];

        //商品规格详情
        [self loadClassesData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@",error);
    }];
}

#pragma mark - 商品规格详情
- (void)loadClassesData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSString *token = [ZcxUserDefauts objectForKey:@"token"];
    NSString *gsp = [[self.colorID.description stringByAppendingString:@","] stringByAppendingString:self.sizeID.description];
    NSDictionary *dict = @{@"user_id" : user_id , @"token" : token , @"id" : self.goodsID , @"gsp" :gsp , @"colorId": self.colorID};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/load_goods_gsp.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"-规格---%@",responseObject);
        self.lunboImgArr = responseObject[@"allColor"];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

- (void)shareBtnClick:(UIButton *)btn{

    ZCXActionSheetView *sheet = [[ZCXActionSheetView alloc] initWithActionSheet];
    //放在最上层
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:sheet];
}

- (LPPCommodityDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"LPPCommodityDetailBottomView" owner:nil options:nil].lastObject;
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view).with.offset(0);
            make.height.equalTo(@50);
        }];
        
        //加入购物车
        [_bottomView.joinInShopCarBtn addTarget:self action:@selector(joinInShopCarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

#pragma mark - 加入购物车
- (void)joinInShopCarBtnClick{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSString *token = [ZcxUserDefauts objectForKey:@"token"];
    NSString *gsp = [[self.colorID.description stringByAppendingString:@","] stringByAppendingString:self.sizeID.description];
    NSDictionary *dict = @{@"user_id" : user_id , @"token" : token ,@"count":@"1", @"goods_id" :self.goodsID , @"gsp":gsp};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/add_goods_new_cart.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"code"] isEqualToNumber:@100]) {
            [SVProgressHUD showSuccessWithStatus:@"加入购物车成功！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row== 0) {
            LPPCDTopImgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDTopImgViewCell" forIndexPath:indexPath];
            cell.imgArray = self.lunboImgArr;
            return cell;
        }else if (indexPath.row == 1) {
            LPPCDPriceNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDPriceNameCell" forIndexPath:indexPath];
            cell.goodsNameLabel.text = self.goodsName;
            if (self.currentPrice.length !=0) {
                cell.currentPriceLabel.text = [@"￥" stringByAppendingString:self.currentPrice];
            }
            if (self.oldPrice.length!=0) {
                cell.oldPriceLabel.text =  [@"￥" stringByAppendingString:self.oldPrice];
            }
            if ([self.inventory stringValue].length !=0) {
                cell.storeLabel.text = [@"剩余数量:" stringByAppendingString:[self.inventory stringValue]];
            }
            return cell;
        }else if(indexPath.row == 2){
            LPPCDCommodityStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDCommodityStyleCell" forIndexPath:indexPath];
            cell.dataArray = self.colorListArr;
            return cell;
        }else{
            LPPCDComparePriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDComparePriceCell" forIndexPath:indexPath];
            cell.dataArray = self.sizeListArr;
            return cell;
        }
        
    }else if (indexPath.section == 1){
        LPPCDCommodityInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDCommodityInfoCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        LPPCDImgIntroductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPCDImgIntroductCell" forIndexPath:indexPath];
        cell.delegate = self;
//        cell.webStr = self.webStr;
        [cell.scrollToTopBtn addTarget:self action:@selector(scrollToTopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (void)returnWebViewHeight:(CGFloat)webHeight{
    self.webHeight = webHeight;
    [self.tableView reloadData];
}

#pragma mark - 按钮触发scrollToTop功能
- (void)scrollToTopBtnClick:(UIButton *)btn{
    [UIView animateWithDuration:0.5 animations:^{
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }];
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 250;
        }else if (indexPath.row == 1) {
            return 100;
        }else if (indexPath.row == 2){
            return 190;
        }else{
            return 180;
        }
    }else if (indexPath.section == 1){
        return 180;
    }else{
//        if (self.webHeight != 0) {
//            NSLog(@"self.webHeight--%f",self.webHeight);
//            return self.webHeight;
//        }else{
//            return 640;
//        }
        return 300;
//        return self.webHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    grayView.backgroundColor  = ZCXColor(241, 243, 247);
    return grayView;
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-50) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDTopImgViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDTopImgViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDPriceNameCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDPriceNameCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDCommodityStyleCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDCommodityStyleCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDComparePriceCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDComparePriceCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDCommodityInfoCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDCommodityInfoCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPCDImgIntroductCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPCDImgIntroductCell"];
        
        //设置tableView背景图片
        NSString *path = [[NSBundle mainBundle]pathForResource:@"writeOrder_bg"ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        self.view.layer.contents = (id)image.CGImage;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
