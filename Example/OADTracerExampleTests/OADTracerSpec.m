//
//  OADTracerTests.m
//  OADTracerTests
//
//  Created by Omar Abdelhafith on 12/14/2014.
//  Copyright (c) 2014 Omar Abdelhafith. All rights reserved.
//

#import <Specta.h>
#import <OADTracer.h>
#import <OCMock.h>
#import <OADTraceStringSender.h>
#import <OADTraceRequestSender.h>
#import <OADTraceResponseSender.h>

@interface OADTracer ()
@property (nonatomic, strong, readonly) OADTraceResponseSender *responseSender;
@property (nonatomic, strong, readonly) OADTraceRequestSender *requestSender;
@property (nonatomic, strong, readonly) OADTraceStringSender *stringSender;
@end

SpecBegin(OADTracer)

describe(@"OADTracer", ^{
  
  context(@"Testitng OADTraceStringSender", ^{
    
    it(@"Sends the correct string as a DTRace", ^{
      
      OADTracer *mockTracer = OCMPartialMock([OADTracer instance]);
      
      id mockSender = OCMPartialMock([OADTraceStringSender new]);
      OCMStub([mockSender isTraceingEnabled]).andReturn(YES);
      OCMStub([mockTracer stringSender]).andReturn(mockSender);
      
      OCMExpect([mockSender sendStringTrace:@"Test Tracing"]);
      
      [mockTracer traceString:@"Test Tracing"];
      
      OCMVerifyAll(mockSender);
      
    });
    
  });
  
  context(@"Testitng OADTraceRequestSender", ^{
    
    it(@"Sends correct POST request to DTRace", ^{
      
      OADTracer *mockTracer = OCMPartialMock([OADTracer instance]);
      
      id mockSender = OCMPartialMock([OADTraceRequestSender new]);
      OCMStub([mockSender isTraceingEnabled]).andReturn(YES);
      OCMStub([mockTracer requestSender]).andReturn(mockSender);
      
      id url = [NSURL URLWithString:@"www.google.com"];
      NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
      
      [request setHTTPMethod:@"POST"];
      [request setValue:@"TEST" forHTTPHeaderField:@"TEST_HEADER_VAL"];
      [request setHTTPBody:[@"Test body data = test" dataUsingEncoding:NSUTF8StringEncoding]];
      
      OCMExpect([mockSender sendStringTrace:@"{\"method\":\"POST\",\"body\":\"Test body data = test\",\"url\":\"www.google.com\",\"headers\":{\"TEST_HEADER_VAL\":\"TEST\"}}"]);
      
      [mockTracer traceRequest:(NSURLRequest*)request];
      
      OCMVerifyAll(mockSender);
      
    });
    
    it(@"Sends correct GET request to DTRace", ^{
      
      OADTracer *mockTracer = OCMPartialMock([OADTracer instance]);
      
      id mockSender = OCMPartialMock([OADTraceRequestSender new]);
      OCMStub([mockSender isTraceingEnabled]).andReturn(YES);
      OCMStub([mockTracer requestSender]).andReturn(mockSender);
      
      id url = [NSURL URLWithString:@"www.google.com"];
      NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
      
      [request setHTTPMethod:@"GET"];
      [request setValue:@"TEST" forHTTPHeaderField:@"TEST_HEADER_VAL"];
      
      OCMExpect([mockSender sendStringTrace:@"{\"method\":\"GET\",\"url\":\"www.google.com\",\"headers\":{\"TEST_HEADER_VAL\":\"TEST\"}}"]);
      
      [mockTracer traceRequest:(NSURLRequest*)request];
      
      OCMVerifyAll(mockSender);
      
    });
    
  });
  
  context(@"Testitng OADTraceResponseSender", ^{
    
    it(@"Sends correct POST response to DTRace", ^{
      
      OADTracer *mockTracer = OCMPartialMock([OADTracer instance]);
      
      OADTraceResponseSender *mockSender = OCMPartialMock([OADTraceResponseSender new]);
      OCMStub([mockSender isTraceingEnabled]).andReturn(YES);
      OCMStub([mockTracer responseSender]).andReturn(mockSender);
      
      id url = [NSURL URLWithString:@"www.google.com"];
      NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:url
                                                                statusCode:200
                                                               HTTPVersion:@""
                                                              headerFields:@{@"TestKey":@"TestVal"}];
      
      OCMExpect([mockSender sendStringTrace:@"{\"url\":\"www.google.com\",\"headers\":{\"TestKey\":\"TestVal\"},\"statusCode\":200}"]);
      [mockTracer traceResponse:response data:nil error:nil];
      
      OCMVerifyAll((id)mockSender);
      
    });
    
    it(@"Sends correct POST with body response to DTRace", ^{
      
      OADTracer *mockTracer = OCMPartialMock([OADTracer instance]);
      
      OADTraceResponseSender *mockSender = OCMPartialMock([OADTraceResponseSender new]);
      OCMStub([mockSender isTraceingEnabled]).andReturn(YES);
      OCMStub([mockTracer responseSender]).andReturn(mockSender);
      
      id url = [NSURL URLWithString:@"www.google.com"];
      NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:url
                                                                statusCode:200
                                                               HTTPVersion:@""
                                                              headerFields:@{@"TestKey":@"TestVal"}];
      
      OCMExpect([mockSender sendStringTrace:@"{\"body\":\"{\\\"body\\\":\\\"value\\\"}\",\"url\":\"www.google.com\",\"headers\":{\"TestKey\":\"TestVal\"},\"statusCode\":200}"]);
      
      NSDictionary *dic = @{@"body":@"value"};
      NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
      [mockTracer traceResponse:response data:data error:nil];
      
      OCMVerifyAll((id)mockSender);
      
    });
    
    it(@"Sends the correct error if there is any to DTRace", ^{
      
      OADTracer *mockTracer = OCMPartialMock([OADTracer instance]);
      
      OADTraceResponseSender *mockSender = OCMPartialMock([OADTraceResponseSender new]);
      OCMStub([mockSender isTraceingEnabled]).andReturn(YES);
      OCMStub([mockTracer responseSender]).andReturn(mockSender);
      
      id url = [NSURL URLWithString:@"www.google.com"];
      NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:url
                                                                statusCode:200
                                                               HTTPVersion:@""
                                                              headerFields:@{@"TestKey":@"TestVal"}];
      
      OCMExpect([mockSender sendStringTrace:@"{\"error\":{\"localizedDescription\":\"The operation couldn’t be completed. (SomeDomain error 123.)\",\"errorCode\":123},\"url\":\"www.google.com\",\"headers\":{\"TestKey\":\"TestVal\"},\"statusCode\":200}"]);
      
      NSError *error = [NSError errorWithDomain:@"SomeDomain" code:123
                                       userInfo:@{@"Test":@"Key"}];
      
      [mockTracer traceResponse:response data:nil error:error];
      
      OCMVerifyAll((id)mockSender);
      
    });
    
    it(@"Sends the correct error and body if there are both to DTRace", ^{
      
      OADTracer *mockTracer = OCMPartialMock([OADTracer instance]);
      
      OADTraceResponseSender *mockSender = OCMPartialMock([OADTraceResponseSender new]);
      OCMStub([mockSender isTraceingEnabled]).andReturn(YES);
      OCMStub([mockTracer responseSender]).andReturn(mockSender);
      
      id url = [NSURL URLWithString:@"www.google.com"];
      NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:url
                                                                statusCode:200
                                                               HTTPVersion:@""
                                                              headerFields:@{@"TestKey":@"TestVal"}];
      
      OCMExpect([mockSender sendStringTrace:@"{\"body\":\"{\\\"body\\\":\\\"value\\\"}\",\"error\":{\"localizedDescription\":\"The operation couldn’t be completed. (SomeDomain error 123.)\",\"errorCode\":123},\"url\":\"www.google.com\",\"headers\":{\"TestKey\":\"TestVal\"},\"statusCode\":200}"]);
      
      NSError *error = [NSError errorWithDomain:@"SomeDomain" code:123
                                       userInfo:@{@"Test":@"Key"}];
      
      NSDictionary *dic = @{@"body":@"value"};
      NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
      
      [mockTracer traceResponse:response data:data error:error];
      
      OCMVerifyAll((id)mockSender);
      
    });
    
  });
});

SpecEnd
