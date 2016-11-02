//
//  CameraAuthorization.m
//  Authorization
//
//  Created by YouXianMing on 2016/11/2.
//  Copyright © 2016年 TechCodeAgent. All rights reserved.
//

#import "CameraAuthorization.h"

@implementation CameraAuthorization

+ (void)requestAuthorization:(void (^)(AuthorizationStatus))callback {

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (authStatus == AVAuthorizationStatusNotDetermined) {
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                
                if (granted) {
                    
                    [self executeCallback:callback status:AuthorizationStatusAuthorized];
                    
                } else {
                    
                    [self executeCallback:callback status:AuthorizationStatusDenied];
                }
            }];
            
        } else if (authStatus == AVAuthorizationStatusAuthorized) {
            
            [self executeCallback:callback status:AuthorizationStatusAuthorized];
            
        } else if (authStatus == AVAuthorizationStatusDenied) {
            
            [self executeCallback:callback status:AuthorizationStatusDenied];
            
        } else if (authStatus == AVAuthorizationStatusRestricted) {
            
            [self executeCallback:callback status:AuthorizationStatusRestricted];
        }
        
    } else {
        
        [self executeCallback:callback status:AuthorizationStatusNotSupport];
    }
}

@end
