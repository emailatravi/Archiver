//
//  NSObject+NSCoding.h
//  Archiver-Sample
//
//  Created by Ravi Prakash Sahu on 17/07/14.
//  Copyright (c) 2014 Ravi Prakash Sahu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSCoding)

- (void)autoEncodeWithCoder: (NSCoder *)coder;
- (void)autoDecode:(NSCoder *)coder;

@end
