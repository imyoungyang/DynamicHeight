//
//  MSDropDownViewCell.m
//  abuMoviesDemo
//
//  Created by Young Yang on 5/3/16.
//  Copyright © 2016 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//

#import "MSDropDownViewCell.h"

#import "MSDropDownItemCell.h"
#import "UIColor+MSFormatter.h"

NSString* const MSDropDownViewCellIdentifier = @"MSDropDownViewCell";

static CGFloat const kBorderWidth = 1.0f;
static CGFloat const kCornerRadius = 2.5f;

// title view
static CGFloat const kLeadingOfTitle = 16.5f;
static CGFloat const kTopOfTitle = 17.5f;

// Arrow View
static CGFloat const kHeightOfArrowView = 8.0f;
static CGFloat const kWidthOfArrowView = 14.0f;
static CGFloat const kTrailingOfArrowView = 16.0f;
static CGFloat const kAnimationDuration = 0.2f;

@interface MSDropDownViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel* titleView;
@property (nonatomic, strong) UIImageView* arrowView;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout* collectionViewFlowLayout;
@property (nonatomic, strong) NSLayoutConstraint* constraintOfminimumDropDownViewHeight;

@end

@implementation MSDropDownViewCell

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
    [self setupArrowView];
    [self setupCollectionView];
    [self setupConstraints];
    [self setupGuestures];

    // add corner
    self.layer.borderColor = [UIColor MSDarkGrey].CGColor;
    self.layer.borderWidth = kBorderWidth;
    self.layer.cornerRadius = kCornerRadius;
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

- (void)setupArrowView
{
    self.arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-Arrow-Down"]];
    self.arrowView.contentMode = UIViewContentModeScaleAspectFill;
    self.arrowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.arrowView];
}

- (void)setupCollectionView
{
    // flow layout
    self.collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

    // collection view
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
    self.collectionView.backgroundColor = [UIColor purpleColor];
    self.collectionView.pagingEnabled = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;

    // register class
    [self.collectionView registerClass:[MSDropDownItemCell class] forCellWithReuseIdentifier:MSDropDownItemCellIdentifier];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.contentView addSubview:self.collectionView];
}

- (void)setupConstraints
{
    NSMutableArray* constraints = [[NSMutableArray alloc] init];

    // arrowView view
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.arrowView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-kTrailingOfArrowView]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.arrowView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kHeightOfArrowView]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.arrowView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kWidthOfArrowView]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.arrowView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];

    // title view
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:kLeadingOfTitle]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:kTopOfTitle]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.arrowView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];

    // collection view
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setupGuestures
{
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.arrowView setUserInteractionEnabled:YES];
    [self.arrowView addGestureRecognizer:singleTap];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.titleView.text = @"";
    self.hideDropDownItems = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - properties

- (void)setInputValue:(NSString*)inputValue
{
    _inputValue = inputValue;
    self.titleView.text = _inputValue;
}

- (void)setHideDropDownItems:(BOOL)hideDropDownItems
{
    _hideDropDownItems = hideDropDownItems;
    self.collectionView.hidden = _hideDropDownItems;
}

- (void)setMinimumDropDownViewHeight:(CGFloat)minimumDropDownViewHeight
{
    _minimumDropDownViewHeight = minimumDropDownViewHeight;
    if (self.constraintOfminimumDropDownViewHeight) {
        self.constraintOfminimumDropDownViewHeight.active = NO;
        self.constraintOfminimumDropDownViewHeight = nil;
    }
    self.constraintOfminimumDropDownViewHeight = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:_minimumDropDownViewHeight];
    self.constraintOfminimumDropDownViewHeight.active = YES;
}

#pragma mark - handle Single Tap for Arrow View

- (void)handleSingleTap:(UIGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.view == self.arrowView) {
        self.hideDropDownItems = !self.hideDropDownItems;
        self.collectionView.hidden = self.hideDropDownItems;
        if ([self.delegate respondsToSelector:@selector(dropDownCellDidTapArrowView:)]) {
            [self.delegate dropDownCellDidTapArrowView:self];
        }

        CGAffineTransform transform = self.hideDropDownItems ? CGAffineTransformIdentity : CGAffineTransformMakeRotation(M_PI);
        __weak MSDropDownViewCell* weakSelf = self;
        [UIView animateWithDuration:kAnimationDuration animations:^{
            weakSelf.arrowView.transform = transform;
        }];
    }
}

#pragma mark - handle Dynamic cell height

- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes
{
    if (self.collectionView.hidden) {
        return layoutAttributes;
    }

    [self layoutSubviews];

    // Calculated size
    CGRect frame = layoutAttributes.frame;
    if (self.collectionView.contentSize.height + self.minimumDropDownViewHeight > self.maximumDropDownViewHeight) {
        frame.size.height = self.maximumDropDownViewHeight;
    } else {
        frame.size.height = self.minimumDropDownViewHeight + self.collectionView.contentSize.height;
    }

    UICollectionViewLayoutAttributes* newAttributes = [layoutAttributes copy];
    newAttributes.frame = frame;
    return newAttributes;
}

#pragma mark - public function

- (void)registerDropDownItemClass:(Class)cellClass forCellWithReuseIdentifier:(NSString*)identifier
{
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (void)dropDownSectionInset:(UIEdgeInsets)dropDownSectionInset minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing itemSizeHeight:(CGFloat)itemSizeHeight numberOfColumns:(NSUInteger)columns
{
    self.collectionViewFlowLayout.sectionInset = dropDownSectionInset;
    self.collectionViewFlowLayout.minimumInteritemSpacing = minimumInteritemSpacing;
    self.collectionViewFlowLayout.minimumLineSpacing = minimumLineSpacing;
    if (columns == 0) {
        columns = 1;
    }
    CGFloat itemSizeWidth = (self.contentView.frame.size.width - dropDownSectionInset.left - dropDownSectionInset.right - minimumInteritemSpacing * (columns - 1)) / columns;
    self.collectionViewFlowLayout.itemSize = CGSizeMake(itemSizeWidth, itemSizeHeight);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    // FIXME: subclass must overwrite this function
    return 0;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    // FIXME: subclass must overwrite this function
    return 0;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    // FIXME: subclass must overwrite this function
    return nil;
}

@end
