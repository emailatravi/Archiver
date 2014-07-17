//
//  Person.h
//  Archiver-Sample
//
//  Created by Ravi Prakash Sahu on 17/07/14.
//  Copyright (c) 2014 Ravi Prakash Sahu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Languages;

@interface Person : NSObject <NSCoding>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *age;

@property (nonatomic, strong) NSArray *languages;

@end
