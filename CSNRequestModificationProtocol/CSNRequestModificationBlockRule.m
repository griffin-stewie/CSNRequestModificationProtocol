//
//  CSNRequestModificationBlockRule.m
//  CSNRequestModificationProtocolDemo
//
//  Created by griffin_stewie on 2014/05/12.
//  Copyright (c) 2014年 net.cyan-stivy. All rights reserved.
//

#import "CSNRequestModificationBlockRule.h"

@implementation CSNRequestModificationBlockRule

+ (instancetype)ruleWithIsInterestRequestBlock:(CSNRequestModificationIsInterestRequestBlock)isInterestRequestBlock
                            modifyRequestBlock:(CSNRequestModificationModifyRequestBlock)modifyRequestBlock
{
    CSNRequestModificationBlockRule *rule = [[[self class] alloc] init];
    rule.isInterestRequestBlock = isInterestRequestBlock;
    rule.modifyRequestBlock = modifyRequestBlock;
    return rule;
}
- (BOOL)isInterestRequest:(NSURLRequest *)request
{
    if (self.isInterestRequestBlock) {
        return self.isInterestRequestBlock(request);
    }
    
    return NO;
}

- (void)modifyRequestForRequest:(NSURLRequest *)request modifiedRequest:(NSMutableURLRequest *)modifiedRequest
{
    if (self.modifyRequestBlock) {
        self.modifyRequestBlock(request, modifiedRequest);
    }
}

@end
