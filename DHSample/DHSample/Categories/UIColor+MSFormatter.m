//
//  NSColor+MSFormatter.m
//  abuMoviesDemo
//
//  Created by Young Yang on 4/8/16.
//  Copyright © 2016 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//

#import "UIColor+MSFormatter.h"
#import "UIColor+YDKHexPresentation.h"

@implementation UIColor (MSFormatter)

+ (UIColor*)MSDarkGrey
{
    // R:38 G:40 B:42
    return [UIColor YDKColorWithHexString:@"26282A"];
}

+ (UIColor*)MSDarkPurple
{
    // R:64 G:0 B:144
    return [UIColor YDKColorWithHexString:@"400090"];
}

+ (UIColor*)MSLightPurple
{
    // R:204 G:0 B:140
    return [UIColor YDKColorWithHexString:@"CC008C"];
}

+ (UIColor*)MSNaviBlack
{
    // R:31 G:18 B:50
    return [UIColor YDKColorWithHexString:@"1F1232"];
}

+ (UIColor*)MSLightBlue
{
    return [UIColor YDKColorWithHexString:@"0F69FF"];
}

+ (UIColor*)MSDisabledGray
{
    return [UIColor YDKColorWithHexString:@"9EA2AF"];
}

+ (UIColor*)MSDisabledBackgroundGray
{
    return [UIColor YDKColorWithHexString:@"E2E2E6"];
}

+ (UIColor*)MSCharcoalGrey
{
    // R:72 G:75 B:78
    return [UIColor YDKColorWithHexString:@"484B4E"];
}

+ (UIColor*)MSBackgrounodGray
{
    return [UIColor YDKColorWithHexString:@"2C2A3D"];
}

+ (UIColor*)MSTitleLabelWhite
{
    return [UIColor YDKColorWithHexString:@"B9BDC5"];
}

+ (UIColor*)MSClearBlue
{
    // R:24 G:143 B:255
    return [UIColor YDKColorWithHexString:@"188FFF"];
}

+ (UIColor*)MSScheduleBackgroundGray
{
    return [UIColor YDKColorWithHexString:@"535353"];
}

@end
