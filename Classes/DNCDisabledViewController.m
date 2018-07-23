//
//  DNCDisabledViewController.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCDisabledViewController.h"

@interface DNCDisabledViewController ()

@end

@implementation DNCDisabledViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.activityIndicatorView)
    {
        [self initializeActivityIndicator];
    }
}

- (void)initializeActivityIndicator
{
    self.activityIndicatorView.tintColor    = UIColor.whiteColor;
    
    self.activityIndicatorView.alpha    = 1.0f;
    self.activityIndicatorView.hidden   = NO;
    [self.activityIndicatorView stopAnimating];
}

#pragma mark - Display logic

- (void)displaySpinner:(BOOL)show
{
    if (self.activityIndicatorView)
    {
        [self displaySpinnerActivityIndicator:show];
    }
}

- (void)displaySpinnerActivityIndicator:(BOOL)show
{
    if (show)
    {
        [self.activityIndicatorView startAnimating];
        
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:
         ^()
         {
             self.disabledView.alpha    = 1.0f;
         }
                         completion:nil];
    }
    else
    {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:
         ^()
         {
             self.disabledView.alpha    = 0.0f;
         }
                         completion:
         ^(BOOL finished)
         {
             [self.activityIndicatorView stopAnimating];
         }];
    }
}

@end
