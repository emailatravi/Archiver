//
//  Archiver.m
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

#import "Archiver.h"
#include <sys/xattr.h>

@implementation Archiver

+ (id)readFile:(NSString *)aFileName {
    @try {
        NSString *filePath = [Archiver getFilePath:aFileName];
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    @catch (NSException *exception) {
        [Archiver deleteFile:aFileName];
    }
}

+ (id)readFileFromGivenPath:(NSString *)filePath{
    if (![filePath isKindOfClass:[NSString class]]) {
        return nil;
    }
    @try {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    @catch (NSException *exception) {
        [Archiver deleteFile:filePath];
    }
}

+ (NSDate*)createdOn:(NSString *)aFileName {
    NSString *filePath = [Archiver getFilePath:aFileName];
    
    NSFileManager *_fileManager = [NSFileManager defaultManager];
    NSError *_error = nil;
    NSDictionary *_fileAttributes = [_fileManager attributesOfItemAtPath:filePath error:&_error];
    if (_fileAttributes) {
        return [_fileAttributes fileCreationDate];
    }
    return nil;
}

+ (BOOL)fileExists:(NSString *)aFileName {
    NSString *filePath = [Archiver getFilePath:aFileName];
    NSFileManager *_fileManager = [NSFileManager defaultManager];
    return [_fileManager fileExistsAtPath:filePath];
}
// set a flag that the files shouldn't be backed up to iCloud.
// https://developer.apple.com/library/ios/#qa/qa1719/_index.html

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    if (&NSURLIsExcludedFromBackupKey == nil) { // iOS <= 5.0.1
        const char* filePath = [[URL path] fileSystemRepresentation];
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result == 0;
    } else { // iOS >= 5.1
        NSError *error = nil;
        [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
        return error == nil;
    }
}

+ (BOOL)createFile:(id)object aFileName:(NSString *)aFileName {
    @try {
        NSString  *filePath = [Archiver getFilePath:aFileName];
        if([NSKeyedArchiver archiveRootObject:object toFile:filePath])
        {
            [Archiver addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:filePath]];
            return YES;
        }
        else
        return NO;
    }
    @catch (NSException *exception) {
        [Archiver deleteFile:aFileName];
    }
}
+ (BOOL)createFileAtGivenPath:(id)object aFilePath:(NSString *)aFilePath{
    @try {
        if([NSKeyedArchiver archiveRootObject:object toFile:aFilePath])
        {
            [Archiver addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:aFilePath]];
            return YES;
        }
        else
        return NO;
    }
    @catch (NSException *exception) {
        [Archiver deleteFile:aFilePath];
    }
}

+ (BOOL)deleteFile:(NSString *)aFileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [Archiver getFilePath:aFileName];
    return [fileManager removeItemAtPath:filePath error:NULL];    
}

+ (BOOL)deleteEverything {
    BOOL result = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *files = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    
    for (int i = 0; i < [files count]; i++) {
        NSString *path = [files objectAtIndex:i];
        result = result && [fileManager removeItemAtPath:path error:NULL];
    }
    
    return result;
}

+ (NSString*)getFilePath:(NSString *)aFileName {
    if (aFileName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        return [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.archive", aFileName]];
    }
    return nil;
}

@end
