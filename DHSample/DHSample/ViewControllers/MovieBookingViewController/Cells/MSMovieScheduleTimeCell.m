//
//  MSMovieScheduleTimeCell.m
//  abuMoviesDemo
//
//  Created by Ray Chiang on 2016/4/28.
//  Copyright © 2016年 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//

#import "MSMovieScheduleTimeCell.h"

NSString* const MSMovieScheduleTimeCellIdentifier = @"MSMovieScheduleTimeCell";

static CGFloat const kBorderWidth = 1.0f;
static CGFloat const kCornerRadius = 3.0f;
static CGFloat const kLabelFontSize = 12.0f;

@implementation MSMovieScheduleTimeCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [self.timeLabel.font fontWithSize:kLabelFontSize];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.timeLabel];

        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = kBorderWidth;
        self.layer.cornerRadius = kCornerRadius;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize size = self.contentView.bounds.size;
    self.timeLabel.frame = CGRectMake(0, 0, size.width, size.height);
}

@end
