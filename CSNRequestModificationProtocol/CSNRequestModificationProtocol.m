//
//  CSNRequestModificationProtocol.m
//  CSNRequestModificationProtocolDemo
//
//  Created by griffin_stewie on 2014/05/11.
//  Copyright (c) 2014年 net.cyan-stivy. All rights reserved.
//

#import "CSNRequestModificationProtocol.h"
#import <objc/runtime.h>

static NSString * const kCSNRequestModificationProtocolModifiedPropertyKey = @"CSNRequestModificationProtocolModifiedPropertyKey";

static char kInterestRulesKey;

@interface NSURLRequest (CSNRequestModificationProtocol)
- (NSArray *)csn_interestRules;
- (void)csn_setInterestRules:(NSArray *)rules;
@end

@implementation NSURLRequest (CSNRequestModificationProtocol)

- (NSArray *)csn_interestRules
{
    return (NSArray *)objc_getAssociatedObject(self, &kInterestRulesKey);
}

- (void)csn_setInterestRules:(NSArray *)rules
{
    objc_setAssociatedObject (self,
                              &kInterestRulesKey,
                              rules,
                              OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@interface CSNRequestModificationProtocol ( ) <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property (readwrite, nonatomic, strong) NSURLConnection *connection;
@end

@implementation CSNRequestModificationProtocol

+ (NSMutableArray *)registeredRules
{
    static NSMutableArray *_registeredRules = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _registeredRules = [[NSMutableArray alloc] init];
    });

    return _registeredRules;
}

+ (NSArray *)interestRulesForRequest:(NSURLRequest *)request
{
    NSMutableArray *interestRules = [NSMutableArray array];
    for (id <CSNRequestModificationRule> rule in [self registeredRules]) {
        if ([rule isInterestRequest:request]) {
            [interestRules addObject:rule];
        }
    }

    return [interestRules copy];
}

+ (BOOL)hasRuleForRequest:(NSURLRequest *)request
{
    NSArray *rules = [self interestRulesForRequest:request];

    return ([rules count]) ? YES : NO;
}

+ (void)addRule:(id <CSNRequestModificationRule>)rule
{
    [[self registeredRules] addObject:rule];
}

#pragma mark - NSURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    if ([NSURLProtocol propertyForKey:kCSNRequestModificationProtocolModifiedPropertyKey inRequest:request]) {
        return NO;
    }

    NSArray *interestRules = [self interestRulesForRequest:request];

    BOOL result = NO;

    if ([interestRules count]) {
        NSString *scheme = [[request URL] scheme];
        result = ([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame || [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame) ? YES : NO;
    }

    if (result) {
        [request csn_setInterestRules:interestRules];
    }

    return result;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    NSURLRequest *req = [NSURLProtocol propertyForKey:kCSNRequestModificationProtocolModifiedPropertyKey inRequest:request];
    if (req) {
        return req;
    }

    NSArray *rules = [request csn_interestRules];
    NSMutableURLRequest *mutableRequest = [request mutableCopy];

    if ([rules count]) {
        for (id <CSNRequestModificationRule> rule in rules) {
            [rule modifyRequestForRequest:request modifiedRequest:mutableRequest];
        }
    }

    [NSURLProtocol setProperty:@(YES) forKey:kCSNRequestModificationProtocolModifiedPropertyKey inRequest:mutableRequest];

    return mutableRequest;
}

- (void)startLoading
{
    self.connection = [[NSURLConnection alloc] initWithRequest:[[self class] canonicalRequestForRequest:self.request] delegate:self startImmediately:YES];
}

- (void)stopLoading
{
    [self.connection cancel];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    [[self client] URLProtocol:self didFailWithError:error];
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return YES;
}

- (void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [[self client] URLProtocol:self didReceiveAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection
didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [[self client] URLProtocol:self didCancelAuthenticationChallenge:challenge];
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:[[self request] cachePolicy]];
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    [[self client] URLProtocol:self didLoadData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[self client] URLProtocolDidFinishLoading:self];
}

@end