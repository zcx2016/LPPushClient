//
//  LPPCreateNewAddressVC.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/6.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPCreateNewAddressVC.h"
#import "LPPSetFooterView.h"
#import "LPPAddressTFCell.h"
#import "LPPOverseaBuyCell.h"
#import "LPPUploadIdCardImgCell.h"
#import "LPPAddressPickerCell.h"
#import "YJLocationPicker.h"

@interface LPPCreateNewAddressVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

//增加 海外购的 索引
@property (nonatomic, assign) NSInteger addIndex;

@property (nonatomic, assign) BOOL isOverseaCellSelected;

@property (nonatomic, assign) BOOL isDefaultCellSelected;

@property (nonatomic, weak) LPPOverseaBuyCell *week_overseaBuyCell;

@property (nonatomic, weak) UITableViewCell *week_defaultCell;

@property (nonatomic, weak) LPPUploadIdCardImgCell *week_idCardImgCell;

//弱引用4个控件，来取值
@property (nonatomic, weak) UITextField *weak_nameTF;
@property (nonatomic, weak) UITextField *weak_phoneTF;
@property (nonatomic, weak) UITextField *weak_addressTF;
@property (nonatomic, weak) UIButton *weak_areaBtn;
//是否有海外购
@property (nonatomic, copy) NSString  *haveOverSea;
//是否 设为默认
@property (nonatomic, copy) NSString  *isSetDefault;
//图片数组
@property (nonatomic, strong) NSMutableArray *imgArray;

//自定义 联系电话 的inputAccessoryView
@property (nonatomic, strong) UIToolbar *customAccessoryView;

@end

@implementation LPPCreateNewAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"添加新地址";
    
    //默认都为0
    self.isSetDefault = @"0";
    self.haveOverSea = @"0";
    self.imgArray = [NSMutableArray array];
    
    //加载ui
    [self tableView];
    [self createBottomBtn];
}

#pragma mark - 更新tableViewCell数量
- (void)addOverseaBuyCell{
    self.addIndex++;
    [self.tableView reloadData];
}

- (void)deleteOverseaBuyCell{
    self.addIndex--;
    [self.tableView reloadData];
}

#pragma mark - 创建底部保存按钮
- (void)createBottomBtn{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:ZCXColor(242, 69, 60)];
    [self.view addSubview:btn];
}

//点击保存按钮
- (void)saveBtnClick:(UIButton *)btn{
    [self uploadData];
}

