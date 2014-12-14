//
//  OADTracer.m
//  Pods
//
//  Created by Omar Abdelhafith on 16/12/2014.
//
//

#import "OADTracer.h"
#import "OADTraceRequestSender.h"
#import "OADTraceResponseSender.h"
#import "OADTraceStringSender.h"

@interface OADTracer ()
@property (nonatomic, strong, readonly) OADTraceResponseSender *responseSender;
@property (nonatomic, strong, readonly) OADTraceRequestSender *requestSender;
@property (nonatomic, strong, readonly) OADTraceStringSender *stringSender;
@end

@implementation OADTracer

+ (OADTracer*)instance {
  static OADTracer *_sharedInstance = nil;
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    _sharedInstance = [OADTracer new];
  });
  
  return _sharedInstance;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _responseSender = [OADTraceResponseSender new];
    _requestSender = [OADTraceRequestSender new];
    _stringSender = [OADTraceStringSender new];
  }
  return self;
}

- (void)traceResponse:(NSURLResponse*)reponse data:(NSData*)data error:(NSError*)error {
  [self.responseSender sendDTraceForResponse:reponse data:data error:error];
}

- (void)traceRequest:(NSURLRequest*)request {
  [self.requestSender sendDTraceForRequest:request];
}

- (void)traceString:(NSString*)string {
  [self.stringSender sendDTraceForString:string];
}

@end
