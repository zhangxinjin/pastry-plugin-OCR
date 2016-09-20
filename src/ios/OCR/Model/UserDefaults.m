//
//  UserDefaults.m
//  idcard
//
//  Created by hxg on 14-10-10.
//  Copyright (c) 2014年 hxg. All rights reserved.
//

#import "UserDefaults.h"

static NSString* USING_VERIFY_DEFAULTS_KEY = @"usingVerify";

@implementation UserDefaults

+ (void) initialize {
	[[NSUserDefaults standardUserDefaults]
     registerDefaults: @{
                         USING_VERIFY_DEFAULTS_KEY : [NSNumber numberWithBool:YES],
                         }];
}

+ (BOOL) usingVerify {
    return [[NSUserDefaults standardUserDefaults] boolForKey:USING_VERIFY_DEFAULTS_KEY];
}

+ (void) setUsingVerify:(BOOL)x {
    [[NSUserDefaults standardUserDefaults] setBool:x forKey:USING_VERIFY_DEFAULTS_KEY];
}

@end