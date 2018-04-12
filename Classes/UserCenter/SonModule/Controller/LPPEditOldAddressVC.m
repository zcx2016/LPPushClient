//
//  LPPEditOldAddressVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/6.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPEditOldAddressVC.h"
#import "LPPSetFooterView.h"
#import "LPPOverseaBuyCell.h"
#import "LPPUploadIdCardImgCell.h"
#import "LPPAddressTFCell.h"
#import "LPPAddressPickerCell.h"
#import "YJLocationPicker.h"

@interface LPPEditOldAddressVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

//增加 海外购的 索引
@property (nonatomic, assign) NSInteger addIndex;

@property (nonatomic, assign) BOOL isOverseaCellSelected;

@property (nonatomic, assign) BOOL isDefaultCellSelected;

@property (nonatomic, weak) LPPOverseaBuyCell *week_overseaBuyCell;

@property (nonatomic, weak) UITableViewCell *week_defaultCell;

@end

@implementation LPPEditOldAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"编辑地址";
    
    //导航栏 右侧 按钮
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
    [deleteBtn addTarget:self action:@selector(sureToDeleteAddress) forControlEvents:UIControlEventTouchUpInside];
    
    [self tableView];
    
    [self createBottomBtn];
}

- (void)createBottomBtn{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setBackgroundColor:ZCXColor(242, 69, 60)];
    [self.view addSubview:btn];
}

- (void)addOverseaBuyCell{
    self.addIndex++;
    [self.tableView reloadData];
}

- (void)deleteOverseaBuyCell{
    self.addIndex--;
    [self.tableView reloadData];
}

#pragma mark - 是否确认删除旧地址
- (void)sureToDeleteAddress{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定要删除该地址吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:actionNo];
    
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self deleteThisAddress];

    }];
    [alertVC addAction:actionYes];
    [self  presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - 删除旧地址
- (void)deleteThisAddress{
    
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSString *token = [ZcxUserDefauts objectForKey:@"token"];
    NSDictionary *dict = @{@"user_id" : user_id , @"token" : token ,@"addr_id" : self.addr_id};
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/buyer/address_new_delete.htm"] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"-responseObject---%@",responseObject);
        [SVProgressHUD showSuccessWithStatus:@"删除成功!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---error -- %@",error);
    }];
}


