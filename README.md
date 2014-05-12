# CSNRequestModificationProtocol

[![CocoaPods](http://img.shields.io/cocoapods/v/CSNRequestModificationProtocol.svg)](http://cocoadocs.org/docsets/CSNRequestModificationProtocol/)
![](http://img.shields.io/badge/license-MIT-green.svg)

## Overview

`CSNRequestModificationProtocol` provides chance to modify Request in 'URL Loading System'. It means you can change request even if `UIWebView`'s.

## Requirements

* iOS 6 or Later
* ARC

## Usage

```objc
[CSNRequestModificationProtocol addRule:[CSNRequestModificationBlockRule ruleWithIsInterestRequestBlock:^BOOL(NSURLRequest *request) {
    return YES;
} modifyRequestBlock:^void(NSURLRequest *request, NSMutableURLRequest *modifiedRequest) {
    [modifiedRequest addValue:@"sample-value" forHTTPHeaderField:@"x-Block"];
}]];
[NSURLProtocol registerClass:[CSNRequestModificationProtocol class]];
```

You can create own class that confirms to `CSNRequestModificationRule` protocol.

```objc
[CSNRequestModificationProtocol addRule:[[AddHeaderRule alloc] init]];
[NSURLProtocol registerClass:[CSNRequestModificationProtocol class]];
```

You can add some rules to `CSNRequestModificationProtocol` class. every rules can chance to modify request if interests.

## Install

Use CocoaPods,

```ruby
pod 'CSNRequestModificationProtocol', '~> 0.0.1'
```

## License

The MIT License (MIT)

Copyright (c) 2014 griffin-stewie

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
