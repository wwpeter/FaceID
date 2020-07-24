//
//  WM_HeaderFaceRecognitionView.m
//  SSKJ
//
//  Created by YinGuang on 2020/6/13.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "WM_HeaderFaceRecognitionView.h"
#import <AVFoundation/AVFoundation.h>
#import "NSObject+FactoryClass.h"

API_AVAILABLE(ios(10.0))
API_AVAILABLE(ios(10.0))
@interface WM_HeaderFaceRecognitionView ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,strong) AVCaptureSession *session;

@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;    //原始视频帧，用于获取实时图像以及视频录制

@property (nonatomic, strong) UIView *groundView;//底部view

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) UIView *circleView;

@property (nonatomic, strong) UIImageView *circileImg;

//@property (nonatomic, strong) UIImageView *circileImgww;

@property (nonatomic, assign) BOOL successful;
@property (nonatomic, assign) BOOL progress;
@property (nonatomic, strong) UIImage *imgTemp;

@property (nonatomic, strong) UILabel *tishiLable;//提示


@end
@implementation WM_HeaderFaceRecognitionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
- (void)dealloc {
  
}
- (UIImage *)imgTemp {
    if (!_imgTemp) {
        _imgTemp = [UIImage new];
    }
   return _imgTemp;
}
- (void)initViews {
    [self addSubview:self.groundView];
    [self.groundView addSubview:self.titleLabel];
    [self addSubview:self.bottomLabel];
    //设置有效扫描区域
    
     [self faceDeviceInit];//扫描
    [self.groundView addSubview:self.circleView];
   
      self.tishiLable = [self createLabel:@"" FontTemp:[UIFont systemFontOfSize:15] textColor:[UIColor redColor] textAlignment:1 numberOfLines:1];
    
    self.tishiLable.frame = CGRectMake(ScaleW(0), ScaleW(284), ScreenWidth-ScaleW(0), ScaleW(20));
    [self addSubview:self.tishiLable];
    [self.groundView addSubview:self.circileImg];
    [self addShadowToView:self.groundView withColor:UIColorFromRGB(0x2E354D)];
    
  
}
- (UIView *)groundView {
    if (!_groundView) {
        _groundView = [self createView:kMainWihteColor];
        _groundView.layer.cornerRadius = 5;
        _groundView.frame = CGRectMake(ScaleW(15), ScaleW(10), ScreenWidth-ScaleW(30), ScaleW(345.5));
    }
    return _groundView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [self createLabel:@"请衣着整齐，平时屏幕，并正对光源" FontTemp:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] textAlignment:1 numberOfLines:1];
        _titleLabel.frame = CGRectMake(ScaleW(0), ScaleW(19.5), ScreenWidth-ScaleW(30), ScaleW(19));
    }
    return _titleLabel;
}
- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [self createLabel:@"请确保为本人操作" FontTemp:[UIFont systemFontOfSize:12] textColor:kSubTextColor textAlignment:1 numberOfLines:1];
        _bottomLabel.frame = CGRectMake(ScaleW(0), ScaleW(314), ScreenWidth-ScaleW(0), ScaleW(17));
    }
    return _bottomLabel;
}
- (UIView *)circleView {
    if (!_circleView) {
        _circleView = [[UIView alloc] init];
        _circleView.backgroundColor = [UIColor clearColor];
        _circleView.layer.cornerRadius = ScaleW(100);
        _circleView.frame = CGRectMake((ScreenWidth-ScaleW(30))/2-ScaleW(100), ScaleW(65), ScaleW(200), ScaleW(200));
        _circleView.layer.borderColor = UIColorFromRGB(0x191919).CGColor;
        _circleView.layer.borderWidth = ScaleW(1.5);
    }
    return _circleView;;
}
- (UIImageView *)circileImg {
    if (!_circileImg) {
        _circileImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_face"]];
        _circileImg.frame = CGRectMake((ScreenWidth-ScaleW(30))/2-ScaleW(90), ScaleW(75), ScaleW(180), ScaleW(180));
       
         CABasicAnimation *layer = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
         layer.toValue = @(2*M_PI);
         layer.duration = 5;
         layer.removedOnCompletion = false;
         layer.repeatCount = MAXFLOAT;
         [_circileImg.layer addAnimation:layer forKey:nil];
    }
    return _circileImg;;
}

