//
//  BaseModel.m
//  TOI
//
//  Created by Ravi Sahu on 09/10/13.
//  Copyright (c) 2014 Ravi Prakash Sahu. All rights reserved.
//

#import "BaseModel.h"
#import "NSObject+NSCoding.h"

@implementation BaseModel

- (void)encodeWithCoder:(NSCoder *)coder {
    [self autoEncodeWithCoder:coder];
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        [self autoDecode:coder];
    }
    return self;
}

@end
