//
//  UIColor+YDKHexPresentation.m
//  YDevelopKit
//
//  Created by Wei-Hon (Plasma) Chen on 8/13/13.
//  Copyright (c) 2013 Yahoo. All rights reserved.
//

#import "UIColor+YDKHexPresentation.h"

@implementation UIColor (YDKHexPresentation)

+ (UIColor *)YDKColorWithHexRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha
{
    return [[UIColor alloc] YDKInitWithHexRed:red green:green blue:blue alpha:alpha];
}

- (UIColor *)YDKInitWithHexRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha
{
    return [[UIColor alloc] initWithRed:red / (0xff*1.0f) green:green / (0xff*1.0f) blue:blue / (0xff*1.0f) alpha:alpha];
}

+ (UIColor *)YDKColorWithHexString:(NSString *)hexstring
{
    return [[UIColor alloc] YDKInitWithHexString:hexstring];
}

+ (UIColor *)YDKColorWithHexString:(NSString *)hexstring alpha:(CGFloat)alpha
{
    return [[UIColor YDKColorWithHexString:hexstring] colorWithAlphaComponent:alpha];
}

- (UIColor *)YDKInitWithHexString:(NSString *)hexstring
{
    NSUInteger rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexstring];
    if ( [hexstring hasPrefix:@"#"] ) {
        [scanner setScanLocation:1];
    }
    [scanner scanHexInt:(unsigned int *)&rgbValue];
    
    return [self YDKInitWithHexNumber:rgbValue];
}

+ (UIColor *)YDKColorWithHexNumber:(NSUInteger)hexNumber
{
    return [[UIColor alloc] YDKInitWithHexNumber:hexNumber];
}

- (UIColor *)YDKInitWithHexNumber:(NSUInteger)hexNumber
{
    CGFloat red   = ((hexNumber & 0xff0000) >> 16) / 255.0f;
    CGFloat green = ((hexNumber & 0x00ff00) >>  8) / 255.0f;
    CGFloat blue  = ((hexNumber & 0x0000ff)      ) / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

- (UIColor *)YDKColorShiftBySaturation:(CGFloat)shiftValue
{
    CGFloat hue, saturation, brightness, alpha;
    
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    saturation += shiftValue;
    saturation = MIN(saturation, 1.0f);
    saturation = MAX(saturation, 0.0f);
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

- (UIColor *)YDKColorShiftByBrightness:(CGFloat)shiftValue
{
    CGFloat hue, saturation, brightness, alpha;
    
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    brightness += shiftValue;
    brightness = MIN(brightness, 1.0f);
    brightness = MAX(brightness, 0.0f);
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

// reference to http://stackoverflow.com/questions/970475/how-to-compare-uicolors
- (BOOL)YDKIsEqualToColor:(UIColor *)anotherColor
{
    if (self == anotherColor)
        return YES;
    
    CGColorSpaceRef colorSpaceRGB = CGColorSpaceCreateDeviceRGB();
    
    UIColor *(^convertColorToRGBSpace)(UIColor*) = ^(UIColor *color)
    {
        if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) == kCGColorSpaceModelMonochrome)
        {
            const CGFloat *oldComponents = CGColorGetComponents(color.CGColor);
            CGFloat components[4] = {oldComponents[0], oldComponents[0], oldComponents[0], oldComponents[1]};
            CGColorRef colorRef = CGColorCreate(colorSpaceRGB, components);
            UIColor *color = [UIColor colorWithCGColor:colorRef];
            CGColorRelease(colorRef);
            return color;
        }
        else
            return color;
    };
    
    UIColor *selfColor = convertColorToRGBSpace(self);
    anotherColor = convertColorToRGBSpace(anotherColor);
    CGColorSpaceRelease(colorSpaceRGB);
    
    return [selfColor isEqual:anotherColor];
}

- (NSString *)YDKHexString
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);

    CGFloat red = components[0];
    CGFloat greeen = components[1];
    CGFloat blue = components[2];

    return [NSString stringWithFormat:@"%02lX%02lX%02lX", lroundf(red * 255), lroundf(greeen * 255), lroundf(blue * 255)];
}

@end
