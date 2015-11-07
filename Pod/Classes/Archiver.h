//
// Archiver.h
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

#import <Foundation/Foundation.h>

/**
 *  Archiver class is used to read files using NSKeyedUnarchiver. This means that any class that is conforms to protocol NSCoding can be used to persist object to disk. Currently it only supports NSNumber, NSString, NSData, NSDate, NSDictionary, NSArray
 */
@interface Archiver : NSObject

/**
 *  Tells when the file exists or not. Searching takes under Documents Directory.
 *
 *  @param fileName File Name which is under Documents directory.
 *
 *  @return If the file is present, then YES is returned else NO.
 */
+ (BOOL)fileExists:(NSString *)fileName;

/**
 *  Tells when the file exists or not. Searching takes in the folderPath under Documents Directory.
 *
 *  @param fileName    File Name which in the folderPath under Documents Directory.
 *  @param folderPath   Path Name under Document directory where the fileName will be searched to read. If folderPath is nil, then search will be preformed under Documents directory
 *
 *  @return If the file is present, then YES is returned else NO.
 */
+ (BOOL)fileExists:(NSString *)fileName folderPath:(NSString*)folderPath;

/**
 *  Tells when the file was created. Searching takes under Documents Directory.
 *
 *  @param fileName File Name which is under Documents directory.
 *
 *  @return If the file is present, then its creation date is returned else nil.
 */
+ (NSDate*)createdOn:(NSString *)fileName;

/**
 *  Tells when the file was created. Searching takes in the folderPath under Documents Directory.
 *
 *  @param fileName File Name which in the folderPath under Documents Directory.
 *  @param folderPath      Path Name under Document directory where the fileName will be searched to read. If folderPath is nil, then search will be preformed under Documents directory
 *
 *  @return If the file is present, then its creation date is returned else nil.
 */
+ (NSDate*)createdOn:(NSString *)fileName folderPath:(NSString*)folderPath;

/**
 *  Tells when the file was modified. Searching takes under Documents Directory.
 *
 *  @param fileName File Name which is under Documents directory.
 *
 *  @return If the file is present, then its modification date is returned else nil.
 */
+ (NSDate*)modifiedOn:(NSString *)fileName;

/**
 *  Tells when the file was modified. Searching takes in the folderPath under Documents Directory.
 *
 *  @param fileName File Name which in the folderPath under Documents Directory.
 *  @param folderPath      Path Name under Document directory where the fileName will be searched to read. If folderPath is nil, then search will be preformed under Documents directory
 *
 *  @return If the file is present, then its modification date is returned else nil.
 */
+ (NSDate*)modifiedOn:(NSString *)fileName folderPath:(NSString*)folderPath;

/**
 *  Reads a file using NSKeyedUnarchiver in the Documents directory. If the provided file is present in the Documents directory and error occurs while reading the file, that file will be deleted (as the file is curroupt)
 *
 *  @param fileName File name that is un archived using NSKeyedUnarchiver.
 *
 *  @return Custom Object or NSArray, NSDictionary is case of sucessfull reading, in case of error nil is returned.
 */
+ (id)readFile:(NSString *)fileName;

/**
 *  Reads a file using NSKeyedUnarchiver in the file Path under Documents directory. If the provided file is present in the file Path under Documents directory and error occurs while reading the file, that file will be deleted (as the file is curroupt)
 *
 *  @param fileName File Name which in the folderPath under Documents Directory.
 *  @param folderPath      Path Name under Document directory where the fileName will be searched to read. If folderPath is nil, then search will be preformed under Documents directory
 *
 *  @return Custom Object or NSArray, NSDictionary is case of sucessfull reading, in case of error nil is returned.
 */
+ (id)readFile:(NSString *)fileName folderPath:(NSString*)folderPath;

/**
 *  Create a NSObject class which conforms to NSCoding to persistance.
 *
 *  @param object    Any object which conforms to NSCoding and is inhereted by NSObject
 *  @param fileName File Name which is under Documents directory.
 *
 *  @return If the file is created, return YES, else NO
 */
+ (BOOL)createFile:(id)object fileName:(NSString *)fileName;

/**
 *  Create a NSObject class which conforms to NSCoding to persistance.
 *
 *  @param object    Create a NSObject class which conforms to NSCoding to persistance.
 *  @param fileName File Name which in the folderPath under Documents Directory.
 *  @param folderPath      Path Name under Document directory where the fileName will be searched to read. If folderPath is nil, then search will be preformed under Documents directory
 *
 *  @return If the file is created, return YES, else NO
 */
+ (BOOL)createFile:(id)object fileName:(NSString *)fileName folderPath:(NSString*)folderPath;

/**
 *  Delete a file.
 *
 *  @param fileName File Name which is under Documents directory.
 *
 *  @return If deletion is sucessful, YES else NO.
 */
+ (BOOL)deleteFile:(NSString *)fileName;

/**
 *  Delete a file.
 *
 *  @param fileName File Name which in the folderPath under Documents Directory.
 *  @param folderPath      Path Name under Document directory where the fileName will be searched to read. If folderPath is nil, then search will be preformed under Documents directory
 *
 *  @return If deletion is sucessful, YES else NO.
 */
+ (BOOL)deleteFile:(NSString *)fileName folderPath:(NSString*)folderPath;

/**
 *  Get the file path under Documents Directory. It looks in the folder under Document directory.
 *
 *  @param fileName File Name which in the folderPath under Documents Directory.
 *
 *  @return File folderPath based on "fileName".
 */
+ (NSString*)getFilePath:(NSString *)fileName;

/**
 *  Get the file path with folderPath under Documents Directory. If folderPath is also provided, it looks in the folder under Document directory.
 *
 *  @param fileName File Name which in the folderPath under Documents Directory.
 *  @param folderPath      Path Name under Document directory where the fileName will be searched to read. If folderPath is nil, then search will be preformed under Documents directory
 *
 *  @return File folderPath based on "fileName" and "folderPath"
 */
+ (NSString*)getFilePath:(NSString *)fileName folderPath:(NSString*)folderPath;

/*
+ (id)readFileFromGivenPath:(NSString *)filePath;
+ (BOOL)createFileAtGivenPath:(id)object aFilePath:(NSString *)aFilePath;
+ (BOOL)deleteEverything;
 */

@end
