# Archiver
	
[![Version](https://img.shields.io/cocoapods/v/Archiver.svg?style=flat)](http://cocoapods.org/pods/Archiver)
[![License](https://img.shields.io/cocoapods/l/Archiver.svg?style=flat)](http://cocoapods.org/pods/Archiver)
[![Platform](https://img.shields.io/cocoapods/p/Archiver.svg?style=flat)](http://cocoapods.org/pods/Archiver)

### Summary

This class will read and write objects that conform to the NSCoding protocol to disk.

[AutoEncodeDecode](https://github.com/emailatravi/AutoEncodeDecode) provides persistance to any NSObject class with least effort.

### Sample Code

```
NSArray *nameWriteArray = @[@"Ravi", @"Manish"];
[Archiver createFile:nameWriteArray aFileName:@"Name_File"];
    
NSArray *nameReadArray = [Archiver readFile:@"Name_File"];
NSLog(@"%@", [nameReadArray componentsJoinedByString:@" : "]);
```
There is more in Example project.

### Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Installation

Archiver is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "Archiver"
```

### Author

Ravi Prakash Sahu, emailatravi@gmail.com

### License

Archiver is available under the MIT license. See the LICENSE file for more info.

### Inspiration
[NSObject-NSCoding](https://github.com/greenisus/NSObject-NSCoding)
