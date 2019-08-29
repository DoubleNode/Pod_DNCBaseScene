//
//  DNCDisabledCollectionReusableView.h
//  DoubleNode Base Scene
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCBaseScene is released under the MIT license. See LICENSE for details.
//

#import "DNCDisabledCollectionReusableView.h"

@interface DNCDisabledCollectionReusableView ()

@end

@implementation DNCDisabledCollectionReusableView

#pragma mark - Static Cell Type methods

+ (NSString*)reuseIdentifier
{
    return @"DNCDisabledCollectionReusableView";
}

+ (CGSize)suggestedSize
{
    return (CGSize){ 100.0f, 100.0f };
}

#pragma mark - View lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self cellDidLoad];
    [self cellWillAppear];
}

- (void)cellDidLoad
{
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self cellWillAppear];
}

- (void)cellWillAppear
{
    [self initializeActivityIndicator];
}

- (void)initializeActivityIndicator
{
    if (!self.activityIndicatorView)
    {
        return;
    }
    
    self.activityIndicatorView.tintColor    = UIColor.whiteColor;
    
    self.activityIndicatorView.alpha    = 1.0f;
    self.activityIndicatorView.hidden   = NO;
    [self.activityIndicatorView stopAnimating];
}

#pragma mark - Display logic

- (void)displaySpinner:(BOOL)show
{
    if (!self.activityIndicatorView)
    {
        return;
    }
    
    [self displaySpinnerActivityIndicator:show];
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
