//
//  OANSURLRequestLoggingAggregator.h
//  Pods
//
//  Created by Omar Abdelhafith on 14/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "OADTraceSender.h"

@interface OADTraceResponseSender : NSObject <OADTraceSender>
- (void)sendDTraceForResponse:(NSURLResponse*)response data:(NSData*)data error:(NSError*)error;
@end