//
//  CDVScanOCR.m
//  ChinaLife
//
//  Created by 董阳阳 on 16/9/14.
//
//

#import "PTScanOCR.h"
#import "IDCardViewController.h"

@implementation PTScanOCR

- (void)handleScanOCR:(CDVInvokedUrlCommand *)command;
{
    
    IDCardViewController *view = [[IDCardViewController alloc] init];
    view.block = ^(NSDictionary *dic) {
        
        NSString *objectStr = @"";
        if (dic) {
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            objectStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:objectStr];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        
    };
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:view animated:YES completion:nil];
    
        
}

@end
