//
//  QYURLSessionMgrVC.m
//  AFNetworkingDemo
//
//  Created by qingyun on 14-11-28.
//  Copyright (c) 2014年 hnqingyun. All rights reserved.
//

#import "QYURLSessionMgrVC.h"

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
    
}

- (IBAction)upload:(id)sender {
    
}

- (IBAction)mutiPartUpload:(id)sender {
    
}

- (IBAction)dataTask:(id)sender {
    
}

@end
