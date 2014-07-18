//
//  Archiver.h
//  OpenStack
//
//  Created by Mike Mayo on 10/4/10.
//  The OpenStack project is provided under the Apache 2.0 license.
//

#import <Foundation/Foundation.h>


@interface Archiver : NSObject {

}

+ (id)readFile:(NSString *)aFileName;
+ (id)readFileFromGivenPath:(NSString *)filePath;
+ (NSDate*)createdOn:(NSString *)aFileName;
+ (BOOL)fileExists:(NSString *)aFileName;
+ (BOOL)createFileAtGivenPath:(id)object aFilePath:(NSString *)aFilePath;
+ (BOOL)createFile:(id)object aFileName:(NSString *)aFileName;
+ (BOOL)deleteFile:(NSString *)aFileName;
+ (BOOL)deleteEverything;
+ (NSString*)getFilePath:(NSString *)aFileName;

@end