- (void)addressPickerEvents:(UIButton *)btn{
    //直接调用
    [[[YJLocationPicker alloc] initWithSlectedLocation:^(NSArray *locationArray) {
        
        //拼接后给button赋值
        [btn setTitle:[[locationArray[0] stringByAppendingString:locationArray[1]] stringByAppendingString:locationArray[2]]forState:UIControlStateNormal];
        
    }] show];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5 + self.addIndex;
    }
    return 1;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"defaultCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = @"设为默认";
        cell.textLabel.textColor = [UIColor darkGrayColor];
        //赋值
        if ([self.defaultNum isEqualToString:@"1"]) {
            [cell.imageView setImage:[UIImage imageNamed:@"selected"]];
        }else{
            [cell.imageView setImage:[UIImage imageNamed:@"unSelected"]];
        }
        self.week_defaultCell = cell;
        return cell;
    }else{
        if (self.addIndex == 0) {  //---------------------------------------无扩展
            if (indexPath.row == 2) {
                LPPAddressPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPAddressPickerCell" forIndexPath:indexPath];
                //赋值
                [cell.addressBtn setTitle:self.areaAddr forState:UIControlStateNormal];
                [cell.addressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                [cell.addressBtn addTarget:self action:@selector(addressPickerEvents:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }else if (indexPath.row == 4) {
                LPPOverseaBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPOverseaBuyCell" forIndexPath:indexPath];
                self.week_overseaBuyCell = cell;
                return cell;
            }else{
                LPPAddressTFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPAddressTFCell" forIndexPath:indexPath];
                if (indexPath.row == 0 || indexPath.row == 1) {
                    cell.rightArrowBtn.hidden = YES;
                    if(indexPath.row == 0){
                        cell.nameLabel.text = @"姓名";
                        cell.detailTextField.text = self.trueName;
                    }else{
                        cell.nameLabel.text = @"联系电话";
                        cell.detailTextField.text = self.telephone;
                    }
                    return cell;
                }else{
                    cell.rightArrowBtn.hidden = NO;
                    cell.detailTextField.textAlignment = NSTextAlignmentRight;
                    cell.nameLabel.text = @"详细地址";
                    cell.detailTextField.text = self.areaInfo;
                    return cell;
                }
            }
        }else{ //---------------------------------------有扩展
            if (indexPath.row == 2) {
                LPPAddressPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPAddressPickerCell" forIndexPath:indexPath];
                //赋值
                [cell.addressBtn setTitle:self.areaAddr forState:UIControlStateNormal];
                [cell.addressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                [cell.addressBtn addTarget:self action:@selector(addressPickerEvents:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }else if (indexPath.row == 4) {
                LPPOverseaBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPOverseaBuyCell" forIndexPath:indexPath];
                self.week_overseaBuyCell = cell;
                return cell;
            }else if (indexPath.row == 5){
                LPPUploadIdCardImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPUploadIdCardImgCell" forIndexPath:indexPath];
                
                if ([[NSString stringWithFormat:@"%@",[self.idcardfond class]] isEqualToString:@"__NSCFString"]) {
                    //如果是这个类型
                    NSURL *url = [NSURL URLWithString:self.idcardfond];
                    [cell.idCardFrontImgView sd_setImageWithURL:url placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                        
                    }];
                }
                if ([[NSString stringWithFormat:@"%@",[self.idcardback class]] isEqualToString:@"__NSCFString"]) {
                    //如果是这个类型
                    NSURL *url = [NSURL URLWithString:self.idcardback];
                    [cell.idCardBackImgView sd_setImageWithURL:url placeholderImage:kPlaceHolderImg completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                        
                    }];
                }
                return cell;
            }else{
                LPPAddressTFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPAddressTFCell" forIndexPath:indexPath];
                if (indexPath.row == 0 || indexPath.row == 1) {
                    cell.rightArrowBtn.hidden = YES;
                    if(indexPath.row == 0){
                        cell.nameLabel.text = @"姓名";
                        cell.detailTextField.text = self.trueName;
                    }else{
                        cell.nameLabel.text = @"联系电话";
                        cell.detailTextField.text = self.telephone;
                    }
                    return cell;
                }else{
                    cell.rightArrowBtn.hidden = NO;
                    cell.detailTextField.textAlignment = NSTextAlignmentRight;
                    cell.nameLabel.text = @"详细地址";
                    cell.detailTextField.text = self.areaInfo;
                    return cell;
                }
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 4) {
            if (!self.isOverseaCellSelected) {
                self.isOverseaCellSelected = !self.isOverseaCellSelected;
                [self.week_overseaBuyCell.addCellBtn setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateNormal];
                [self addOverseaBuyCell];
            }else{
                self.isOverseaCellSelected = !self.isOverseaCellSelected;
                [self.week_overseaBuyCell.addCellBtn setImage:[UIImage imageNamed:@"upArrow"] forState:UIControlStateNormal];
                [self deleteOverseaBuyCell];
            }
        }
    }else{
        if (!self.isDefaultCellSelected) {
            self.isDefaultCellSelected = !self.isDefaultCellSelected;
            [self.week_defaultCell.imageView setImage:[UIImage imageNamed:@"selected"]];
        }else{
            self.isDefaultCellSelected = !self.isDefaultCellSelected;
            [self.week_defaultCell.imageView setImage:[UIImage imageNamed:@"unSelected"]];
        }
    }
}

#pragma mark - 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.addIndex == 0) {
        return 50;
    }else{
        if (indexPath.section == 0 && indexPath.row == 5) {
            return 400;
        }else{
            return 50;
        }
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
    return [[UIView alloc] init];
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPAddressPickerCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPAddressPickerCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPAddressTFCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPAddressTFCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPUploadIdCardImgCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPUploadIdCardImgCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPOverseaBuyCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LPPOverseaBuyCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
