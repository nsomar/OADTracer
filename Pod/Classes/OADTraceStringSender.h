//
//  aaaa.h
//  Pods
//
//  Created by Omar Abdelhafith on 14/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "OADTraceSender.h"

@interface OADTraceStringSender : NSObject <OADTraceSender>
- (void)sendDTraceForString:(NSString*)string;
@end