//
//  ScanQRCodeViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "ScanQRCodeViewController.h"
#import "ShowDetailViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface ScanQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
{
    AVCaptureSession * _session;//输入输出的中间桥梁
    
    UIAlertView * _alert;
    BOOL _hasInput;
    MBProgressHUD * _HUD;
    
}
@end

@implementation ScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self startScan];
}

- (void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];

    _alert = [[UIAlertView alloc] initWithTitle:@"扫描提示" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    _hasInput = NO;
}

- (void)startScan{
    
    [super viewDidLoad];
    
    NSError * error = nil;
    
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if (!error) {
        
        _hasInput = YES;
    }else{
        
        _hasInput = NO;
        NSLog(@"%@",error);
        
        _alert.message = @"相机调用失败！请检查相机";
        [_alert show];
    }
    
    if (_hasInput) {
        
        NSLog(@"vvv");
        [_session addInput:input];
        [_session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
//        output.rectOfInterest=CGRectMake(0,0,, 1);
        
        AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
        layer.frame=self.view.layer.bounds;
        [self.view.layer insertSublayer:layer atIndex:0];
        //开始捕获
        [_session startRunning];
    }
    
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    NSLog(@"==test==");
    
    if (metadataObjects.count>0) {
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        NSLog(@"扫描结果:%@",metadataObject.stringValue);
        
        [self findDrugByCodeNum:metadataObject.stringValue];
        
        [_session stopRunning];
    }else{
        
        _alert.message = @"扫描失败,请重试";
        [_session stopRunning];
    }
}

#pragma mark 扫描结束
- (void)findDrugByCodeNum:(NSString *)codeNum{
    
    [self HUDStart];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:API_DRUG_CODE parameters:@{@"code":codeNum} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self HUDEnd];
        [self downloadSuccess:responseObject andCode:codeNum];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

#pragma mark - 下载完成后调用
- (void)downloadSuccess:(id)data andCode:(NSString *)codeNum{
    
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"%@",dict);
    
    BOOL hasId = NO;
    
    for (NSString * key in [dict allKeys]) {
        
        hasId = [key isEqualToString:@"id"] ? YES : NO;
        
        if (hasId) {
            
            break;
        }
    }
    if (hasId) {
        self.hidesBottomBarWhenPushed = YES;
        ShowDetailViewController * showVc = [[ShowDetailViewController alloc] init];
        showVc.title = @"药品详情";
        showVc.ids = [dict objectForKey:@"id"];
        showVc.typeName = ShowDetailDrug;
        [self.navigationController pushViewController:showVc animated:YES];
        self.hidesBottomBarWhenPushed = YES;
    }else{
        
        _alert.message = [NSString stringWithFormat:@"抱歉,在服务器中未查询到您扫描的条码(%@)",codeNum];
        [_alert show];
    }
    
}

#pragma mark - 弹窗方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        
        if (!_hasInput) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [_session startRunning];
        }
    }
}

#pragma mark - 加载栏
- (void)HUDStart{
    _HUD=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    _HUD.labelText=@"加载中";
    _HUD.labelColor=[UIColor whiteColor];
    _HUD.color=[UIColor grayColor];
    //    _HUD.dimBackground=YES;
}

- (void)HUDEnd{
    
    [_HUD hide:YES afterDelay:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
