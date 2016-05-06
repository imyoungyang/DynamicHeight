//
//  UIColor+YDKHexPresentation.h
//  YDevelopKit
//
//  Created by Chih Feng Sung on 8/13/13.
//  Copyright (c) 2013 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YDKHexPresentation)

/**
 * @brief Create a color by hex format.
 *
 * @param red  Red channel value with hex NSUInteger.
 * @param green Green channel value with hex NSUInteger.
 * @param blue Blue channel value with hex NSUInteger.
 * @param alpha Alpha channel value with hex.
 *
 * @return The instance of UIColor.
 */
+ (UIColor *)YDKColorWithHexRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;

/**
 * @brief Create a color by hex format.
 *
 * @param red  Red channel value with hex NSUInteger.
 * @param green Green channel value with hex NSUInteger.
 * @param blue Blue channel value with hex NSUInteger.
 * @param alpha Alpha channel value with hex.
 *
 * @return The instance of UIColor.
 */
- (UIColor *)YDKInitWithHexRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;

/**
 * @brief Create a color by hex string.
 *
 * @param hexstring The value of hex NSString.
 *
 * @return The instance of UIColor.
 */
+ (UIColor *)YDKColorWithHexString:(NSString *)hexstring;

/**
 * @brief Create a color by hex string and alpha.
 *
 * @param hexstring The value of hex NSString.
 * @param alpha The value of alpha NSString.
 *
 * @return The instance of UIColor.
 */
+ (UIColor *)YDKColorWithHexString:(NSString *)hexstring alpha:(CGFloat)alpha;

/**
 * @brief Create a color by hex string.
 *
 * @param hexstring The value of hex NSString.
 *
 * @return The instance of UIColor.
 */
- (UIColor *)YDKInitWithHexString:(NSString *)hexstring;

/**
 * @brief Create a color by hex number.
 *
 * @param hexNumber The value of hex NSUInteger.
 *
 * @return The instance of UIColor.
 */
+ (UIColor *)YDKColorWithHexNumber:(NSUInteger)hexNumber;

/**
 * @brief Create a color by hex number.
 *
 * @param hexNumber The value of hex NSUInteger.
 *
 * @return The instance of UIColor.
 */
- (UIColor *)YDKInitWithHexNumber:(NSUInteger)hexNumber;

/**
 * @brief Shift saturation from exist color to create a new color.
 *
 * @param shiftValue The value of saturation needs to shift. 
 * Shift value can include positive or negative float and saturation must between 0.0f and 1.0f.
 *
 * @return The instance of UIColor.
 */
- (UIColor *)YDKColorShiftBySaturation:(CGFloat)shiftValue;

/**
 * @brief Shift brightness from exist color to create a new color. Shift value should be float.
 *
 * @param shiftValue The value of brightness needs to shift.
 * Shift value can include positive or negative float and brightness must between 0.0f and 1.0f.
 *
 * @return The instance of UIColor.
 */
- (UIColor *)YDKColorShiftByBrightness:(CGFloat)shiftValue;

/**
 * @brief comparing colors that are in different models/spaces
 *
 * @param anotherColor The UIColor which is comparing
 *
 * @return YES if they are the same one
 */
- (BOOL)YDKIsEqualToColor:(UIColor *)anotherColor;

/**
 * @brief Generate a HEX string for UIColor .
 *
 * @return A NSString with HEX format.
 */
- (NSString *)YDKHexString;

@end
