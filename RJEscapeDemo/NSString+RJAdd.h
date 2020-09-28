//
//  NSString+RJAdd.h
//  RJEscapeDemo
//
//  Created by TouchWorld on 2020/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (RJAdd)

/// escape编码
/// @param str 要编码的字符串
/// return 编码后的字符串
+ (NSString *)rj_escapeEncode:(NSString *)str;

/// escape解码
/// @param str 要解码的字符串
/// @return 解码后的字符串
+ (NSString *)rj_escapeDecode:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
