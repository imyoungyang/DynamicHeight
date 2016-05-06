//
//  MSMovieBookingViewController.m
//  abuMoviesDemo
//
//  Created by Young Yang on 5/3/16.
//  Copyright © 2016 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//

#import "MSMovieBookingViewController.h"

#import "MSHeaderView.h"
#import "MSMovieDateDropDown.h"
#import "MSMovieDropDown.h"
#import "MSSessionDropDown.h"
#import "MSTheaterDropDown.h"
#import "UIColor+MSFormatter.h"
//#import "abuMoviesService.h"

static CGFloat const kHeightOfHeaderView = 64.0f;
static CGFloat const kHeightOfButtonView = 70.0f;

// collection view constraint const
static CGFloat const kMinimumInteritemSpacing = 10.0f;
static CGFloat const kItemSizeHeight = 57.5f;
static CGFloat const kTopSectionInset = 12.0f;
static CGFloat const kLeftRightSectionInset = 15.0f;

// confirm button
static CGFloat const kLeftRightInsetOfButton = 10.0f;
static CGFloat const kTopBottomInsetOfButton = 10.0f;
static CGFloat const kBorderWidth = 1.0f;
static CGFloat const kCornerRadius = 5.0f;

@interface MSMovieBookingViewController () <MSHeaderViewDelegate, MSDropDownViewCellDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) MSHeaderView* headerView;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout* collectionViewFlowLayout;
@property (nonatomic, strong) UIView* buttonView;
@property (nonatomic, strong) UIButton* buttonConfirm;

@end

@implementation MSMovieBookingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView
{
    [self setupHeaderView];
    [self setupCollectionView];
    [self setupButtonView];
    [self setupConstraints];
}

- (void)setupHeaderView
{
    self.headerView = [[MSHeaderView alloc] init];
    self.headerView.title = @"訂票"; // TRANSLATE
    self.headerView.delegate = self;
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.headerView];
}

- (void)setupCollectionView
{
    // flow layout
    self.collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(kTopSectionInset, kLeftRightSectionInset, 0.0f, kLeftRightSectionInset);
    self.collectionViewFlowLayout.minimumInteritemSpacing = kMinimumInteritemSpacing;
    self.collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionViewFlowLayout.estimatedItemSize = CGSizeMake(self.view.frame.size.width - kLeftRightSectionInset * 2, kItemSizeHeight);

    // collection view
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
    self.collectionView.backgroundColor = [UIColor MSDarkGrey];
    self.collectionView.pagingEnabled = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;

    // register class
    [self.collectionView registerClass:[MSTheaterDropDown class] forCellWithReuseIdentifier:MSTheaterDropDownIdentifier];
    [self.collectionView registerClass:[MSMovieDropDown class] forCellWithReuseIdentifier:MSMovieDropDownIdentifier];
    [self.collectionView registerClass:[MSMovieDateDropDown class] forCellWithReuseIdentifier:MSMovieDateDropDownIdentifier];
    [self.collectionView registerClass:[MSSessionDropDown class] forCellWithReuseIdentifier:MSSessionDropDownIdentifier];

    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reusedId];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.view insertSubview:self.collectionView aboveSubview:self.headerView];
}

- (void)setupButtonView
{
    self.buttonView = [[UIView alloc] init];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    self.buttonView.translatesAutoresizingMaskIntoConstraints = NO;

    self.buttonConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonConfirm addTarget:self
                           action:@selector(clickButtonConfirm:)
                 forControlEvents:UIControlEventTouchUpInside];
    self.buttonConfirm.backgroundColor = [UIColor MSClearBlue];
    [self.buttonConfirm setTitle:@"我要訂票" forState:UIControlStateNormal]; // TRANSLATE
    self.buttonConfirm.translatesAutoresizingMaskIntoConstraints = NO;

    self.buttonConfirm.layer.borderColor = [UIColor whiteColor].CGColor;
    self.buttonConfirm.layer.borderWidth = kBorderWidth;
    self.buttonConfirm.layer.cornerRadius = kCornerRadius;

    [self.buttonView addSubview:self.buttonConfirm];
    [self.view addSubview:self.buttonView];
}

