//
//  NSObject+NSCoding.m
//  Archiver-Sample
//
//  Created by Ravi Prakash Sahu on 17/07/14.
//  Copyright (c) 2014 Ravi Prakash Sahu. All rights reserved.
//

#import "NSObject+NSCoding.h"
#import <objc/runtime.h>
#import "ClassProperty.h"

@implementation NSObject (NSCoding)

- (void)autoEncodeWithCoder:(NSCoder *)coder {
    NSDictionary *properties = [ClassProperty propertyDictionary:[self class]];
    for (NSString *key in properties) {
        if ([self valueForKey:key]) {
            [coder encodeObject:[self valueForKey:key] forKey:key];
        }
    }
}

- (void)autoDecode:(NSCoder *)coder {
    NSDictionary *properties = [ClassProperty propertyDictionary:[self class]];
    for (NSString *key in properties) {
        id value = [coder decodeObjectForKey:key];
        if (value) {
            object_setInstanceVariable(self, [key UTF8String], value);
        }
    }
}

@end
