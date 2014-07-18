//
//  NSObject+NSCoding.m
//  Archiver-Sample
//
//  Created by Ravi Prakash Sahu on 17/07/14.
//  Copyright (c) 2014 Ravi Prakash Sahu. All rights reserved.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>
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
            // Check if @synthesise is not implemented.
            if (![self valueForKey:key]) {
                NSString *unSynthesizedKey = [[NSString alloc] initWithFormat:@"_%@", key];
                object_setInstanceVariable(self, [unSynthesizedKey UTF8String], value);
                [unSynthesizedKey release];
            }
        }
    }
}

@end
