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
    
    return esp(str);
}

+ (NSString *)rj_escapeDecode:(NSString *)str {
    if (![str isKindOfClass:[NSString class]] && str.length == 0) {
        return nil;
    }
    return escapeDecoding(str);
}


NSString *esp(NSString *src){
    NSMutableString *result = [NSMutableString string];
    for (NSInteger i = 0; i < [src length] ; i++) {
        unichar c  = [src characterAtIndex:i];
        if(isdigit(c) || isupper(c) || islower(c)){
            [result appendFormat:@"%c", c];
        } else if((int)c <256){
            [result appendString:@"%"];
            if((int)c <16){
                [result appendString:@"0"];
            }
            [result appendFormat:@"%@", tohex((int)c)];
        } else {
            [result appendString:@"%u"];
            [result appendFormat:@"%@", tohex(c)];
        }
    }
    return [result copy];
}

NSString *escapeDecoding(NSString *src) {
    int lastPos = 0;
    int pos = 0;
    unichar ch;
    NSString * tmp = @"";
    while(lastPos<src.length) {
        NSRange range;
        
        range = [src rangeOfString:@"%" options:NSLiteralSearch range:NSMakeRange(lastPos, src.length-lastPos)];
        if (range.location != NSNotFound) {
            pos = (int)range.location;
        }else{
            pos = -1;
        }
        
        if(pos == lastPos){
            
            if([src characterAtIndex:(NSUInteger)(pos+1)]=='u'){
                NSString* ts = [src substringWithRange:NSMakeRange(pos+2,4)];
                
                int d = getIntStr(ts,4);
                ch = (unichar)d;
                tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%C",ch]];
                
                lastPos = pos+6;
                
            }else{
                NSString* ts = [src substringWithRange:NSMakeRange(pos+1,2)];
                int d = getIntStr(ts,2);
                ch = (unichar)d;
                tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%C",ch]];
                lastPos = pos+3;
            }
            
        }else{
            if(pos ==-1){
                NSString* ts = [src substringWithRange:NSMakeRange(lastPos,src.length-lastPos)];
                
                tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%@",ts]];
                lastPos = (int)src.length;
            }else{
                NSString* ts = [src substringWithRange:NSMakeRange(lastPos,pos-lastPos)];
                
                tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%@",ts]];
                lastPos  = pos;
            }
        }
    }
    
    return tmp;
}

Byte getInt(char c){
    if(c>='0'&&c<='9'){
        return c-'0';
    }else if((c>='a'&&c<='f')){
        return 10+(c-'a');
    }else if((c>='A'&&c<='F')){
        return 10+(c-'A');
    }
    return c;
}
int  getIntStr(NSString *src,int len){
    if(len==2){
        Byte c1 = getInt([src characterAtIndex:(NSUInteger)0]);
        Byte c2 = getInt([src characterAtIndex:(NSUInteger)1]);
        return ((c1&0x0f)<<4)|(c2&0x0f);
    }else{
        
        Byte c1 = getInt([src characterAtIndex:(NSUInteger)0]);
        
        Byte c2 = getInt([src characterAtIndex:(NSUInteger)1]);
        Byte c3 = getInt([src characterAtIndex:(NSUInteger)2]);
        Byte c4 = getInt([src characterAtIndex:(NSUInteger)3]);
        return( ((c1&0x0f)<<12)
               |((c2&0x0f)<<8)
               |((c3&0x0f)<<4)
               |(c4&0x0f));
    }
    
}

NSString * tohex(int tmpid)
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}

@end
