//
//  MSDropDownViewCell.h
//  abuMoviesDemo
//
//  Created by Young Yang on 5/3/16.
//  Copyright © 2016 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const MSDropDownViewCellIdentifier;
@class MSDropDownViewCell;

@protocol MSDropDownViewCellDelegate <NSObject>

@optional

- (void)dropDownCellDidTapArrowView:(MSDropDownViewCell*)cell;

@end

@interface MSDropDownViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString* inputValue;
@property (nonatomic, assign) BOOL hideDropDownItems;
@property (nonatomic, assign) CGFloat minimumDropDownViewHeight;
@property (nonatomic, assign) CGFloat maximumDropDownViewHeight;
@property (nonatomic, weak) id<MSDropDownViewCellDelegate> delegate;

- (void)registerDropDownItemClass:(Class)cellClass forCellWithReuseIdentifier:(NSString*)identifier;
- (void)dropDownSectionInset:(UIEdgeInsets)dropDownSectionInset minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing itemSizeHeight:(CGFloat)itemSizeHeight numberOfColumns:(NSUInteger)columns;

@end
