//
//  AcromineAPIClient.m
//  AcromineTest
//
//  Created by PV Narasimham Peetla on 11/12/15.
//  Copyright © 2015 PV Narasimham. All rights reserved.
//

#import "AcromineAPIClient.h"
#import "AcromineJSONResponseSerilizer.h"

// Set this to your Trakt API Key
#warning ADD YOUR ACROMINE API KEY HERE
NSString * const kAcromineAPIKey = @"PASTE YOUR API KEY HERE";
NSString * const kAcromineBaseURLString = @"http://www.nactem.ac.uk/";

@implementation AcromineAPIClient


+ (AcromineAPIClient *)sharedClient {
    static AcromineAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAcromineBaseURLString]];
    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AcromineJSONResponseSerilizer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    return self;
}

- (void)getAbbreviationDefinitionsForQuery:(NSString *)query
                                   success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                                   failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    

    NSString *path = @"software/acromine/dictionary.py";
    
    [self GET:path parameters:@{@"sf": query} success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];

    
}


@end
