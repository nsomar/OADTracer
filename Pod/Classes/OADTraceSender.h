//
//  OADTraceSender.h
//  Pods
//
//  Created by Omar Abdelhafith on 17/12/2014.
//
//

#import <Foundation/Foundation.h>

@protocol OADTraceSender <NSObject>

- (BOOL)isTraceingEnabled;
- (void)sendStringTrace:(NSString*)traceString;

@end