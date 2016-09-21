//
//  IdInfo.h
//  exid
//
//  Created by hxg on 14-10-10.
//  Copyright (c) 2014年 hxg. All rights reserved.
//
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IdInfo : NSObject
{
}
@property (nonatomic) int type; //1:正面  2:反面
@property (retain, nonatomic) NSString *code; //身份证号
@property (retain, nonatomic) NSString *name; //姓名
@property (retain, nonatomic) NSString *gender; //性别
@property (retain, nonatomic) NSString *nation; //民族
@property (retain, nonatomic) NSString *address; //地址
@property (retain, nonatomic) NSString *issue; //签发机关
@property (retain, nonatomic) NSString *valid; //有效期

@property (strong, nonatomic)UIImage *img;

-(NSString *)toString;
-(BOOL)isOK;
@end

#endif