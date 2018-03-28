//
//  LPPUploadIdCardImgCell.m
//  LPPushClient
//
//  Created by 张晨曦 on 2018/3/15.
//  Copyright © 2018年 张晨曦. All rights reserved.
//

#import "LPPUploadIdCardImgCell.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface LPPUploadIdCardImgCell()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, assign) NSInteger imgTag;

@end

@implementation LPPUploadIdCardImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.idCardFrontImgView.userInteractionEnabled = YES;
    [self.idCardFrontImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(idCardFrontImgViewTap:)]];
    
    self.idCardBackImgView.userInteractionEnabled = YES;
    [self.idCardBackImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(idCardBackImgViewTap:)]];
    
    //照片选择器
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    self.imagePickerController.allowsEditing = YES;
}

- (void)idCardFrontImgViewTap:(UITapGestureRecognizer *)recognizer{
    self.imgTag = 1;
    [self pickerImg];
}

- (void)idCardBackImgViewTap:(UITapGestureRecognizer *)recognizer{
    self.imgTag = 2;
    [self pickerImg];
}

- (void)pickerImg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"上传身份证照片" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"选择本地照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击调用相册
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePickerController.allowsEditing = YES;
        //相册权限
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusRestricted || authStatus ==ALAuthorizationStatusDenied){
            //无权限 引导去开启
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
        [[self viewController] presentViewController:self.imagePickerController animated:YES completion:nil];
    }]];
    
    //判断设备是否有具有摄像头(相机)功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击调用照相机
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.imagePickerController.allowsEditing = YES;
            //相机权限
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus ==AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied ){
                // 无权限 引导去开启
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication]canOpenURL:url]) {
                    [[UIApplication sharedApplication]openURL:url];
                }
            }
            [[self viewController] presentViewController:self.imagePickerController animated:YES completion:nil];
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [[self viewController] presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 相机／相册 代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //通过key值获取到图片
    UIImage * image =info[UIImagePickerControllerOriginalImage];
    //转换成jpg格式，并压缩，0.5比例最好
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
//    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
//
//    //将图片上传到服务器
//    NSDictionary *dict = @{@"registerId" : self.registerId , @"employeeId" : self.employeeId};
//
//    [[LCHTTPSessionManager sharedInstance] upload:[kUrlReqHead stringByAppendingString:@"/app/users/updatePhoto.do"] parameters:dict name:@"imgarray0" fileName:imageName data:imageData completion:^(id  _Nonnull result, BOOL isSuccess) {
//
//        //存头像
//        [UserDefautsLhm setObject:result[@"data"] forKey:KeyUserHeadImg];
//    }];
//
//    //判断数据源类型
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {    //相册
        if (self.imgTag == 1) {
            self.idCardFrontImgView.image = image;
        }else{
            self.idCardBackImgView.image = image;
        }

        [[self viewController] dismissViewControllerAnimated:YES completion:nil];
    }

    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {   //相机
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        if (self.imgTag == 1) {
            self.idCardFrontImgView.image = image;
        }else{
            self.idCardBackImgView.image = image;
        }
        
        [[self viewController] dismissViewControllerAnimated:YES completion:nil];
    }
}

//当用户取消选取时调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[self viewController] dismissViewControllerAnimated:YES completion:nil];
}

//获取控制器
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
