//
//  MSMovieDateDropDown.m
//  abuMoviesDemo
//
//  Created by Young Yang on 5/5/16.
//  Copyright © 2016 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//

#import "MSMovieDateDropDownCell.h"
#import "MSMovieScheduleTimeCell.h"

NSString* const MSMovieDateDropDownIdentifier = @"MSMovieDateDropDownCell";

static UIEdgeInsets const dropDownSectionInset = { 0.0f, 15.0f, 0.0f, 15.0f };
static CGFloat const kMinimumInteritemSpacing = 12.0f;
static CGFloat const kItemSizeHeight = 45.0f;

@implementation MSMovieDateDropDownCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerDropDownItemClass:[MSMovieScheduleTimeCell class] forCellWithReuseIdentifier:MSMovieScheduleTimeCellIdentifier];

        [self dropDownSectionInset:dropDownSectionInset minimumInteritemSpacing:kMinimumInteritemSpacing minimumLineSpacing:kMinimumInteritemSpacing itemSizeHeight:kItemSizeHeight numberOfColumns:2];
    }
    return self;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    // FIXME
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    // FIXME
    return 5;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    MSMovieScheduleTimeCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:MSMovieScheduleTimeCellIdentifier forIndexPath:indexPath];

    // Configure the cell
    cell.backgroundColor = [UIColor blueColor];
    cell.timeLabel.text = @"2016/5/1(日)";

    return cell;
}

@end
