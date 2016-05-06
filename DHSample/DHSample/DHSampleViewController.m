//
//  DHSampleViewController.m
//  DHSample
//
//  Created by Young Yang on 5/6/16.
//  Copyright © 2016 Y.CORP.YAHOO.COM\youngbe. All rights reserved.
//

#import "DHSampleViewController.h"
#import "MSMovieBookingViewController.h"

@interface DHSampleViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray* yMSDemo;
@end

@implementation DHSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yMSDemo = [NSArray arrayWithObjects:@"DropDown - Dynamic Height Collection View", nil];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.yMSDemo count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.yMSDemo objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    switch (indexPath.row) {
        case 0: {
            MSMovieBookingViewController* vc = [[MSMovieBookingViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
