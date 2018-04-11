//
//  LPPCommodityVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/18.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import <ViewDeck.h>
#import "LPPCommodityVC.h"
#import "LPPActivityVC.h"
#import "LPPNewProductsVC.h"
#import "LPPLadyCommodityVC.h"
#import "LPPWriteOrderVC.h"
#import "LPPNavSearchView.h"
#import "LPPRecommendVC.h"

#import "ZCXActionSheetView.h"
#import "LPPCommodityDetailVC.h"
#import "LCCSearchVC.h"

//model

static int const labelWith = 70;

@interface LPPCommodityVC ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *titleScrollView;
@property(nonatomic,weak)UIScrollView *contentScrollView;

@property(nonatomic,weak)UILabel *seletLabel;
@property(nonatomic,strong)NSMutableArray *titleArray;

@property (nonatomic, strong) LPPNavSearchView *navSearchView;

@property(nonatomic,strong) UIButton *lineBtn;

@property (nonatomic, strong) NSArray *bannerDataSource;


@end

@implementation LPPCommodityVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //去除导航栏下面边界黑线
    self.navigationController.navigationBar.subviews[0].subviews[0].hidden = YES;
}

-(NSMutableArray *)titleArray{
    
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    0.设置页面scrollView;
    [self setScrollViewTopAndBottom];
    //1.添加所有子控制器
    [self setAllChildController];


    //2.添加所有子控制器对应标题
    [self setupTitleLabel];

    //3.初始化标题ScrollView
    [self setupScrollView];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //4.导航栏 搜索框
    [self navSearchView];

    //5.导航栏右侧 扩展 按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"extern"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(externEvents:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    //设置导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:
     [UIImage imageNamed:@"userCenter_bg"] forBarMetrics:UIBarMetricsDefault];
    
    [self loadBannerData];
}

- (void)loadBannerData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSDictionary *dict = @{@"port_name" : @"PUSHING" , @"user_id" : user_id};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/index_banner.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"banner--responseObject--%@",responseObject);
        self.bannerDataSource = responseObject[@"json_list"];

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"banner-error--%@",error);
    }];
}


- (LPPNavSearchView *)navSearchView{
    if (!_navSearchView) {
        _navSearchView = [[NSBundle mainBundle] loadNibNamed:@"LPPNavSearchView" owner:nil options:nil].lastObject;
        _navSearchView.frame = CGRectMake(10, 0, kScreenWidth-70, 35);
        self.navigationItem.titleView = _navSearchView;
        //搜索按钮
        [_navSearchView.searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navSearchView;
}

- (void)searchBtnClick:(UIButton *)btn{
    LCCSearchVC *searchVc = [LCCSearchVC new];
    [self.navigationController pushViewController:searchVc animated:YES];
}

#pragma mark - 弹出右边筛选
- (void)externEvents:(UIButton *)btn{
    [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
}

//初始化标题ScrollView
-(void)setupScrollView{
    //标题
    NSInteger count = self.childViewControllers.count;
    self.titleScrollView.backgroundColor = [UIColor clearColor];

    //设置标题滚动条
    self.titleScrollView.contentSize = CGSizeMake(count * labelWith, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    //设置内容滚动条
    self.contentScrollView.contentSize = CGSizeMake(kScreenWidth*count, 0);
    //开启分页
    self.contentScrollView.pagingEnabled = YES;
    //没有弹簧效果
    self.contentScrollView.bounces = NO;
    //隐藏水平滚动条
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    //设置协议
    self.contentScrollView.delegate = self;
}

//设置页面scrollView
-(void)setScrollViewTopAndBottom{
    self.navigationController.navigationBar.translucent = NO;
    UIScrollView *Scroll = [[UIScrollView alloc]init];
    Scroll.frame = CGRectMake(0, 0, kScreenWidth, 44);
    Scroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:Scroll];
    self.titleScrollView = Scroll;
    
    //内容
    UIScrollView *contentScroll = [[UIScrollView alloc]init];
    contentScroll.frame = CGRectMake(0, CGRectGetMaxY(Scroll.frame), kScreenWidth, self.view.frame.size.height - 64 -44);
    contentScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentScroll];
    self.contentScrollView = contentScroll;
}

//添加所有子控制器对应标题
-(void)setupTitleLabel{
    NSInteger count = self.childViewControllers.count;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat height = 44;
    for (int i = 0; i < count; i++) {
        //取出控制器
        UIViewController *vc = self.childViewControllers[i];
        
        //创建label
        UILabel *label = [[UILabel alloc]init];
        
        //添加label 到titleArray 数组
        [self.titleArray addObject:label];
        
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        x = i*labelWith;
        label.tag = i;
        
        //设置尺寸
        label.frame = CGRectMake(x, y, labelWith, height);
        
        //设置Label文字
        label.text = vc.title;
        label.textColor = ZCXColor(238, 147, 134);
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
        
        //设置高亮文字颜色
        label.highlightedTextColor = [UIColor whiteColor];
        
        //默认选中第0个label
        if (i == 0) {
            [self titleClick:tap];
        }
        //添加label
        [self.titleScrollView addSubview:label];
    }
}

#pragma mark -- UISCrollview代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    //1.添加子控制器View
    [self showVC:index];
    
    //2.把对应标题选中
    UILabel *label = self.titleArray[index];
    [self selectLabel:label];
    
    //3让选中标题居中
    [self setUpTitleCenter:label];
}

//滚动就会调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat currpage = scrollView.contentOffset.x/kScreenWidth;
    
    //左边角标
    NSInteger leftIndex = currpage;
    
    //右边角标
    NSInteger rightIndex = leftIndex + 1;
    
    //获取左边label
    UILabel *leftLabel = self.titleArray[leftIndex];
    
    //获取右边label
    UILabel *rightLabel;
    if (rightIndex <= self.titleArray.count - 1) {
        rightLabel = self.titleArray[rightIndex];
    }
    
    //计算右边缩放比例 右边自己相对于左边字体变大比例
    CGFloat rightscal = currpage - leftIndex;
    
    //计算左边缩放比例
    CGFloat leftscal = 1 - rightscal;
    
    //缩放比例 1~1.3
    //左边缩放比例
    leftLabel.transform = CGAffineTransformMakeScale(leftscal*0.1+1,leftscal*0.1+1);
    
    //右边缩放比例
    rightLabel.transform = CGAffineTransformMakeScale(rightscal*0.1+1,rightscal*0.1+1);
    
    //设置文字颜色渐变
    /**RGB 渐变*/
//    leftLabel.textColor = [UIColor colorWithRed:leftscal green:0 blue:0 alpha:1];
//    rightLabel.textColor = [UIColor colorWithRed:rightscal green:0 blue:0 alpha:1];
    leftLabel.textColor = ZCXColor(238, 147, 134);
    rightLabel.textColor = ZCXColor(238, 147, 134);
}

