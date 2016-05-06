//
//  MSHeaderView.h
//  abuMoviesDemo
//
//  Created by Young Yang on 4/8/16.
//  Copyright © 2016 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MSHeaderView;

@protocol MSHeaderViewDelegate <NSObject>

@required
- (void)headerView:(MSHeaderView*)headerView handleTapClose:(UIButton*)sender;

@end

@interface MSHeaderView : UIView

@property (nonatomic, strong) NSString* title;
@property (nonatomic, weak) id<MSHeaderViewDelegate> delegate;
@property (nonatomic, assign) BOOL enableGradientHeader;

@end