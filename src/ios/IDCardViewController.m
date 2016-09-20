//
//  IDCardViewController.m
//  idcard
//
//  Created by hxg on 14-10-10.
//  Copyright (c) 2014年 hxg. All rights reserved.
//
@import MobileCoreServices;
@import ImageIO;
#import "IDCardViewController.h"
#import "IdInfo.h"
@interface IDCardViewController ()<UIAlertViewDelegate>
@property (strong, nonatomic) UIView *toolBarView;
@property (strong, nonatomic) UILabel *tipsLabel;
@end

@implementation IDCardViewController
@synthesize verify = _verify;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

static Boolean init_flag = false;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机照相机权限已关闭,请在设置里打开" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if (!init_flag)
    {
        const char *thePath = [[[NSBundle mainBundle] resourcePath] UTF8String];
        int ret = EXCARDS_Init(thePath);
        if (ret != 0)
        {
            NSLog(@"Init Failed!ret=[%d]", ret);
        }
        
        init_flag = true;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self showWebView:nil];
    }
}

- (void)closeAction
{
    [self removeCapture];
    [self dismissViewControllerAnimated: YES completion:nil];
    if(init_flag){
        EXCARDS_Done();
        init_flag = false;
    }
}

- (void)startAction
{
    [[_capture captureSession] startRunning];
}

-(void) viewDidUnload
{
    if (_buffer != NULL)
    {
        free(_buffer);
        _buffer = NULL;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initCapture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Capture

- (void)initCapture
{
    // init capture manager
    _capture = [[Capture alloc] init];
    
    _capture.delegate = self;
    _capture.verify = self.verify;
    
    // set video streaming quality
    // AVCaptureSessionPresetHigh   1280x720
    // AVCaptureSessionPresetPhoto  852x640
    // AVCaptureSessionPresetMedium 480x360
    _capture.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    
    //kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange
    //kCVPixelFormatType_420YpCbCr8BiPlanarFullRange
    //kCVPixelFormatType_32BGRA
    [_capture setOutPutSetting:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]];
    
    // AVCaptureDevicePositionBack
    // AVCaptureDevicePositionFront
    [_capture addVideoInput:AVCaptureDevicePositionBack];
    
    [_capture addVideoOutput];
    [_capture addVideoPreviewLayer];
    
    CGRect layerRect = self.view.bounds;
    [[_capture previewLayer] setOpaque: 0];
    [[_capture previewLayer] setBounds:layerRect];
    [[_capture previewLayer] setPosition:CGPointMake( CGRectGetMidX(layerRect), CGRectGetMidY(layerRect))];
    
    CGRect frame = self.view.bounds;
    _cameraView = [[UIView alloc] initWithFrame:frame];
    [[_cameraView layer] addSublayer:[_capture previewLayer]];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 375, 50)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor blackColor]];
    [backBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.alpha = .5f;
    backBtn.frame = CGRectMake(10, 10, 35, 35);
    [view addSubview:backBtn];
    view.alpha = 0;
    self.toolBarView = view;
    
    backBtn.layer.masksToBounds = YES;
    backBtn.layer.cornerRadius = backBtn.frame.size.width*.5;
    
    [self.view addSubview:view];
    [self.view addSubview: _cameraView];
    [self.view sendSubviewToBack:_cameraView];
    
    CGFloat x = (180-110-25)*320/180.0;
    CGFloat y = 210*320/180.0;
    CGFloat w = 110*320/180.0;
    CGFloat h = 90*320/180.0;
    UIView *mview = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    mview.backgroundColor = [UIColor clearColor];
    mview.layer.masksToBounds = YES;
    mview.layer.borderColor = [UIColor whiteColor].CGColor;
    mview.layer.borderWidth = 1;
    [_cameraView addSubview:mview];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"请将身份证正面置于此区域";
    label.textColor = [UIColor whiteColor];
   
    label.textAlignment = NSTextAlignmentLeft;
    label.transform = CGAffineTransformMakeRotation(M_PI_2);
    label.frame = CGRectMake(0, 64+30, 375, 667-64-30);
    [_cameraView addSubview:label];
    
    label.alpha = 0;
    self.tipsLabel = label;
    
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:.5f];
    // start !
    [self performSelectorInBackground:@selector(startCapture) withObject:nil];
}

- (void)delayMethod
{
    self.tipsLabel.alpha = 1;
    self.toolBarView.alpha = 1;
}

- (void)removeCapture
{
    [_capture.captureSession stopRunning];
    [_cameraView removeFromSuperview];
    _capture     = nil;
    _cameraView  = nil;
}

- (void)startCapture
{
    {
        [[_capture captureSession] startRunning];
    }
}

#pragma mark - Capture Delegates
- (void)idCardRecognited:(IdInfo*)idInfo
{
    dispatch_async(dispatch_get_main_queue(), ^{

        if (idInfo.code != nil)
        {
            
            [_capture.captureSession stopRunning];
            
//            type; //1:正面  2:反面
//            @property (retain, nonatomic) NSString *code; //身份证号
//            @property (retain, nonatomic) NSString *name; //姓名
//            @property (retain, nonatomic) NSString *gender; //性别
//            @property (retain, nonatomic) NSString *nation; //民族
//            @property (retain, nonatomic) NSString *address; //地址
//            @property (retain, nonatomic) NSString *issue; //签发机关
//            @property (retain, nonatomic) NSString *valid; //有效期
            
            
            int type = idInfo.type;
            NSString *typeStr = [NSString stringWithFormat:@"%d", type];
            NSString *code = idInfo.code?idInfo.code:@"aaa";
            NSString *name = idInfo.name?idInfo.name:@"aaa";
            NSString *gender = idInfo.gender?idInfo.gender:@"aaa";
            NSString *nation = idInfo.nation?idInfo.nation:@"aaa";
            NSString *address = idInfo.address?idInfo.address:@"aaa";
            NSString *issue = idInfo.issue?idInfo.issue:@"aaa";
            NSString *valid = idInfo.valid?idInfo.valid:@"aaa";
            UIImage *image = idInfo.img;
            UIImage *scaleImg = [self scaleImage:image];
            
            
            NSLog(@"正面：%d, 身份证号: %@, 姓名：%@, 性别：%@, 民族：%@, 地址：%@, 发证机关：%@, 有效期：%@", type, code, name, gender, nation, address, issue, valid);
            NSDictionary *dic = @{@"type": typeStr,
                                  @"code": code,
                                  @"name": name,
                                  @"gender":gender,
                                  @"nation":nation,
                                  @"address": address,
                                  @"issue": issue,
                                  @"valid": valid,
                                  @"image": @"11111"};
            
            [self showWebView:dic];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        }
    });
    
}




- (void)viewWillDisappear:(BOOL)animated{
    [self.view removeFromSuperview];
    self.view = nil;
}

- (void)showWebView:(NSDictionary *)dataDic
{
    if (self.block) {
        
        self.block(dataDic);
    }
    NSLog(@"返回显示===========%@", dataDic);
}

- (UIImage *)scaleImage:(UIImage *)image
{
    CGFloat scale = image.size.width/320.0;
    CGImageRef imgRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(210*scale, 25*scale, 90*scale, 110*scale));
    UIImage *thumbScale = [UIImage imageWithCGImage:imgRef];
    return thumbScale;

    
}


@end
