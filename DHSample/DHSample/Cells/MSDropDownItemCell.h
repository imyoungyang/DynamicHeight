//
//  MSDropDownItemCell.h
//  abuMoviesDemo
//
//  Created by Young Yang on 5/5/16.
//  Copyright © 2016 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const MSDropDownItemCellIdentifier;

@interface MSDropDownItemCell : UICollectionViewCell

@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) BOOL hideCheckedIcon;

@end
