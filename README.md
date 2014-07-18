Archiver
========

Objective C - Object Persistance .

These are some simple classes to make object persistence with NSCoding easier. 

Here the implementation is "Architecture Independent" to handle "Auto Encoding" and 
"Auto Decoding".

NSObject+NSCoding.h Usage
=========================

To the Class objects that needs persistance, follow the below mentioned:

@interface SomeModelClass : NSObject <NSCoding>

// Some variables

@end

@implementation SomeModelClass 

-(void)encodeWithCoder:(NSCoder *)coder {

    [self autoEncodeWithCoder:coder];
    
}

-(id)initWithCoder:(NSCoder *)coder {

    if (self = [super init]) {
        [self autoDecode:coder];
    }
    return self;
    
}

@end

And this is for the Lazy ones. Just inherit your model class by BaseModel.h and you are done.

Usage of BaseModel.h

@interface SomeModelClass : BaseModel

// Some variables

@end

@implementation SomeModelClass 

@end


Encoding and Decoding as suggested by apple is quite lengthy if there are too many variables. Just to overcome this problem "Mike Mayo" suggested auto encoding and auto decoding. This code works fine in case of 32 Bit architecture. For 64 but architecture, the code breaks (needs some tweaking). 

Code inspiration came from https://github.com/greenisus/NSObject-NSCoding

Some related information:
http://nshipster.com/nscoding/
https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Archiving/Archiving.html
