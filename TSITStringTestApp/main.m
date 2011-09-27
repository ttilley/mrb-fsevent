//
//  main.m
//  TSITStringTestApp
//
//  Created by Travis Tilley on 9/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import "../TSITString/TSICTString.h"
#import "../TSITString/TSITString.h"


int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSString* thisFile = [NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding];
        NSString* thisDir = [thisFile stringByDeletingLastPathComponent];
        NSString* plistPath = [thisDir stringByAppendingPathComponent:@"test.plist"];
        
        id object = [NSArray arrayWithContentsOfFile:plistPath];
        
//        for (int i=0; i < 1000; i++) {
//            @autoreleasepool {
//                CFDataRef data = TSICTStringCreateRenderedDataFromObjectWithFormat(object, kTSITStringFormatTNetstring);
//                CFRelease(data);
//            }
//        }
        
        for (int i=0; i < 1000; i++) {
            @autoreleasepool {
                NSData* data = [[TSITString dumpData:object] retain];
                [data release];
            }
        }
    }
    
    return 0;
}
