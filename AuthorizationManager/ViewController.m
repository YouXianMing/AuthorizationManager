//
//  ViewController.m
//  AuthorizationManager
//
//  Created by YouXianMing on 2016/11/2.
//  Copyright © 2016年 TechCodeAgent. All rights reserved.
//

#import "ViewController.h"
#import "AuthorizationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 获取照相机授权信息
    [CameraAuthorization requestAuthorization:^(AuthorizationStatus status) {
        
        NSLog(@"CameraAuthorization %lu", (unsigned long)status);
    }];
    
    // 获取选择图片授权信息
    [ImagePickerAuthorization requestAuthorization:^(AuthorizationStatus status) {
        
        NSLog(@"ImagePickerAuthorization %lu", (unsigned long)status);
    }];
    
    // 获取通讯录授权信息
    [AddressBookAuthorization requestAuthorization:^(AuthorizationStatus status) {
        
        NSLog(@"AddressBookAuthorization %lu", (unsigned long)status);
    }];
}

@end