- (void)uploadData{
    NSString *user_id = [ZcxUserDefauts objectForKey:@"user_id"];
    NSString *token = [ZcxUserDefauts objectForKey:@"token"];
    NSString *trueName = self.weak_nameTF.text;
    NSString *telephone = self.weak_phoneTF.text;
    NSString *area_addr = self.weak_areaBtn.titleLabel.text;
    NSString *area_info = self.weak_addressTF.text;
    
    //判断是否有海外购
    [self judgeHaveOverSeaImg];
    
    //网络请求
    NSDictionary *dict = @{@"trueName" : trueName ,@"user_id" : user_id , @"token" : token, @"telephone" : telephone ,@"area_addr" : area_addr, @"area_info" : area_info, @"idCard" : self.haveOverSea , @"isDefaultAddress" : self.isSetDefault};
    NSLog(@"dict=====%@",dict);
    [[LCHTTPSessionManager sharedInstance].requestSerializer setValue:[ZcxUserDefauts objectForKey:@"verify"] forHTTPHeaderField:@"token-id"];
    
    [[LCHTTPSessionManager sharedInstance] POST:[kUrlReqHead stringByAppendingString:@"/app/buyer/address_new_save.htm"] parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       
        if (!self.imgArray) return;

        for (NSUInteger i = 0; i < self.imgArray.count; ++i) {
            [formData appendPartWithFileData:self.imgArray[i]
                                        name:[NSString stringWithFormat:@"%zd", i]
                                    fileName:[NSString stringWithFormat:@"uploadPhoto%zd.jpg",i]  //随便写
                                    mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传图片----%@",responseObject);
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传图片---error -- %@",error);
    }];
}

- (void)judgeHaveOverSeaImg{
    if (!self.week_idCardImgCell.idCardFrontImgView.image && ! self.week_idCardImgCell.idCardBackImgView.image) {
        self.haveOverSea = @"0";  //无海外购
    }else{
        if (self.week_idCardImgCell.idCardFrontImgView.image  && ! self.week_idCardImgCell.idCardBackImgView.image) {
            //有正面照 ,无反面照
            [SVProgressHUD showErrorWithStatus:@"缺少身份证背面照"];
        }else if (!self.week_idCardImgCell.idCardFrontImgView.image  && self.week_idCardImgCell.idCardBackImgView.image){
            //有反面照 ,无正面照
            [SVProgressHUD showErrorWithStatus:@"缺少身份证正面照"];
        }else{ //都有
            self.haveOverSea = @"1";  //有海外购
            NSData *imageData1 = UIImageJPEGRepresentation(self.week_idCardImgCell.idCardFrontImgView.image, 0.5);
            NSData *imageData2 = UIImageJPEGRepresentation(self.week_idCardImgCell.idCardBackImgView.image, 0.5);
            [self.imgArray addObject:imageData1];
            [self.imgArray addObject:imageData2];
        }
    }
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
        [cell.imageView setImage:[UIImage imageNamed:@"unSelected"]];
        cell.textLabel.text = @"设为默认";
        cell.textLabel.textColor = [UIColor darkGrayColor];
        self.week_defaultCell = cell;
        return cell;
    }else{
        if (self.addIndex == 0) {  //---------------------------------------无扩展
            if (indexPath.row == 2) {
                LPPAddressPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPAddressPickerCell" forIndexPath:indexPath];
                self.weak_areaBtn = cell.addressBtn;
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
                        cell.detailTextField.placeholder = @"请输入姓名";
                        self.weak_nameTF = cell.detailTextField;
                    }else{
                        cell.nameLabel.text = @"联系电话";
                        cell.detailTextField.keyboardType = UIKeyboardTypePhonePad;
                        cell.detailTextField.inputAccessoryView = self.customAccessoryView;
                        cell.detailTextField.placeholder = @"请输入联系电话";
                        self.weak_phoneTF = cell.detailTextField;
                    }
                    return cell;
                }else{
                    cell.rightArrowBtn.hidden = NO;
                    cell.detailTextField.textAlignment = NSTextAlignmentRight;
                    cell.nameLabel.text = @"详细地址";
                    cell.detailTextField.placeholder = @"广济路828号a栋9楼";
                    self.weak_addressTF = cell.detailTextField;
                    return cell;
                }
            }
        }else{ //---------------------------------------有扩展
            if (indexPath.row == 2) {
                LPPAddressPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPAddressPickerCell" forIndexPath:indexPath];
                self.weak_areaBtn = cell.addressBtn;
                [cell.addressBtn addTarget:self action:@selector(addressPickerEvents:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }else if (indexPath.row == 4) {
                LPPOverseaBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPOverseaBuyCell" forIndexPath:indexPath];
                self.week_overseaBuyCell = cell;
                return cell;
            }else if (indexPath.row == 5){
                LPPUploadIdCardImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPUploadIdCardImgCell" forIndexPath:indexPath];
                self.week_idCardImgCell = cell;
                return cell;
            }else{
                LPPAddressTFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPPAddressTFCell" forIndexPath:indexPath];
                if (indexPath.row == 0 || indexPath.row == 1) {
                    cell.rightArrowBtn.hidden = YES;
                    if(indexPath.row == 0){
                        cell.nameLabel.text = @"姓名";
                        cell.detailTextField.placeholder = @"请输入姓名";
                        self.weak_nameTF = cell.detailTextField;
                    }else{
                        cell.nameLabel.text = @"联系电话";
                        cell.detailTextField.keyboardType = UIKeyboardTypePhonePad;
                        cell.detailTextField.inputAccessoryView = self.customAccessoryView;
                        cell.detailTextField.placeholder = @"请输入联系电话";
                        self.weak_phoneTF = cell.detailTextField;
                    }
                    return cell;
                }else{
                    cell.rightArrowBtn.hidden = NO;
                    cell.detailTextField.textAlignment = NSTextAlignmentRight;
                    cell.nameLabel.text = @"详细地址";
                    cell.detailTextField.placeholder = @"广济路828号a栋9楼";
                    self.weak_addressTF = cell.detailTextField;
                    return cell;
                }
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 4) {   //海外购
            if (!self.isOverseaCellSelected) {   //有海外购
                self.isOverseaCellSelected = !self.isOverseaCellSelected;
                [self.week_overseaBuyCell.addCellBtn setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateNormal];
                [self addOverseaBuyCell];
            }else{   //无海外购
                self.isOverseaCellSelected = !self.isOverseaCellSelected;
                [self.week_overseaBuyCell.addCellBtn setImage:[UIImage imageNamed:@"upArrow"] forState:UIControlStateNormal];
                [self deleteOverseaBuyCell];
            }
        }
    }else{  //设为默认
        if (!self.isDefaultCellSelected) {
            self.isDefaultCellSelected = !self.isDefaultCellSelected;
            [self.week_defaultCell.imageView setImage:[UIImage imageNamed:@"selected"]];
            self.isSetDefault = @"1";
        }else{
            self.isDefaultCellSelected = !self.isDefaultCellSelected;
            [self.week_defaultCell.imageView setImage:[UIImage imageNamed:@"unSelected"]];
            self.isSetDefault = @"0";
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

#pragma mark - 地址选择栏
- (void)addressPickerEvents:(UIButton *)btn{
    //直接调用
    [[[YJLocationPicker alloc] initWithSlectedLocation:^(NSArray *locationArray) {
        
        //拼接后给button赋值
        [btn setTitle:[[locationArray[0] stringByAppendingString:locationArray[1]] stringByAppendingString:locationArray[2]]forState:UIControlStateNormal];
        //改变btn按钮颜色
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }] show];
}

//自定义 电话 和 qq 的inputAccessoryView
- (UIToolbar *)customAccessoryView{
    if (!_customAccessoryView) {
        _customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,kScreenWidth,45}];
        _customAccessoryView.barTintColor = [UIColor lightGrayColor];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
        [_customAccessoryView setItems:@[space,finish]];
    }
    return _customAccessoryView;
}

- (void)done{
    [self.weak_phoneTF resignFirstResponder];
}
@end
