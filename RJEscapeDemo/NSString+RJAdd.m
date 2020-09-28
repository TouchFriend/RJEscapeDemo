//
//  NSString+RJAdd.m
//  RJEscapeDemo
//
//  Created by TouchWorld on 2020/9/27.
//

#import "NSString+RJAdd.h"
#include <ctype.h>

@implementation NSString (RJAdd)

+ (NSString *)rj_escapeEncode:(NSString *)str {
    if (![str isKindOfClass:[NSString class]] && str.length == 0) {
        return nil;
    }
    
    NSMutableString *result = [NSMutableString string];
    for (NSInteger i = 0; i < str.length; i++) {
        unichar c  = [str characterAtIndex:i];
        if(isdigit(c) || isupper(c) || islower(c)) {
            [result appendFormat:@"%C", c];
        } else if(c < 256) {
            [result appendString:@"%"];
            if(c < 16) {
                [result appendString:@"0"];
            }
            [result appendFormat:@"%@", [self stringWithHexNumber:c]];
        } else {
            [result appendString:@"%u"];
            [result appendFormat:@"%@", [self stringWithHexNumber:c]];
        }
    }
    return [result copy];
}

+ (NSString *)rj_escapeDecode:(NSString *)str {
    if (![str isKindOfClass:[NSString class]] && str.length == 0) {
        return nil;
    }
    
    NSInteger lastPos = 0;
    NSInteger pos = 0;
    NSMutableString *tmp = [NSMutableString string];
    unichar ch;
    while(lastPos < str.length) {
        NSRange range = [str rangeOfString:@"%" options:NSLiteralSearch range:NSMakeRange(lastPos, str.length - lastPos)];
        pos = range.location != NSNotFound ? range.location : -1;
        if(pos == lastPos) {
            if([str characterAtIndex:pos + 1] == 'u'){
                NSString *ts = [str substringWithRange:NSMakeRange(pos + 2, 4)];
                ch = (unichar)[self numberWithHexString:ts];
                [tmp appendFormat:@"%C", ch];
                lastPos = pos + 6;
            } else {
                NSString *ts = [str substringWithRange:NSMakeRange(pos + 1, 2)];
                ch = (unichar)[self numberWithHexString:ts];
                [tmp appendFormat:@"%C", ch];
                lastPos = pos + 3;
            }
        } else {
            if(pos == -1) {
                NSString *ts = [str substringFromIndex:lastPos];
                [tmp appendString:ts];
                lastPos = str.length;
            } else {
                NSString *ts = [str substringWithRange:NSMakeRange(lastPos, pos - lastPos)];
                [tmp appendString:ts];
                lastPos  = pos;
            }
        }
    }
    return [tmp copy];
}

/// 10进制转16进制
/// @param hexNumber 10进制
/// @return 16进制字符串
+ (NSString *)stringWithHexNumber:(NSUInteger)hexNumber {
    char hexChar[40];
    sprintf(hexChar, "%lx", hexNumber);
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    return hexString;
}

/// 16进制转10进制
/// @param hexString 16进制字符串
/// @return 10进制数字
+ (NSInteger)numberWithHexString:(NSString *)hexString {
    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    NSInteger hexNumber;
    sscanf(hexChar, "%lx", &hexNumber);
    return hexNumber;
}

@end
