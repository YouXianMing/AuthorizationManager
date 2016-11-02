//
//  BaseAuthorization.m
//  Authorization
//
//  Created by YouXianMing on 2016/11/2.
//  Copyright © 2016年 TechCodeAgent. All rights reserved.
//

#import "BaseAuthorization.h"

@implementation BaseAuthorization

+ (void)requestAuthorization:(void(^)(AuthorizationStatus status))callback {

    [self executeCallback:callback status:AuthorizationStatusDenied];
}

+ (void)executeCallback:(void (^)(AuthorizationStatus))callback status:(AuthorizationStatus)status {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (callback) {
            
            callback(status);
        }
    });
}

@end