- (void)setupConstraints
{
    NSMutableArray* constraints = [[NSMutableArray alloc] init];

    // header view
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kHeightOfHeaderView]];

    // collection view
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.buttonView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];

    // buttonView
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.buttonView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.buttonView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.buttonView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.buttonView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kHeightOfButtonView]];

    // confirm button
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.buttonConfirm attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.buttonView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:kLeftRightInsetOfButton]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.buttonConfirm attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.buttonView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-kLeftRightInsetOfButton]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.buttonConfirm attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.buttonView attribute:NSLayoutAttributeTop multiplier:1.0f constant:kTopBottomInsetOfButton]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.buttonConfirm attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.buttonView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-kTopBottomInsetOfButton]];

    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)clickButtonConfirm:(UIButton*)sender
{
    // FIXME: call ezding webview
    NSLog(@"click button confirm");
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.item >= [collectionView numberOfItemsInSection:indexPath.section]) {
        return nil;
    }

    switch (indexPath.item) {
    case 0: {
        MSTheaterDropDown* cell = [collectionView dequeueReusableCellWithReuseIdentifier:MSTheaterDropDownIdentifier forIndexPath:indexPath];
        cell.inputValue = @"選擇戲院";
        cell.minimumDropDownViewHeight = kItemSizeHeight;
        cell.maximumDropDownViewHeight = self.collectionView.frame.size.height - (kItemSizeHeight + kMinimumInteritemSpacing);
        cell.backgroundColor = [UIColor redColor];
        cell.hideDropDownItems = YES;
        cell.delegate = self;
        return cell;
    }
    case 1: {
        MSMovieDropDown* cell = (MSMovieDropDown*)[collectionView dequeueReusableCellWithReuseIdentifier:MSMovieDropDownIdentifier forIndexPath:indexPath];
        cell.minimumDropDownViewHeight = kItemSizeHeight;
        cell.maximumDropDownViewHeight = self.collectionView.frame.size.height - (kItemSizeHeight + kMinimumInteritemSpacing) * 2;
        cell.inputValue = @"選擇電影種類";
        cell.backgroundColor = [UIColor redColor];
        cell.hideDropDownItems = YES;
        cell.delegate = self;
        return cell;
    }
    case 2: {
        MSMovieDateDropDown* cell = (MSMovieDateDropDown*)[collectionView dequeueReusableCellWithReuseIdentifier:MSMovieDateDropDownIdentifier forIndexPath:indexPath];
        cell.minimumDropDownViewHeight = kItemSizeHeight;
        cell.maximumDropDownViewHeight = self.collectionView.frame.size.height - (kItemSizeHeight + kMinimumInteritemSpacing) * 3;
        cell.inputValue = @"選擇日期";
        cell.backgroundColor = [UIColor redColor];
        cell.hideDropDownItems = YES;
        cell.delegate = self;
        return cell;
    }
    case 3: {
        MSSessionDropDown* cell = (MSSessionDropDown*)[collectionView dequeueReusableCellWithReuseIdentifier:MSSessionDropDownIdentifier forIndexPath:indexPath];
        cell.minimumDropDownViewHeight = kItemSizeHeight;

        CGFloat maxHeight = self.collectionView.frame.size.height - (kItemSizeHeight + kMinimumInteritemSpacing) * 4;

        // Handle iPhone 4S
        if (maxHeight < 2 * kItemSizeHeight) {
            maxHeight = self.collectionView.frame.size.height - (kItemSizeHeight + kMinimumInteritemSpacing) * 3;
        }

        cell.maximumDropDownViewHeight = maxHeight;
        cell.inputValue = @"選擇場次";
        cell.backgroundColor = [UIColor redColor];
        cell.hideDropDownItems = YES;
        cell.delegate = self;
        return cell;
    }
    default:
        break;
    }
    return nil;
}

#pragma mark Header View Delegate

- (void)headerView:(MSHeaderView*)headerView handleTapClose:(UIButton*)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dropDownCellDidTapArrowView:(MSDropDownViewCell*)cell
{
    [self.collectionView
        performBatchUpdates:^{
            // no-op
        }
        completion:^(BOOL finished){
            // no-op
        }];
}

@end
