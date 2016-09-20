//
//  UserDefaults.h
//  idcard
//
//  Created by hxg on 14-10-10.
//  Copyright (c) 2014年 hxg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

+ (BOOL) usingVerify;
+ (void) setUsingVerify:(BOOL)x;

@end
