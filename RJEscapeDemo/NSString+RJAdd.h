//
//  NSString+RJAdd.h
//  RJEscapeDemo
//
//  Created by TouchWorld on 2020/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (RJAdd)

+ (NSString *)rj_escapeEncode:(NSString *)str;

+ (NSString *)rj_escapeDecode:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
