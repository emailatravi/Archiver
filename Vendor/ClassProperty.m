//
//  ClassProperty.m
//  Archiver-Sample
//
//  Created by Ravi Prakash Sahu on 17/07/14.
//  Copyright 2014 Ravi Prakash Sahu. All rights reserved.
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

#import "ClassProperty.h"
#import <objc/runtime.h>

@interface ClassProperty ()

+ (ClassProperty*) sharedInstance;

@property (nonatomic, strong) NSCache *propertyCache;

- (void)addClassPropertyDictionaryToCache:(NSDictionary*)propertyDictionary forClass:(Class)aClass;
- (NSDictionary*)getClassPropertyDictionaryFromCache:(Class)aClass;

@end

@implementation ClassProperty

#pragma mark -
#pragma mark Singleton Methods

+ (ClassProperty*)sharedInstance {
    
	static ClassProperty *_sharedInstance;
	if(!_sharedInstance) {
		static dispatch_once_t oncePredicate;
		dispatch_once(&oncePredicate, ^{
			_sharedInstance = [[super allocWithZone:nil] init];
        });
    }
    
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    
	return [self sharedInstance];
}


- (id)copyWithZone:(NSZone *)zone {
	return self;
}

#if (!__has_feature(objc_arc))

- (id)retain {
    
	return self;
}

- (unsigned)retainCount {
	return UINT_MAX;  //denotes an object that cannot be released
}

- (oneway void)release {
	//do nothing
}

- (id)autorelease {
    
	return self;
}
#endif

#pragma mark -
#pragma mark Public Methods

+ (NSDictionary*)getPropertyDictionaryForClass:(Class)aObjectClass {
    // Check if the cache dictionary has the property dictionary for this class
    NSDictionary *_cachePropertyDictionary = [[ClassProperty sharedInstance] getClassPropertyDictionaryFromCache:aObjectClass];
    if (_cachePropertyDictionary) {
        return _cachePropertyDictionary;
    }
    else {
        NSMutableDictionary *_propertyDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
        // Check if we have any super class or not
        Class superClass = class_getSuperclass(aObjectClass);
        if (superClass != [NSObject class]) {
            [_propertyDictionary addEntriesFromDictionary:[ClassProperty getPropertyDictionaryForClass:superClass]];
        }
        u_int count;
        Ivar* ivars = class_copyIvarList(aObjectClass, &count);
        for (NSInteger i = 0; i < count ; i++)
        {
            const char* ivarName = ivar_getName(ivars[i]);
            const char* ivarType = ivar_getTypeEncoding(ivars[i]);
            NSString *propertyName = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
            NSString *propertyType = [NSString stringWithCString:ivarType encoding:NSUTF8StringEncoding];
            propertyType = [propertyType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            propertyType = [propertyType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            [_propertyDictionary setValue:propertyType forKey:propertyName];
        }
        free(ivars);
        
        if (_propertyDictionary) {
            [[ClassProperty sharedInstance] addClassPropertyDictionaryToCache:_propertyDictionary forClass:aObjectClass];
        }
        return _propertyDictionary;
    }
	return nil;
}

#pragma mark -
#pragma mark Private Methods

- (void)addClassPropertyDictionaryToCache:(NSDictionary*)propertyDictionary forClass:(Class)aClass {
    if (!self.propertyCache) {
        self.propertyCache = [NSCache new];
    }
    [self.propertyCache setObject:propertyDictionary forKey:NSStringFromClass(aClass)];
}

- (NSDictionary*)getClassPropertyDictionaryFromCache:(Class)aClass {
    NSString *className = NSStringFromClass(aClass);
    if (self.propertyCache && [self.propertyCache objectForKey:className]) {
        return [self.propertyCache objectForKey:className];
    }
    return nil;
}

@end
