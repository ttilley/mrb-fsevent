//
//  TSITString.h
//  TSITString
//
//  Created by Travis Tilley on 9/27/11.
//

#import <Foundation/Foundation.h>
#import "TSICTString.h"

void Init_TSITString(void);

@interface TSITString : NSObject {
    @private
    TStringIRep* representation_;
}

@property(nonatomic, copy, readonly) NSString* taggedString;
@property(nonatomic, copy, readonly) NSData* taggedData;
@property(nonatomic, assign, readwrite) TSITStringFormat format;


+ (TSITStringFormat)defaultDataFormat;
+ (void)setDefaultDataFormat:(TSITStringFormat)format;

+ (NSString*)dump:(id)object;
+ (NSData*)dumpData:(id)object;


- (id)initWithRepresentation:(TStringIRep*)representation;

- (id)initWithObject:(id)object;

- (id)initWithObject:(id)object
           andFormat:(TSITStringFormat)format;

- (id)initWithString:(NSString*)string;

- (id)initWithString:(NSString*)string
           andFormat:(TSITStringFormat)format;

- (id)initWithNumber:(NSNumber*)number;

- (id)initWithNumber:(NSNumber*)number
           andFormat:(TSITStringFormat)format;

- (id)initWithArray:(NSArray*)array;

- (id)initWithArray:(NSArray*)array
          andFormat:(TSITStringFormat)format;

- (id)initWithDictionary:(NSDictionary*)dictionary;

- (id)initWithDictionary:(NSDictionary*)dictionary
               andFormat:(TSITStringFormat)format;

- (id)init;

@end

