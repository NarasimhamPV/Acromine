//
//  AcromineJSONResponseSerilizer.m
//  AcromineTest
//
//  Created by PV Narasimham Peetla on 11/12/15.
//  Copyright © 2015 PV Narasimham. All rights reserved.
//

#import "AcromineJSONResponseSerilizer.h"

@implementation AcromineJSONResponseSerilizer

- (id)init {
    self = [super init];
    if (self) {
        [self setAcceptableContentTypes:
         [NSSet setWithObjects:@"text/plain", @"application/json", nil]
         ];
    }
    
    return self;
}


@end
