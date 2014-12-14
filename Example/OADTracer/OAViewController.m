//
//  OAViewController.m
//  OADTracer
//
//  Created by Omar Abdelhafith on 12/14/2014.
//  Copyright (c) 2014 Omar Abdelhafith. All rights reserved.
//

#import "OAViewController.h"
#import <OADTracer.h>

@interface OAViewController ()

@end

@implementation OAViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)sendRequestDtrace:(id)sender {
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com"]];
  
  [[OADTracer instance] traceRequest:request];
  
  [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    [[OADTracer instance] traceResponse:response data:data error:error];
  }] resume];
}

- (IBAction)sendStringDtrace:(id)sender {
  [[OADTracer instance] traceString:@"Some string"];
}

@end
