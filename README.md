# FaceID
人脸识别，获取到人脸之后转换成uiimage 和后台进行交互


https://img-blog.csdnimg.cn/202007241743106.png

博客地址：https://blog.csdn.net/super_man_ww/article/details/107566290


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
————————————————
版权声明：本文为CSDN博主「super_man_风清扬」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/super_man_ww/article/details/107566290
