//
//  AddressBookAuthorization.m
//  Authorization
//
//  Created by YouXianMing on 2016/11/2.
//  Copyright © 2016年 TechCodeAgent. All rights reserved.
//

#import "AddressBookAuthorization.h"

@implementation AddressBookAuthorization

+ (void)requestAuthorization:(void (^)(AuthorizationStatus))callback {

    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    
    if (authStatus == kABAuthorizationStatusNotDetermined) {
        
        __block ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        
        if (addressBook == NULL) {
            
            [self executeCallback:callback status:AuthorizationStatusNotSupport];
            return;
        }
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            
            if (granted) {
                
                [self executeCallback:callback status:AuthorizationStatusAuthorized];
                
            } else {
                
                [self executeCallback:callback status:AuthorizationStatusDenied];
            }
            
            if (addressBook) {
                
                CFRelease(addressBook);
                addressBook = NULL;
            }
        });
        
        return;
        
    } else if (authStatus == kABAuthorizationStatusAuthorized) {
        
        [self executeCallback:callback status:AuthorizationStatusAuthorized];
        
    } else if (authStatus == kABAuthorizationStatusDenied) {
        
        [self executeCallback:callback status:AuthorizationStatusDenied];
        
    } else if (authStatus == kABAuthorizationStatusRestricted) {
        
        [self executeCallback:callback status:AuthorizationStatusRestricted];
    }
}

@end
