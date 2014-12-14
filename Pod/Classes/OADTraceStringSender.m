//
//  aaaa.m
//  Pods
//
//  Created by Omar Abdelhafith on 14/12/2014.
//
//

#import "OADTraceStringSender.h"
#import "net-provider.h"

@implementation OADTraceStringSender

- (void)sendDTraceForString:(NSString*)string {
  if ([self isTraceingEnabled]) {
    [self sendStringTrace:string];
  }
}

- (BOOL)isTraceingEnabled {
  return OADPROBE_CUSTOM_ENABLED();
}

- (void)sendStringTrace:(NSString*)traceString {
  OADPROBE_CUSTOM(traceString.UTF8String);
}

@end