//
//  Archiver.h
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
