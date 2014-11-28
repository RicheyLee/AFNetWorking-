//
//  QYURLSessionMgrVC.m
//  AFNetworkingDemo
//
//  Created by qingyun on 14-11-28.
//  Copyright (c) 2014年 hnqingyun. All rights reserved.
//

#import "QYURLSessionMgrVC.h"
#import "AFURLSessionManager.h"
#import "common.h"

@interface QYURLSessionMgrVC ()
@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *uploadProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *mutiPartProgress;

@end

@implementation QYURLSessionMgrVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)download:(id)sender {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
  

    NSURL *URL = [NSURL URLWithString:@"http://yinyueshiting.baidu.com/data2/music/3552945/34815711417140061128.mp3?xcode=f5ba05e50c9f1db6c0fa3d2f9a12af011b97be8d72cc2296&song_id=3481571"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSProgress *progress;
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        // 该Block的目的就是返回将来下载好的文件的存放的URL
        NSString *path = @"/Users/qingyun/Desktop";
        return [NSURL fileURLWithPath:[path stringByAppendingPathComponent:response.suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        // 该Block会在下载完成之后来回调
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
    
    [progress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:(__bridge void *)(_downloadProgress)];
    
    
}

- (IBAction)upload:(id)sender {
    
    
}

- (IBAction)mutiPartUpload:(id)sender {
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"upload2server.json"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 往formData中追加文件内容
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"2" withExtension:@"png"];
        [formData appendPartWithFileURL:fileURL name:@"image" fileName:@"meinv.png" mimeType:@"image/png" error:nil];
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    
    [uploadTask resume];
    
    [progress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:(__bridge void *)(_mutiPartProgress)];
}

- (IBAction)dataTask:(id)sender {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"completedUnitCount"]) {
        // 更新进度条
        dispatch_async(dispatch_get_main_queue(), ^{
            UIProgressView *progressView = (__bridge UIProgressView *)context;
            
            progressView.progress = [change[@"new"] floatValue] / [[object valueForKey:@"totalUnitCount"] floatValue];
        });
    }
}

@end
