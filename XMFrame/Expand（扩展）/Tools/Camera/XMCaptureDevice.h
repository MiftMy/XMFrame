//
//  XMCaptureDevice.h
//  AreoxPlay
//
//  Created by mifit on 2017/4/13.
//  Copyright © 2017年 Mifit. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface XMCaptureDevice : NSObject
/*
 *  获取前/后置摄像头
 */
+ (AVCaptureDevice *)frontCameraDevice;//前置
+ (AVCaptureDevice *)backCameraDevice;//后置
+ (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position;//指定位置

/*
 *  设置设备的帧率
 */
+ (void)setDevice:(AVCaptureDevice *)dev fps:(NSInteger) fps;
+ (void)defaultFPS:(AVCaptureDevice *)dev;//默认30

/*
 *  zoom 设置
 */
+ (void)resetDeviceZoom:(AVCaptureDevice *)device;
+ (void)deviceZoomUp:(AVCaptureDevice *)device;
+ (void)deviceZomIn:(AVCaptureDevice *)device;
+ (void)device:(AVCaptureDevice *)device zooming:(CGFloat)zoom;

/*
 *  设置ISO 白平衡 曝光量EV
 */
+ (void)cameraISOSetting:(NSInteger)index atDevice:(AVCaptureDevice *)device;
+ (void)cameraWhiteBSetting:(NSInteger)index atDevice:(AVCaptureDevice *)device;
+ (void)cameraEVSetting:(NSInteger)index atDevice:(AVCaptureDevice *)device;
+ (void)cameraEVPosition:(CGPoint)point atDevice:(AVCaptureDevice *)device;

//焦距
+ (void)cameraFocus:(AVCaptureFocusMode)fMode atDevice:(AVCaptureDevice *)device;
+ (void)cameraFocusPosition:(CGPoint)point atDevice:(AVCaptureDevice *)device;
+ (void)defaultFocusMode:(AVCaptureDevice *)device;

//聚焦曝光
+ (void)adjustAt:(CGPoint)point atDevice:(AVCaptureDevice *)device;
+ (void)adjustDefaultAtDevice:(AVCaptureDevice *)device;

//Torch
+ (void)torchMode:(AVCaptureTorchMode)mode atDevice:(AVCaptureDevice *)device;

//Flash  10.0不同
+ (void)flashMode:(AVCaptureFlashMode)mode atDevice:(AVCaptureDevice *)device;

//HDR
+ (void)hdrEnable:(BOOL)isEnable atDevice:(AVCaptureDevice *)device;
@end
