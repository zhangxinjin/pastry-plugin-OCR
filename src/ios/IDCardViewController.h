//
//  IDCardViewController.h
//  idcard
//
//  Created by hxg on 14-10-10.
//  Copyright (c) 2014年 hxg. All rights reserved.
//

#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE

#import <UIKit/UIKit.h>
#import "Capture.h"

typedef void(^InfoBlock)(NSDictionary *dic);



@interface IDCardViewController : UIViewController<CaptureDelegate>
{
    Capture *_capture;
    UIView         *_cameraView;
    unsigned char* _buffer;
}
@property (weak, nonatomic) id<CaptureDelegate> delegate;
@property (assign, nonatomic)BOOL verify;


@property (copy, nonatomic)InfoBlock block;

@end

#endif
