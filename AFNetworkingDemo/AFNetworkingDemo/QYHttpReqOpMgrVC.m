//
//  QYHttpReqOpMgrVC.m
//  AFNetworkingDemo
//
//  Created by qingyun on 14-11-28.
//  Copyright (c) 2014年 hnqingyun. All rights reserved.
//

#import "QYHttpReqOpMgrVC.h"
#import "AFHTTPRequestOperationManager.h"
#import "common.h"

@interface QYHttpReqOpMgrVC ()

@end

@implementation QYHttpReqOpMgrVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)getRequest:(id)sender {
    
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"request_get.json"];
    
    NSDictionary *parameters = @{@"foo":@"bar"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (IBAction)postURLFormEncodedReq:(id)sender {
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"request_post_body_http.json"];
    NSDictionary *parameters = @{@"foo":@"bar"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (IBAction)postMutiPartReq:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters = @{@"foo": @"bar"};
    
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"upload2server.json"];
    
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"1" withExtension:@"jpg"];
        
        [formData appendPartWithFileURL:fileURL name:@"image" fileName:@"sky.jpg" mimeType:@"image/jpeg" error:nil];
        
        fileURL = [[NSBundle mainBundle] URLForResource:@"2" withExtension:@"png"];
        
        [formData appendPartWithFileURL:fileURL name:@"image" fileName:@"beauti.png" mimeType:@"image/png" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
