//
//  MSTheaterDropDown.m
//  abuMoviesDemo
//
//  Created by Young Yang on 5/5/16.
//  Copyright © 2016 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//

#import "MSDropDownItemCell.h"
#import "MSTheaterDropDownCell.h"

NSString* const MSTheaterDropDownIdentifier = @"MSTheaterDropDown";

static UIEdgeInsets const dropDownSectionInset = { 0.0f, 15.0f, 0.0f, 15.0f };
static CGFloat const kMinimumInteritemSpacing = 12.0f;
static CGFloat const kItemSizeHeight = 45.0f;

@implementation MSTheaterDropDownCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self dropDownSectionInset:dropDownSectionInset minimumInteritemSpacing:kMinimumInteritemSpacing minimumLineSpacing:0.0f itemSizeHeight:kItemSizeHeight numberOfColumns:1];
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
    return 30;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    MSDropDownItemCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:MSDropDownItemCellIdentifier forIndexPath:indexPath];

    // Configure the cell
    cell.backgroundColor = [UIColor blueColor];
    cell.title = @"《新天堂樂園》25週年數位修復版";
    cell.hideCheckedIcon = NO;

    return cell;
}

@end
