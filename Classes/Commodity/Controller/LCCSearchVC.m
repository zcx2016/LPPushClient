//
//  LCCSearchVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/23.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LCCSearchVC.h"

@interface LCCSearchVC ()<UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation LCCSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self searchBarViewChat];
}

- (void)searchBarViewChat{
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    _searchController.delegate = self;
    _searchController.searchResultsUpdater = self;
    //搜索时，背景变模糊
    _searchController.dimsBackgroundDuringPresentation = NO;
    //点击搜索框时，不要隐藏navigationBar
    _searchController.hidesNavigationBarDuringPresentation = NO;
    //    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    _searchController.searchBar.frame = CGRectMake(0, 0, self.searchController.searchBar.frame.size.width, 44.0);
    _searchController.searchBar.placeholder = @"请输入搜索内容";
    self.definesPresentationContext = YES;
    _searchController.searchBar.delegate = self;
    [self.view addSubview:_searchController.searchBar];
}

#pragma mark - 搜索框协议
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}

@end
