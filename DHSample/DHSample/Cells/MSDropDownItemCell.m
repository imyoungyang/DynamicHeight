//
//  MSBookingSubViewCell.m
//  abuMoviesDemo
//
//  Created by Young Yang on 5/5/16.
//  Copyright © 2016 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//

#import "MSDropDownItemCell.h"


NSString* const MSDropDownItemCellIdentifier = @"MSDropDownItemCell";

// title view
static CGFloat const kLeadingOfTitle = 16.5f;

// checked view
static CGFloat const kHeightOfCheckedView = 20.0f;
static CGFloat const kWidthOfCheckedView = 20.0f;
static CGFloat const kTrailingOfCheckedView = 16.0f;

@interface MSDropDownItemCell ()

@property (nonatomic, strong) UILabel* titleView;
@property (nonatomic, strong) UIImageView* checkedView;

@end

@implementation MSDropDownItemCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupComponents];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupComponents];
    }
    return self;
}

- (void)setupComponents
{
    [self setupTitleView];
    [self setupCheckedView];
    [self setupConstraints];
}

- (void)setupTitleView
{
    self.titleView = [[UILabel alloc] init];
    self.titleView.numberOfLines = 1;
    self.titleView.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleView.textColor = [UIColor whiteColor];
    self.titleView.font = [UIFont systemFontOfSize:16.0f];
    self.titleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleView];
}

- (void)setupCheckedView
{
    self.checkedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-Check"]];
    self.checkedView.contentMode = UIViewContentModeScaleAspectFill;
    self.checkedView.translatesAutoresizingMaskIntoConstraints = NO;
    self.checkedView.hidden = YES;
    [self.contentView addSubview:self.checkedView];
}

- (void)setupConstraints
{
    NSMutableArray* constraints = [[NSMutableArray alloc] init];

    // check view
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.checkedView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-kTrailingOfCheckedView]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.checkedView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kHeightOfCheckedView]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.checkedView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kWidthOfCheckedView]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.checkedView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];

    // title view
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:kLeadingOfTitle]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.checkedView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];

    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setTitle:(NSString*)title
{
    _title = title;
    self.titleView.text = _title;
}

- (void)setHideCheckedIcon:(BOOL)hideCheckedIcon
{
    _hideCheckedIcon = hideCheckedIcon;
    self.checkedView.hidden = _hideCheckedIcon;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.titleView.text = @"";
    self.checkedView.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
