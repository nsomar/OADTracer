//
//  OANSURLRequestLoggingAggregator.m
//  Pods
//
//  Created by Omar Abdelhafith on 14/12/2014.
//
//

#import "OADTraceResponseSender.h"
#import "net-provider.h"

@implementation OADTraceResponseSender

- (void)sendDTraceForResponse:(NSURLResponse*)response data:(NSData*)data error:(NSError*)error {
  if ([self isTraceingEnabled]) {
    [self sendStringTrace:[self dtraceStringForResponse:response data:data error:error]];
  }
}

- (BOOL)isTraceingEnabled {
  return OADPROBE_RESPONSE_ENABLED();
}

- (void)sendStringTrace:(NSString*)traceString {
  OADPROBE_RESPONSE(traceString.UTF8String);
}

- (NSString*)dtraceStringForResponse:(NSURLResponse*)response data:(NSData*)data error:(NSError*)error {
  
  NSMutableDictionary *dictionary = [@{} mutableCopy];
  
  if (response && [response isKindOfClass:[NSHTTPURLResponse class]]) {
    [self appendResponse:(NSHTTPURLResponse*)response toDictionary:dictionary];
  }
                   
  if (data) {
    [self appendData:data toDictionary:dictionary];
  }
  
  if (error) {
    [self appendError:error toDictionary:dictionary];
  }
  
  return [self dictionaryToString:dictionary];
}

- (void)appendResponse:(NSHTTPURLResponse*)response toDictionary:(NSMutableDictionary*)dictionary {
 
  dictionary[@"statusCode"] = @([response statusCode]);
  
  if ([response URL]) {
    dictionary[@"url"] = [[response URL] absoluteString];
  }
  
  id cookies = [self cookieDictionaryForRequest:response];
  if (cookies) {
    dictionary[@"cookies"] = cookies;
  }
  
  id headers = [response allHeaderFields];
  if (headers) {
    dictionary[@"headers"] = headers;
  }
}

- (void)appendError:(NSError*)error toDictionary:(NSMutableDictionary*)dictionary {
  if (error) {
    dictionary[@"error"] = @{@"errorCode":@(error.code),
                             @"localizedDescription":error.localizedDescription};
  }
}

- (void)appendData:(NSData*)data toDictionary:(NSMutableDictionary*)dictionary {
  if (data.length > 0) {
    dictionary[@"body"] = [self stringForData:data];
  }
}

- (NSMutableDictionary*)cookieDictionaryForRequest:(NSHTTPURLResponse*)response {
  if (![response URL]) { return nil; }
  
  NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[response URL]];
  if (cookies.count == 0) { return nil; }
  
  NSMutableDictionary *dic = [@{} mutableCopy];
  for (NSHTTPCookie *cookie in cookies) {
    [dic setValue:[cookie value] forKey:[cookie name]];
  }
  
  return dic;
}

- (NSString*)stringForData:(NSData*)data {
  return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString*)dictionaryToString:(NSDictionary*)dictionary {
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
  NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  return string;
}

@end