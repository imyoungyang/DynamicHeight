//
//  MSBaseViewController.h
//  abuMoviesDemo
//
//  Created by Young Yang on 3/28/16.
//  Copyright © 2016 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//
#import <UIKit/UIKit.h>

/*
  Common UIViewController subclass for shared functionality.
*/
@interface MSBaseViewController : UIViewController

@property (nonatomic, readonly, getter=isVisible) BOOL visible;

@end