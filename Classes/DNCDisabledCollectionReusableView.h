//
//  DNCDisabledCollectionReusableView.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@interface DNCDisabledCollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIView*                    disabledView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView*   activityIndicatorView;

#pragma mark - Static Cell Type methods

+ (NSString*)reuseIdentifier;
+ (CGSize)suggestedSize;

#pragma mark - View lifecycle

- (void)cellDidLoad;
- (void)cellWillAppear;

#pragma mark - Display logic

- (void)displaySpinner:(BOOL)show;

@end
