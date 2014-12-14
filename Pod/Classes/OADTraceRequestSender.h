//
//  OADTraceRequestSender.h
//  Pods
//
//  Created by Omar Abdelhafith on 14/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "OADTraceSender.h"

@interface OADTraceRequestSender : NSObject <OADTraceSender>
- (void)sendDTraceForRequest:(NSURLRequest*)request;
@end