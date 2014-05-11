//
//  CSNRequestModificationBlockRule.h
//  CSNRequestModificationProtocolDemo
//
//  Created by griffin_stewie on 2014/05/12.
//  Copyright (c) 2014年 net.cyan-stivy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNRequestModificationRule.h"

typedef BOOL(^CSNRequestModificationIsInterestRequestBlock)(NSURLRequest *request);
typedef void(^CSNRequestModificationModifyRequestBlock)(NSURLRequest *request, NSMutableURLRequest *modifiedRequest);

@interface CSNRequestModificationBlockRule : NSObject <CSNRequestModificationRule>
@property (nonatomic, copy) CSNRequestModificationIsInterestRequestBlock isInterestRequestBlock;
@property (nonatomic, copy) CSNRequestModificationModifyRequestBlock modifyRequestBlock;
+ (instancetype)ruleWithIsInterestRequestBlock:(CSNRequestModificationIsInterestRequestBlock)isInterestRequestBlock
                            modifyRequestBlock:(CSNRequestModificationModifyRequestBlock)modifyRequestBlock;
@end
