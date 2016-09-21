//
//  CDVScanOCR.h
//  ChinaLife
//
//  Created by 董阳阳 on 16/9/14.
//
//

#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE

#import <Cordova/CDVPlugin.h>

@interface PTScanOCR : CDVPlugin


- (void)handleScanOCR:(CDVInvokedUrlCommand *)command;


@end

#endif
