//
//  OADTracer.h
//  Pods
//
//  Created by Omar Abdelhafith on 16/12/2014.
//
//

#import <Foundation/Foundation.h>

@interface OADTracer : NSObject

+ (OADTracer*)instance;

- (void)traceRequest:(NSURLRequest*)request;

- (void)traceResponse:(NSURLResponse*)reponse data:(NSData*)data error:(NSError*)error;

- (void)traceString:(NSString*)string;

@end