//
// Archiver.m
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Ravi Prakash Sahu
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
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
    
    for (NSInteger i = 0; i < [files count]; i++) {
        NSString *path = [documentsDirectory stringByAppendingPathComponent:[files objectAtIndex:i]];
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
