//
//  AcromineAPIClient.h
//  AcromineTest
//
//  Created by PV Narasimham Peetla on 11/12/15.
//  Copyright © 2015 PV Narasimham. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

extern NSString * const kAcromineAPIKey;
extern NSString * const kAcromineBaseURLString;

@interface AcromineAPIClient : AFHTTPSessionManager

+ (AcromineAPIClient *)sharedClient;

- (void)getAbbreviationDefinitionsForQuery:(NSString *)query
                success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
