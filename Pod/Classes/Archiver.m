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

+ (BOOL)fileExists:(NSString *)fileName {
    return [Archiver fileExists:fileName folderPath:nil];
}

+ (BOOL)fileExists:(NSString *)fileName folderPath:(NSString*)folderPath {
    NSString *filePath = [Archiver getFilePath:fileName folderPath:folderPath];
    NSFileManager *_fileManager = [NSFileManager defaultManager];
    return [_fileManager fileExistsAtPath:filePath];
}

+ (NSDate*)createdOn:(NSString *)fileName {
    return [Archiver createdOn:fileName folderPath:nil];
}

+ (NSDate*)createdOn:(NSString *)fileName folderPath:(NSString*)folderPath {
    NSDictionary *_fileAttributes = [Archiver getAttributesForFileName:fileName folderPath:folderPath];
    if (_fileAttributes) {
        return [_fileAttributes fileCreationDate];
    }
    return nil;
}

+ (NSDate*)modifiedOn:(NSString *)fileName {
    return [Archiver modifiedOn:fileName folderPath:nil];
}

+ (NSDate*)modifiedOn:(NSString *)fileName folderPath:(NSString*)folderPath {
    NSDictionary *_fileAttributes = [Archiver getAttributesForFileName:fileName folderPath:folderPath];
    if (_fileAttributes) {
        return [_fileAttributes fileModificationDate];
    }
    return nil;
}

+ (id)readFile:(NSString *)fileName {
    return [Archiver readFile:fileName folderPath:nil];
}

+ (id)readFile:(NSString *)fileName folderPath:(NSString*)folderPath {
    @try {
        NSString *filePath = [Archiver getFilePath:fileName folderPath:folderPath];
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    @catch (NSException *exception) {
        [Archiver deleteFile:fileName];
    }
}

+ (BOOL)createFile:(id)object fileName:(NSString *)fileName {
    return [Archiver createFile:object fileName:fileName folderPath:nil];
}

+ (BOOL)createFile:(id)object fileName:(NSString *)fileName folderPath:(NSString*)folderPath {
    @try {
        NSString  *filePath = [Archiver getFilePath:fileName folderPath:folderPath];
        NSString *folderPath = [filePath stringByDeletingLastPathComponent];
        BOOL isDirectory = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:&isDirectory];
        if (!isDirectory) {
            [[NSFileManager defaultManager] createDirectoryAtPath:folderPath  withIntermediateDirectories:YES attributes:nil error:nil];
        }
        return [NSKeyedArchiver archiveRootObject:object toFile:filePath];
    }
    @catch (NSException *exception) {
        [Archiver deleteFile:fileName];
    }
}

+ (BOOL)deleteFile:(NSString *)fileName {
    return [Archiver deleteFile:fileName folderPath:nil];
}

+ (BOOL)deleteFile:(NSString *)fileName folderPath:(NSString*)folderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [Archiver getFilePath:fileName folderPath:folderPath];
    return [fileManager removeItemAtPath:filePath error:NULL];
}

+ (NSString*)getFilePath:(NSString *)fileName {
    return [Archiver getFilePath:fileName folderPath:nil];
}

+ (NSString*)getFilePath:(NSString *)fileName folderPath:(NSString*)folderPath {
    if (fileName) {
        NSString *directoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        if (folderPath) {
            directoryPath = [directoryPath stringByAppendingPathComponent:folderPath];
        }
        return [directoryPath stringByAppendingString:[NSString stringWithFormat:@"/%@", fileName]];
    }
    return nil;
}

#pragma mark - Non Public methods
+ (NSDictionary*)getAttributesForFileName:(NSString *)fileName folderPath:(NSString*)folderPath {
    NSString *filePath = [Archiver getFilePath:fileName folderPath:folderPath];
    NSFileManager *_fileManager = [NSFileManager defaultManager];
    NSError *_error = nil;
    NSDictionary *_fileAttributes = [_fileManager attributesOfItemAtPath:filePath error:&_error];
    if (!_error) return _fileAttributes;
    return nil;
}

#pragma mark - No use function

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

// set a flag that the files shouldn't be backed up to iCloud.
// https://developer.apple.com/library/ios/#qa/qa1719/_index.html

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    NSError *error = nil;
    [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    return error == nil;
}

@end
