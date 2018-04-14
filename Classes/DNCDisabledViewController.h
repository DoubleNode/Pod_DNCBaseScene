//
//  DNCDisabledViewController.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import "DNCVisibleViewController.h"

@interface DNCDisabledViewController : DNCVisibleViewController

@property (weak, nonatomic) IBOutlet UIView*                    disabledView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView*   activityIndicatorView;

- (void)displaySpinner:(BOOL)show;

@end
