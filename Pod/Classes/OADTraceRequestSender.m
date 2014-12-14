//
//  OADTraceRequestSender.m
//  Pods
//
//  Created by Omar Abdelhafith on 14/12/2014.
//
//

#import "OADTraceRequestSender.h"
#import "net-provider.h"

@implementation OADTraceRequestSender

- (void)sendDTraceForRequest:(NSURLRequest*)request {
  if ([self isTraceingEnabled]) {
    [self sendStringTrace:[self dtraceStringForRequest:request]];
  }
}

- (BOOL)isTraceingEnabled {
  return OADPROBE_REQUEST_ENABLED();
}

- (void)sendStringTrace:(NSString*)traceString {
  OADPROBE_REQUEST(traceString.UTF8String);
}

- (NSString*)dtraceStringForRequest:(NSURLRequest*)request {
  NSMutableDictionary *dic = [@{} mutableCopy];
  
  dic[@"method"] = [request HTTPMethod];
  
  if ([request URL]) {
    dic[@"url"] = [[request URL] absoluteString];
  }
  
  id cookies = [self cookieDictionaryForRequest:request];
  if (cookies) {
    dic[@"cookies"] = cookies;
  }
  
  id headers = [request allHTTPHeaderFields];
  if (headers) {
    dic[@"headers"] = headers;
  }
  
  id body = [self bodyStringForRequest:request];
  if (body) {
    dic[@"body"] = body;
  }
  
  NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
  NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  return string;
}

- (NSMutableDictionary*)cookieDictionaryForRequest:(NSURLRequest*)request {
  if (![request URL]) { return nil; }
  
  NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[request URL]];
  if (cookies.count == 0) { return nil; }
  
  NSMutableDictionary *dic = [@{} mutableCopy];
  for (NSHTTPCookie *cookie in cookies) {
    [dic setValue:[cookie value] forKey:[cookie name]];
  }
  
  return dic;
}

- (NSString*)bodyStringForRequest:(NSURLRequest*)request {
  if ([[request HTTPBody] length] == 0) { return nil; }
  
  NSMutableString *HTTPBodyString = [[NSMutableString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
  return HTTPBodyString;
}

@end