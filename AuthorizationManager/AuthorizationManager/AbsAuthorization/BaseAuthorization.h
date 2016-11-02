//
//  BaseAuthorization.h
//  Authorization
//
//  Created by YouXianMing on 2016/11/2.
//  Copyright © 2016年 TechCodeAgent. All rights reserved.
//
//  Reference from http://www.jianshu.com/p/a05bc0598e2a
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <ContactsUI/ContactsUI.h>

typedef NS_ENUM(NSUInteger, AuthorizationStatus) {
    
    AuthorizationStatusAuthorized = 0,  // 已授权
    AuthorizationStatusDenied,          // 拒绝
    AuthorizationStatusRestricted,      // 应用没有相关权限,且当前用户无法改变这个权限,比如:家长控制
    AuthorizationStatusNotSupport,      // 硬件等不支持
};

@interface BaseAuthorization : NSObject

/**
 Request authorization, overwrite by subClass.

 @param callback The callback method.
 */
+ (void)requestAuthorization:(void(^)(AuthorizationStatus status))callback;

/**
 Execute callback, used by subClass.

 @param callback The callback method.
 @param status   The authorization status.
 */
+ (void)executeCallback:(void (^)(AuthorizationStatus))callback status:(AuthorizationStatus)status;

@end
