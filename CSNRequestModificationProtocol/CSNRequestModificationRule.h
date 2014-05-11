//
//  CSNRequestModificationRule.h
//  CSNRequestModificationProtocolDemo
//
//  Created by griffin_stewie on 2014/05/11.
//  Copyright (c) 2014年 net.cyan-stivy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CSNRequestModificationRule <NSObject>
- (BOOL)isInterestRequest:(NSURLRequest *)request;
- (void)modifyRequestForRequest:(NSURLRequest *)request modifiedRequest:(NSMutableURLRequest *)modifiedRequest;
@end
