//
//  MSHeaderView.m
//  abuMoviesDemo
//
//  Created by Young Yang on 4/8/16.
//  Copyright © 2016 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//

#import "MSHeaderView.h"
#import "UIColor+MSFormatter.h"
//#import "abuMoviesConfig.h"

@interface MSHeaderView ()

@property (nonatomic, strong) CAGradientLayer* gradientLayer;
@property (nonatomic, strong) UILabel* navTitle;
@property (nonatomic, strong) UIButton* closeButton;

@end

@implementation MSHeaderView

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupComponents];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupComponents];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gradientLayer.frame = [UIScreen mainScreen].bounds;
    [self updateConstraintsIfNeeded];
}

#pragma mark - Private methods

- (void)setupComponents
{
    // gradient layer
    self.gradientLayer = [[CAGradientLayer alloc] init];
    self.enableGradientHeader = YES;

    // setup close button
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton = closeButton;
    UIImage* btnImage = [UIImage imageNamed:@"Icon-Close"];
    [closeButton setImage:btnImage forState:UIControlStateNormal];
    [self addSubview:closeButton];

    // Close Button layout attribute
    closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:closeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:40.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:closeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:40.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:closeButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:11.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:closeButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-9.0f].active = YES;

    // Add Navigtation title
    UILabel* navTitle = [[UILabel alloc] init];
    self.navTitle = navTitle;
    self.navTitle.numberOfLines = 1;
    self.navTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    self.navTitle.text = self.title;
    self.navTitle.textColor = [UIColor whiteColor];
    self.navTitle.font = [UIFont systemFontOfSize:16.0f];
    [self addSubview:navTitle];

    // Navigation title layout attribute
    navTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:navTitle attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:10.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:navTitle attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:navTitle attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:40.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:navTitle attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-40.0f].active = YES;
}

#pragma mark - Property methods

- (void)setTitle:(NSString*)title
{
    _title = title;
    self.navTitle.text = _title;
}

- (void)setDelegate:(id<MSHeaderViewDelegate>)delegate
{
    _delegate = delegate;

    if ([_delegate respondsToSelector:@selector(headerView:handleTapClose:)]) {
        [self.closeButton addTarget:_delegate
                             action:@selector(headerView:handleTapClose:)
                   forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setEnableGradientHeader:(BOOL)enableGradientHeader
{
    _enableGradientHeader = enableGradientHeader;
    if (_enableGradientHeader) {
        // add navigation background
        self.backgroundColor = [[UIColor MSNaviBlack] colorWithAlphaComponent:0.95f];

        // setup gradient mask layer
        UIColor* fromColor = [[UIColor MSLightPurple] colorWithAlphaComponent:0.7f];
        UIColor* endColor = [[UIColor MSDarkPurple] colorWithAlphaComponent:0.95f];

        self.gradientLayer.startPoint = CGPointMake(0.1f, 0.8f);
        self.gradientLayer.endPoint = CGPointMake(1.0f, 0.0f);
        self.gradientLayer.colors = @[
            (__bridge id)fromColor.CGColor,
            (__bridge id)endColor.CGColor
        ];

        [self.layer addSublayer:self.gradientLayer];
    } else {
        [self.gradientLayer removeFromSuperlayer];
        self.backgroundColor = nil;
    }
}

@end
