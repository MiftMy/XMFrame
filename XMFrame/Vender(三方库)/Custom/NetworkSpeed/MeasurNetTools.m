//
//  MeasurNetTools.m
//  
//
//  Created by jordan on 16/7/25.
//  Copyright © 2016年 MD313. All rights reserved.
//
#define start1 -0.33
#define urlString @"https://github.com/MiftMy/TestFile.git"//30M
//#define urlString @"http://dl.360safe.com/wifispeed/wifispeed.test"//3M
//#define urlString  [[MRHostsManager host] stringByAppendingString:@"/api/file/v01/downloadWithoutToken.do?index=100"]
//3M

#import "MeasurNetTools.h"

@interface MeasurNetTools ()
<
NSURLSessionDelegate
>
{
    measureBlock   infoBlock;
    finishMeasureBlock   fmeasureBlock;
    int                           _second;
    int64_t _totalReceive;
    NSDate *_beginTime;
}

@property (copy, nonatomic) void (^faildBlock) (NSError *error);

@end

@implementation MeasurNetTools

/**
 *  初始化测速方法
 *
 *  @param measureBlock       实时返回测速信息
 *  @param finishMeasureBlock 最后完成时候返回平均测速信息
 *
 *  @return MeasurNetTools对象
 */
- (instancetype)initWithblock:(measureBlock)measureBlock finishMeasureBlock:(finishMeasureBlock)finishMeasureBlock failedBlock:(void (^) (NSError *error))failedBlock
{
    self = [super init];
    if (self) {
        infoBlock = measureBlock;
        fmeasureBlock = finishMeasureBlock;
        _faildBlock = failedBlock;
    }
    return self;
}

/**
 *  开始测速
 */
-(void)startMeasur
{
    [self meausurNet];
}

/**
 *  停止测速，会通过block立即返回测试信息
 */
-(void)stopMeasur
{
    [self finishMeasure];
}

-(void)meausurNet
{
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
    NSURL    *url = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 3;
    //使用配置的NSURLSessionConfiguration获取NSSession，并且设置委托
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url];
    
    //开始任务
    [task resume];
    _beginTime = [NSDate new];
    _second = 0;
    _totalReceive = 0;
}

/**
 * 测速完成
 */
-(void)finishMeasure{
    if(_second > 0){
        float finishSpeed = _totalReceive / _second;
        fmeasureBlock(finishSpeed);
    } else {
        fmeasureBlock(_totalReceive);
    }
}

#pragma mark -  delegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    NSLog(@"receive: %lld",bytesWritten);
    _totalReceive += totalBytesWritten;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSTimeInterval span = [_beginTime timeIntervalSinceNow];
    _second = -span;
    [self finishMeasure];
}

//任务结束
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    if (self.faildBlock) {
        self.faildBlock(error);
    }
}

#pragma mark - urlconnect delegate methods

- (void)dealloc
{
    NSLog(@"MeasurNetTools dealloc");
}


@end
