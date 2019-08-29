//
//  DNCDisabledViewController.h
//  DoubleNode Base Scene
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCBaseScene is released under the MIT license. See LICENSE for details.
//

#import "DNCVisibleViewController.h"

@interface DNCDisabledViewController : DNCVisibleViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint*        disabledViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIView*                    disabledView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView*   activityIndicatorView;

- (void)displayHud:(BOOL)show
         withTitle:(NSString*)title;
- (void)displaySpinner:(BOOL)show;

@end
