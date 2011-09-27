//
//  TSITString.m
//  TSITString
//
//  Created by Travis Tilley on 9/27/11.
//

#import "TSITString.h"

void Init_TSITString(void){}

@interface TSITString ()
@property(nonatomic, assign, readwrite) TStringIRep* representation;
@end

@implementation TSITString

@synthesize representation = representation_;

+ (TSITStringFormat)defaultDataFormat
{
    return TSICTStringGetDefaultFormat();
}

+ (void)setDefaultDataFormat:(TSITStringFormat)format
{
    TSICTStringSetDefaultFormat(format);
}

+ (NSString*)dump:(id)object
{
    [object retain];
    
    CFStringRef cfString = TSICTStringCreateRenderedStringFromObjectWithFormat(object, kTSITStringFormatDefault);
    NSString* string = [[NSString alloc] initWithString:(NSString*)cfString];
    
    CFRelease(cfString);
    [object release];
    
    return [string autorelease];
}

+ (NSData*)dumpData:(id)object
{
    [object retain];
    
    CFDataRef cfData = TSICTStringCreateRenderedDataFromObjectWithFormat(object, kTSITStringFormatDefault);
    NSData* data = [[NSData alloc] initWithData:(NSData*)cfData];
    
    CFRelease(cfData);
    [object release];
    
    return [data autorelease];
}


- (NSString*)taggedString
{
    CFStringRef cfString = TSICTStringCreateRenderedString(representation_);
    NSString* string = [[NSString alloc] initWithString:(NSString*)cfString];
    CFRelease(cfString);
    return [string autorelease];
}

- (NSData*)taggedData
{
    CFDataRef cfData = TSICTStringCreateRenderedData(representation_);
    NSData* data = [[NSData alloc] initWithData:(NSData*)cfData];
    CFRelease(cfData);
    return [data autorelease];
}


- (id)initWithRepresentation:(TStringIRep*)representation
{
    self = [super init];
    if (self) {
        self.representation = representation;
    };
    
    return self;
}

- (void)dealloc
{
    TSICTStringDestroy(representation_);
    [super dealloc];
}

- (id)init
{
    TStringIRep* rep = TSICTStringCreateNullWithFormat(kTSITStringFormatDefault);
    return [self initWithRepresentation:rep];
}

- (id)initWithObject:(id)object
{
    TStringIRep* rep = TSICTStringCreateWithObjectAndFormat((CFTypeRef)object, kTSITStringFormatDefault);
    return [self initWithRepresentation:rep];
}

- (id)initWithObject:(id)object
           andFormat:(TSITStringFormat)format
{
    TStringIRep* rep = TSICTStringCreateWithObjectAndFormat((CFTypeRef)object, format);
    return [self initWithRepresentation:rep];
}

- (id)initWithString:(NSString*)string
{
    TStringIRep* rep = TSICTStringCreateWithStringAndFormat((CFStringRef)string, kTSITStringFormatDefault);
    return [self initWithRepresentation:rep];
}

- (id)initWithString:(NSString*)string
           andFormat:(TSITStringFormat)format
{
    TStringIRep* rep = TSICTStringCreateWithStringAndFormat((CFStringRef)string, format);
    return [self initWithRepresentation:rep];
}

- (id)initWithNumber:(NSNumber*)number
{
    TStringIRep* rep = TSICTStringCreateWithNumberAndFormat((CFNumberRef)number, kTSITStringFormatDefault);
    return [self initWithRepresentation:rep];
}

- (id)initWithNumber:(NSNumber*)number
           andFormat:(TSITStringFormat)format
{
    TStringIRep* rep = TSICTStringCreateWithNumberAndFormat((CFNumberRef)number, format);
    return [self initWithRepresentation:rep];
}

- (id)initWithArray:(NSArray*)array
{
    TStringIRep* rep = TSICTStringCreateWithArrayAndFormat((CFArrayRef)array, kTSITStringFormatDefault);
    return [self initWithRepresentation:rep];
}

- (id)initWithArray:(NSArray*)array
          andFormat:(TSITStringFormat)format
{
    TStringIRep* rep = TSICTStringCreateWithArrayAndFormat((CFArrayRef)array, format);
    return [self initWithRepresentation:rep];
}

- (id)initWithDictionary:(NSDictionary*)dictionary
{
    TStringIRep* rep = TSICTStringCreateWithDictionaryAndFormat((CFDictionaryRef)dictionary, kTSITStringFormatDefault);
    return [self initWithRepresentation:rep];
}

- (id)initWithDictionary:(NSDictionary*)dictionary
               andFormat:(TSITStringFormat)format
{
    TStringIRep* rep = TSICTStringCreateWithDictionaryAndFormat((CFDictionaryRef)dictionary, format);
    return [self initWithRepresentation:rep];
}


- (void)setFormat:(TSITStringFormat)format
{
    representation_->format = format;
}

- (TSITStringFormat)format
{
    return representation_->format;
}

@end

