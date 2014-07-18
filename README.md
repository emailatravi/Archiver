Archiver
========

Objective C - Object Persistance .

These are some simple classes to make object persistence with NSCoding easier. 

Here the implementation is "Architecture Independent" to handle "Auto Encoding" and 
"Auto Decoding".

Encoding and Decoding as suggested by apple is quite lengthy if there are too many variables. Just to overcome this problem "Mike Mayo" suggested auto encoding and auto decoding. This code works fine in case of 32 Bit architecture. For 64 but architecture, the code breaks (needs some tweaking). 

Code inspiration came from https://github.com/greenisus/NSObject-NSCoding


