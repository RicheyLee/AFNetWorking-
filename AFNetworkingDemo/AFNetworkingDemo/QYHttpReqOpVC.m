//
//  QYViewController.m
//  AFNetworkingDemo
//
//  Created by qingyun on 14-11-28.
//  Copyright (c) 2014年 hnqingyun. All rights reserved.
//

#import "QYHttpReqOpVC.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "common.h"

@interface QYHttpReqOpVC ()

@end

@implementation QYHttpReqOpVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)httpGetReq:(id)sender {
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"request_get.json"];
    
//    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSDictionary *parameters = @{@"foo":@"bar"};
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlStr parameters:parameters error:nil];
    
    NSLog(@"url:%@", request.URL);
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
     [[NSOperationQueue mainQueue] addOperation:op];
}
@end