#pragma mark- 补货人脸
//摄像头相关设置
-(void)faceDeviceInit{
        //1.获取输入设备（摄像头）
        NSArray *devices = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront].devices;
        AVCaptureDevice *deviceF = devices[0];
        
        
        //2.根据输入设备创建输入对象
        AVCaptureDeviceInput*input = [[AVCaptureDeviceInput alloc] initWithDevice:deviceF error:nil];
        
        //3.创建原数据的输出对象
        AVCaptureMetadataOutput *metaout = [[AVCaptureMetadataOutput alloc] init];
        
        
        
        //4.设置代理监听输出对象输出的数据，在主线程中刷新
        [metaout setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        self.session = [[AVCaptureSession alloc] init];
        
        //5.设置输出质量(高像素输出)
        if ([self.session canSetSessionPreset:AVCaptureSessionPreset640x480]) {
            [self.session setSessionPreset:AVCaptureSessionPreset640x480];
        }
        
        //6.添加输入和输出到会话
        [self.session beginConfiguration];
        if ([self.session canAddInput:input]) {
            [self.session addInput:input];
        }
        if ([self.session canAddOutput:metaout]) {
            [self.session addOutput:metaout];
        }
        
        if ([_session canAddOutput:self.videoDataOutput]) {
               [_session addOutput:self.videoDataOutput];
        }
        [self.session commitConfiguration];
        
        //7.告诉输出对象要输出什么样的数据,识别人脸, 最多可识别10张人脸
        [metaout setMetadataObjectTypes:@[AVMetadataObjectTypeFace]];
        
        AVCaptureSession *session = (AVCaptureSession *)self.session;
        
        //8.创建预览图层
          _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
          _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _previewLayer.frame = CGRectMake((ScreenWidth-ScaleW(30))/2-ScaleW(100), ScaleW(65), ScaleW(200), ScaleW(200));
          _previewLayer.cornerRadius = 100;
          [self.groundView.layer insertSublayer:_previewLayer atIndex:0];
        
        //9.设置有效扫描区域(默认整个屏幕区域)（每个取值0~1, 以屏幕右上角为坐标原点）
        metaout.rectOfInterest = self.bounds;
        
        //前置摄像头一定要设置一下 要不然画面是镜像
        for (AVCaptureVideoDataOutput* output in session.outputs) {
            for (AVCaptureConnection * av in output.connections) {
                //判断是否是前置摄像头状态
                if (av.supportsVideoMirroring) {
                    //镜像设置
                    av.videoOrientation = AVCaptureVideoOrientationPortrait;
    //                av.videoMirrored = YES;
                }
            }
        }
        
        //10. 开始扫描
        [self.session startRunning];
        
    
    
}


// 
-(void)requestAvatarWithImage:(UIImage *)image{
        NSDictionary *params = @{
                         @"face":UIImageJPEGRepresentation(image, 0.5),
                         };
//    WS(weakSelf);
//
//    [[WLHttpManager shareManager] upLoadImageByUrlTemp:WM_ShopFaceidAdd_URL ParamsTenp:nil imageDicTemp:params CallBackTemp:^(id responseObject) {
//        if (!weakSelf.successful) {
//            [MBProgressHUD showError:@"认证通过"];
//        }
     
      
//      self.successful = YES;
//      [self.session stopRunning];
//      self.previewLayer = nil;
//         if (self.faceBlock) {
//             self.faceBlock();
//         }
//        weakSelf.progress = NO;
//    } FailureTemp:^(NSError *error, id responseObject) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.tishiLable.text = [WLTools nsNULLToString:responseObject[@"message"]];//
//        });
//        weakSelf.progress = NO;
//    }];
}
- (void)endDeal {
     [self.session stopRunning];
    self.previewLayer = nil;
  
}

- (void)cleanupSelfReferencecleanupSelfReference {
   
    self.progress = YES;
    [self requestAvatarWithImage:self.imgTemp];
    
}

#pragma mark - ww
-(AVCaptureVideoDataOutput *)videoDataOutput{
    if (_videoDataOutput == nil) {
        _videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
        [_videoDataOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];

        [_videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    }
    return _videoDataOutput;
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count>1) {
        self.tishiLable.text = @"必须一个人进行人脸识别~";
        return;
    } else {
        for(AVMetadataObject *metaObject in metadataObjects){
              
             if([metaObject isKindOfClass:[AVMetadataFaceObject class ]] && metaObject.type == AVMetadataObjectTypeFace){
                 if (!_successful) {
                     if (!self.progress) {
                         //进行网络请求
                          [self cleanupSelfReferencecleanupSelfReference];
                     }
                     
                 }

             } else {
                 self.tishiLable.text = @"未检测到人脸~";
             }
         }
    }
  
}
- (UIImage*)imageFromPixelBuffer:(CMSampleBufferRef)p {
    CVImageBufferRef buffer;
    buffer = CMSampleBufferGetImageBuffer(p);

    CVPixelBufferLockBaseAddress(buffer, 0);
    uint8_t *base;
    size_t width, height, bytesPerRow;
    base = (uint8_t *)CVPixelBufferGetBaseAddress(buffer);
    width = CVPixelBufferGetWidth(buffer);
    height = CVPixelBufferGetHeight(buffer);
    bytesPerRow = CVPixelBufferGetBytesPerRow(buffer);

    CGColorSpaceRef colorSpace;
    CGContextRef cgContext;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    cgContext = CGBitmapContextCreate(base, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);

    CGImageRef cgImage;
    UIImage *image;
    cgImage = CGBitmapContextCreateImage(cgContext);
    image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGContextRelease(cgContext);

    CVPixelBufferUnlockBaseAddress(buffer, 0);


    return image;
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{

    [connection setVideoOrientation:AVCaptureVideoOrientationPortrait];

    
    self.imgTemp = [self imageFromSampleBuffer:sampleBuffer];

}

-(UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    // 为媒体数据设置一个CMSampleBuffer的Core Video图像缓存对象
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // 锁定pixel buffer的基地址
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    // 得到pixel buffer的基地址
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    // 得到pixel buffer的行字节数
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // 得到pixel buffer的宽和高
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    // 创建一个依赖于设备的RGB颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 用抽样缓存的数据创建一个位图格式的图形上下文（graphics context）对象
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // 根据这个位图context中的像素数据创建一个Quartz image对象
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // 解锁pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    // 释放context和颜色空间
    CGContextRelease(context); CGColorSpaceRelease(colorSpace);
    // 用Quartz image创建一个UIImage对象image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    // 释放Quartz image对象
    CGImageRelease(quartzImage);
    return (image);
}


- (UIImage *)screenShot {
    
   return nil;
}
@end
