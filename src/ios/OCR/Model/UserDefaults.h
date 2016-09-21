//
//  UserDefaults.h
//  idcard
//
//  Created by hxg on 14-10-10.
//  Copyright (c) 2014年 hxg. All rights reserved.
//
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

+ (BOOL) usingVerify;
+ (void) setUsingVerify:(BOOL)x;

@end

#endif