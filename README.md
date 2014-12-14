# OADTracer

[![CI Status](http://img.shields.io/travis/Omar Abdelhafith/OADTracer.svg?style=flat)](https://travis-ci.org/Omar Abdelhafith/OADTracer)
[![Version](https://img.shields.io/cocoapods/v/OADTracer.svg?style=flat)](http://cocoadocs.org/docsets/OADTracer)
[![License](https://img.shields.io/cocoapods/l/OADTracer.svg?style=flat)](http://cocoadocs.org/docsets/OADTracer)
[![Platform](https://img.shields.io/cocoapods/p/OADTracer.svg?style=flat)](http://cocoadocs.org/docsets/OADTracer)

OADTracer is an objective c library that facilitates the sending of DTrace events. OADTracer exposes methods for sending `NSURLRequest` and `NSURLResponse` as JSON strings to DTRace.

## Why use DTrace?

One good usage of DTrace is to log the network communicate instead of polluting the Xcode console.

Using DTrace to log network communication has the following benefits:

- Avoids Xcode console pollution with network logs.
- Extremely cheap; probes that are not being listened do not add any performance overhead.

## Usage


### Sending DTrace events

OADTracer exposes three method to send DTrace events.

Using `[OADTracer traceRequest:]`, `NSURLRequest` are packaged and sent as JSON to `oadprobe:::request` probe.

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com"]];
  
    [[OADTracer instance] traceRequest:request];


Using `[OADTracer traceResponse:data:error]`, `NSURLResponse`, `NSData` and `NSError` are group and sent as JSON to `oadprobe:::response` probe.

    [[OADTracer instance] traceResponse:response data:data error:error];
response, data and error are passed with the callback of `[NSURLSession dataTaskWithRequest]`
	 
Using `[OADTracer traceString:]`, `NSString` is sent to `oadprobe:::custom` probe.

    [[OADTracer instance] traceString:@"Some string"];


### Listening to DTrace events

To listen to the DTrace command sent, you can either use the `dtrace` command, a good explanation on how to do that is [here](http://www.objc.io/issue-19/dtrace.html), or you can use [`dtracer` gem](https://github.com/oarrabi/dtracer).

#### DTracer gem

`dtracer` gem was written to be conveniently used with `OADTracer` library. `dtracer` provides equivalent commands to register and print the DTrace events sent.

`dtracer` provides the following commands:

	dtracer curl

Outputs the `NSURLRequest` sent with `[OADTracer traceRequest:]` as a curl command


	dtracer details
Outputs the `NSURLRequest` sent with `[OADTracer traceRequest:]` as a formatted string. It also accepts multiple flags to customise the printed string. Run `dtracer help details` for additional info.


	dtracer response
Outputs the event sent with `[OADTracer traceResponse:data:error:]` as a formatted string.


	dtracer custom

Outputs the string sent with `[OADTracer traceString:]`.

Check [dtracer page](https://github.com/oarrabi/dtracer) form more info.  

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

OADTracer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "OADTracer"

## Author

Omar Abdelhafith, o.arrabi@me.com

## License

OADTracer is available under the MIT license. See the LICENSE file for more info.

