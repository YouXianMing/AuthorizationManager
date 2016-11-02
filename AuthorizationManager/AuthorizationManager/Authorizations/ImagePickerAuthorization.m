//
//  ImagePickerAuthorization.m
//  Authorization
//
//  Created by YouXianMing on 2016/11/2.
//  Copyright © 2016年 TechCodeAgent. All rights reserved.
//

#import "ImagePickerAuthorization.h"

@implementation ImagePickerAuthorization

+ (void)requestAuthorization:(void (^)(AuthorizationStatus))callback {

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ||
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusNotDetermined) { // 未授权
            
            if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
                
                [self executeCallback:callback status:AuthorizationStatusAuthorized];
                
            } else {
                
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    
                    if (status == PHAuthorizationStatusAuthorized) {
                        
                        [self executeCallback:callback status:AuthorizationStatusAuthorized];
                        
                    } else if (status == PHAuthorizationStatusDenied) {
                        
                        [self executeCallback:callback status:AuthorizationStatusDenied];
                        
                    } else if (status == PHAuthorizationStatusRestricted) {
                        
                        [self executeCallback:callback status:AuthorizationStatusRestricted];
                    }
                }];
            }
            
        } else if (authStatus == ALAuthorizationStatusAuthorized) {
            
            [self executeCallback:callback status:AuthorizationStatusAuthorized];
            
        } else if (authStatus == ALAuthorizationStatusDenied) {
            
            [self executeCallback:callback status:AuthorizationStatusDenied];
            
        } else if (authStatus == ALAuthorizationStatusRestricted) {
            
            [self executeCallback:callback status:AuthorizationStatusRestricted];
        }
        
    } else {
        
        [self executeCallback:callback status:AuthorizationStatusNotSupport];
    }
}

@end
