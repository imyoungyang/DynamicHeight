//
//  MSBaseViewController.m
//  abuMoviesDemo
//
//  Created by Young Yang on 3/28/16.
//  Copyright © 2016 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//

#import "MSBaseViewController.h"
#import <Foundation/Foundation.h>

@interface MSBaseViewController ()
@property (nonatomic, readwrite, getter=isVisible) BOOL visible;
@end

@implementation MSBaseViewController

- (instancetype)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // ref: http://stackoverflow.com/questions/19013975/ios-7-and-later-set-status-bar-style-per-view-controller
    if (self.navigationController) {
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.visible = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.visible = NO;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