//显示页面
-(void)showVC:(NSInteger)index{
    
    CGFloat offsetX = index * kScreenWidth;
    
    UIViewController *vc = self.childViewControllers[index];
    
    //判断当前控制器的View 有没有加载过 如果已经加载过 就不需要加载
    if (vc.isViewLoaded) return;
    vc.view.frame = CGRectMake(offsetX, 0, kScreenWidth, self.contentScrollView.frame.size.height);
    [self.contentScrollView addSubview:vc.view];
}

//label点击事件
-(void)titleClick:(UITapGestureRecognizer*)tap{
    //0取出label
    UILabel *label = (UILabel*)tap.view;
    
    //1.标题颜色高亮
    [self selectLabel:label];
    //2.滚动相应位置
    NSInteger index = label.tag;
    //2.1计算滚动位置
    CGFloat offsetX = label.tag * kScreenWidth;
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    //3.对应位置添加控制器View
    [self showVC:index];
    
    //4.让选中标题居中
    [self setUpTitleCenter:label];
}

-(void)selectLabel:(UILabel *)label{
    
    _seletLabel.highlighted = NO;
    //取消形变
    _seletLabel.transform = CGAffineTransformIdentity;
    
//    _seletLabel.textColor = [UIColor blackColor];
    _seletLabel.textColor = ZCXColor(238, 147, 134);
    label.highlighted = YES;
    
    //形变
    label.transform = CGAffineTransformMakeScale(1.1,1.1);
    
    _seletLabel = label;
}

//设置标题居中
-(void)setUpTitleCenter:(UILabel*)centerLabel{
    //计算偏移量
    CGFloat offsetX = centerLabel.center.x - kScreenWidth*0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    //最大滚动范围
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - kScreenWidth;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    //滚动标题滚动条
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

//添加所有子控制器
-(void)setAllChildController{
    NSLog(@"-标题--%@", self.bannerDataSource);
    //推荐
    LPPRecommendVC *oneVC = [[LPPRecommendVC alloc]init];
//    oneVC.title = modelArr[0][@"name"];
    oneVC.title = @"推荐";
    oneVC.tagId = @"1";
    [self addChildViewController:oneVC];
    
    //活动
    LPPActivityVC *twoVC = [[LPPActivityVC alloc]init];
//    twoVC.title = modelArr[1][@"name"];
    twoVC.title = @"活动";
    twoVC.tagId = @"3";
    [self addChildViewController:twoVC];
    
    //新品
    LPPNewProductsVC *threeVC = [[LPPNewProductsVC alloc]init];
//    threeVC.title = modelArr[2][@"name"];
    threeVC.title = @"新品";
    threeVC.tagId = @"5";
    [self addChildViewController:threeVC];
    
    //男士
    LPPLadyCommodityVC *fourVC = [[LPPLadyCommodityVC alloc]init];
//    fourVC.title = modelArr[3][@"name"];
    fourVC.title = @"男士";
    fourVC.tagId = @"42";
    [self addChildViewController:fourVC];
    
    //女士
    LPPLadyCommodityVC *fiveVC = [[LPPLadyCommodityVC alloc]init];
//    fiveVC.title = modelArr[4][@"name"];
    fiveVC.title = @"女士";
    fiveVC.tagId = @"43";
    [self addChildViewController:fiveVC];
    
}

@end
