//
//  XMCaptureCamera.h
//  XMAAC
//
//  Created by mifit on 2018/1/22.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
@class CALayer;

@protocol XMCaptureCameraDelegate <NSObject>
@optional
- (void)didOutputVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer;
- (void)didOutputAudioSampleBuffer:(CMSampleBufferRef)sampleBuffer;
@end

@interface XMCaptureCamera : NSObject
@property (nonatomic, weak) id<XMCaptureCameraDelegate> delegate;
@property (nonatomic, assign) BOOL isFront;//default：NO
@property (nonatomic, assign) BOOL isPortrait;//default：YES
@property (nonatomic, copy) AVCaptureSessionPreset preset;//default：AVCaptureSessionPreset1280x720

- (instancetype)initWithPreview:(CALayer *)layer;
- (void)updatePreviewBounds:(CGRect)bounds;
- (BOOL)startCapture;
- (void)pauseCapture;
@end
