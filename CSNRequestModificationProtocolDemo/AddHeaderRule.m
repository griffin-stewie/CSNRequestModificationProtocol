//
//  AddHeaderRule.m
//  CSNRequestModificationProtocolDemo
//
//  Created by griffin_stewie on 2014/05/11.
//  Copyright (c) 2014年 net.cyan-stivy. All rights reserved.
//

#import "AddHeaderRule.h"

@implementation AddHeaderRule
- (BOOL)isInterestRequest:(NSURLRequest *)request
{
    return YES;
}

- (void)modifyRequestForRequest:(NSURLRequest *)request modifiedRequest:(NSMutableURLRequest *)modifiedRequest
{
    [modifiedRequest addValue:@"sample-value" forHTTPHeaderField:@"x-CSNRequestModificationRule"];
}
@end
