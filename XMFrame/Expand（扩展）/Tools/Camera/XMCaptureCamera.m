//
//  XMCaptureCamera.m
//  XMAAC
//
//  Created by mifit on 2018/1/22.
//  Copyright © 2018年 Mifit. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "XMCaptureCamera.h"
#import "XMCaptureDevice.h"



@interface XMCaptureCamera()
<
AVCaptureVideoDataOutputSampleBufferDelegate,
AVCaptureAudioDataOutputSampleBufferDelegate
>
{
    BOOL m_captureIsRunging;
    AVCaptureSession *m_capSession;
    AVCaptureDevice *m_videoDevice;
    AVCaptureDevice *m_audioDevice;
    AVCaptureDeviceInput *m_videoInput;
    AVCaptureDeviceInput *m_audioInput;
    AVCaptureAudioDataOutput *m_audioOutput;
    AVCaptureVideoDataOutput *m_videoOutput;
    dispatch_queue_t m_dataOutputQueue;
    AVCaptureVideoPreviewLayer *m_showlayer;
    
    
}
@end

@implementation XMCaptureCamera
#pragma mark - life circle
- (instancetype)initWithPreview:(CALayer *)layer {
    if (self = [super init]) {
        _isFront = NO;
        _isPortrait = YES;
        m_captureIsRunging = NO;
        _preset = AVCaptureSessionPreset1280x720;
        m_capSession = [[AVCaptureSession alloc]init];
        [m_capSession stopRunning];
        m_videoDevice = [XMCaptureDevice backCameraDevice];
        m_showlayer = [AVCaptureVideoPreviewLayer layerWithSession:m_capSession];
        [m_showlayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        m_showlayer.frame = layer.bounds;
        [self updatePrelayer];
        [layer addSublayer:m_showlayer];

        NSNotificationCenter *nCenter = [NSNotificationCenter defaultCenter];
        [nCenter addObserver:self selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication]];
        [nCenter addObserver:self selector:@selector(willEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
        [nCenter addObserver:self selector:@selector(orientationDidChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    if (m_showlayer) {
        [m_showlayer removeFromSuperlayer];
        m_showlayer = nil;
    }
    m_capSession = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark notification
- (void)didEnterBackground:(id)sender {
    [m_capSession stopRunning];
}
- (void)willEnterForeground:(id)sender {
    if (m_captureIsRunging) {
        [m_capSession startRunning];
    }
}
- (void)orientationDidChanged:(id)sender {
    UIDevice *device = [UIDevice currentDevice];
    self.isPortrait = UIDeviceOrientationIsPortrait(device.orientation);
    [self updatePrelayer];
}

#pragma mark - public
- (void)updatePreviewBounds:(CGRect)bounds {
    m_showlayer.frame = bounds;
}
- (BOOL)startCapture {
    if (m_captureIsRunging) {
        return YES;
    }
    NSError *error = nil;
    [m_capSession stopRunning];
    [m_capSession beginConfiguration];
    m_videoInput = [AVCaptureDeviceInput deviceInputWithDevice:m_videoDevice error:&error];
    if (error) {
        return NO;
    }
    if ([m_capSession canAddInput:m_videoInput]) {
        [m_capSession addInput:m_videoInput];
    }
    
    m_audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    m_audioInput = [AVCaptureDeviceInput deviceInputWithDevice:m_audioDevice error:&error];
    if (error) {
        return NO;
    }
    if ([m_capSession canAddInput:m_audioInput]) {
        [m_capSession addInput:m_audioInput];
    }
    
    if ([m_capSession canSetSessionPreset:self.preset]) {
        [m_capSession setSessionPreset:self.preset];
    }
    
    m_videoOutput = [[AVCaptureVideoDataOutput alloc]init];
    m_videoOutput.alwaysDiscardsLateVideoFrames = NO;
    m_videoOutput.videoSettings = @{(NSString *)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)};
    m_dataOutputQueue = dispatch_queue_create("com.mifit.video.output.data.queue", DISPATCH_QUEUE_CONCURRENT);
    [m_videoOutput setSampleBufferDelegate:self queue:m_dataOutputQueue];
    if ([m_capSession canAddOutput:m_videoOutput]) {
        [m_capSession addOutput:m_videoOutput];
        AVCaptureVideoOrientation orientation;
        if (self.isPortrait) {
            orientation = AVCaptureVideoOrientationPortrait;
        } else {
            orientation = AVCaptureVideoOrientationLandscapeRight;
        }
        [[m_videoOutput connectionWithMediaType:AVMediaTypeVideo]setVideoOrientation:orientation];
    }
    
    m_audioOutput = [[AVCaptureAudioDataOutput alloc]init];
    [m_audioOutput setSampleBufferDelegate:self queue:m_dataOutputQueue];
    if ([m_capSession canAddOutput:m_audioOutput]) {
        [m_capSession addOutput:m_audioOutput];
    }
    
    [m_capSession commitConfiguration];
    
    [m_capSession startRunning];
    m_captureIsRunging = YES;
    return YES;
}

- (void)pauseCapture {
    [m_capSession stopRunning];
    m_captureIsRunging = NO;
}

#pragma mark - private
- (void)updatePrelayer {
    if (_isPortrait) {
        [[m_showlayer connection] setVideoOrientation:AVCaptureVideoOrientationPortrait];
        [m_videoOutput connectionWithMediaType:AVMediaTypeVideo].videoOrientation = AVCaptureVideoOrientationPortrait;
    } else {
        [[m_showlayer connection] setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
        [m_videoOutput connectionWithMediaType:AVMediaTypeVideo].videoOrientation = AVCaptureVideoOrientationLandscapeRight;
    }
}

- (void)removeAllInOutPut {
    if (m_audioOutput) {
        [m_capSession removeOutput:m_audioOutput];
        m_audioOutput = nil;
    }
    if (m_videoOutput) {
        [m_capSession removeOutput:m_videoOutput];
        m_videoOutput = nil;
    }
    if (m_audioInput) {
        [m_capSession removeInput:m_audioInput];
        m_audioInput = nil;
    }
    if (m_videoInput) {
        [m_capSession removeInput:m_videoInput];
        m_videoInput = nil;
    }
}
#pragma mark - data output delegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    if (output == m_videoOutput) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didOutputVideoSampleBuffer:)]) {
            [self.delegate didOutputVideoSampleBuffer:sampleBuffer];
        }
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didOutputAudioSampleBuffer:)]) {
            [self.delegate didOutputAudioSampleBuffer:sampleBuffer];
        }
    }
}
@end
