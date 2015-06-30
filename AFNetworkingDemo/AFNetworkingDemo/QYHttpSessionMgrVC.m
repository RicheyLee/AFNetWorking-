//
//  QYHttpSessionMgrVC.m
//  AFNetworkingDemo
//
//  Created by qingyun on 14-11-28.
//  Copyright (c) 2014年 hnqingyun. All rights reserved.
//

#import "QYHttpSessionMgrVC.h"
#import "AFNetworking/AFHTTPSessionManager.h"
#import "common.h"

@interface QYHttpSessionMgrVC ()

@end

@implementation QYHttpSessionMgrVC

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

- (IBAction)getRequst:(id)sender {
    
}

- (IBAction)postRequest:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"request_post_body_http.json"];
   // NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"register.php"];
    
    NSDictionary *parameters = @{@"foo":@"bar"};
    
    [manager POST:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (IBAction)mutiPartPost:(id)sender {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
   // NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"upload2server.json"];
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"register.php"];

    
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(NSURLSessionDataTask *task, id responseObject) {

    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}
@end
